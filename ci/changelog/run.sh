#!/usr/bin/env bash
#
# Orchestrate one changelog update, keeping the workflow YAML thin. Run from a
# checkout of the SOURCE repo, with the packaging gh-pages checked out at
# PAGES_DIR. Writes files under PAGES_DIR; the caller commits + pushes them.
#
#   env in:
#     REPO         folder name on gh-pages (e.g. consent-manager)
#     VERSION      derived artifact version
#     FROZEN       true on a release tag
#     REVISION     full commit sha
#     PAGES_DIR    checkout of the changelog gh-pages branch
#     DATE         YYYY-MM-DD (passed in, for reproducibility)
#     SKIP_AI      true -> commit messages only, no API call
#     REGEN_VERSION  non-empty -> re-summarise an existing page, nothing else
#     OPENROUTER_API_KEY / OPENROUTER_MODEL / OPENROUTER_FALLBACKS / MAX_TOKENS
#
#   env out (to GITHUB_OUTPUT if set):
#     published   true|false   (false = nothing to do this run)

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

out() { [ -n "${GITHUB_OUTPUT:-}" ] && printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"; printf '%s=%s\n' "$1" "$2"; }

# Record this repo's display name + links for the site. REPO is the FLAT folder key
# (filesystem/URL safe); REPO_DISPLAY keeps the subgroup path so a project at
# spar/spar shows as "spar/spar", not the flattened "spar-spar" (which reads like a
# literal repo name). The folder can't be reverse-mapped to a path once flattened,
# so both name and URLs are stored here and read back by render-aggregate /
# render-root-index. Defaults to REPO on forges without subgroups (GitHub).
REPO_DISPLAY="${REPO_DISPLAY:-$REPO}"
# kind = service (builds image/chart) | library (code consumed by git ref: no artifact,
# tracked by branch SHA + tag). render-root-index groups the catalogue by this.
CHANGELOG_KIND="${CHANGELOG_KIND:-service}"
# Retention: libraries list the last 5 commits on a branch; services keep the last 10
# develop builds AND the last 10 RCs per release line (RCs are the audit trail for a
# release, so they are kept as deep as develop).
if [ "$CHANGELOG_KIND" = library ]; then KEEP="${KEEP:-5}"; else KEEP="${KEEP:-10}"; fi
mkdir -p "${PAGES_DIR}/${REPO}"
{
  echo "name=${REPO_DISPLAY}"
  echo "kind=${CHANGELOG_KIND}"
  [ -n "${REPO_URL:-}" ]   && echo "repo=${REPO_URL}"
  [ -n "${IMAGES_URL:-}" ] && echo "images=${IMAGES_URL}"
} > "${PAGES_DIR}/${REPO}/.meta"

summarise_into() {   # $1 = notes file, $2 = summary out file; uses $DIGEST_FILE; sets SUMMARY_OK
  SUMMARY_OK=false
  if [ "${SKIP_AI:-false}" = true ]; then
    echo "::notice::AI summary skipped (changelog_skip_ai)"
    return
  fi
  if DIGEST_FILE="${DIGEST_FILE:-}" bash "$HERE/summarize.sh" <"$1" >"$2" 2>"$work/aierr"; then
    SUMMARY_OK=true
  else
    echo "::warning::AI summary unavailable: $(cat "$work/aierr")"
  fi
}

# ---- regenerate-only: backfill a summary on an already-published page --------
if [ -n "${REGEN_VERSION:-}" ]; then
  page="${PAGES_DIR}/${REPO}/versions/${REGEN_VERSION}.md"
  [ -f "$page" ] || { echo "::error::no changelog page for ${REPO} ${REGEN_VERSION}"; exit 1; }

  # The human notes are everything under "### Changes" — never regenerated.
  awk '/^### Changes/{f=1; next} f' "$page" | sed '/^[[:space:]]*$/d' >"$work/notes.md"
  [ -s "$work/notes.md" ] || { echo "::error::page has no Changes section to summarise"; exit 1; }

  summarise_into "$work/notes.md" "$work/summary.md"
  [ "$SUMMARY_OK" = true ] || { echo "::error::regenerate requested but AI still unavailable"; exit 1; }

  bash "$HERE/linkify.sh" <"$work/summary.md" >"$work/summary.linked" && mv "$work/summary.linked" "$work/summary.md"

  # Replace only the Summary section, preserve the rest verbatim.
  awk -v sf="$work/summary.md" '
    /^### Summary/ { print; print ""; while ((getline l < sf) > 0) print l; print ""; skip=1; next }
    /^### Changes/ { skip=0 }
    !skip || /^### / { print }
  ' "$page" >"$work/page.md"
  mv "$work/page.md" "$page"

  # Rebuild the aggregate from the edited pages.
  MODE=frozen PAGES_DIR="$PAGES_DIR" REPO="$REPO" VERSION="$REGEN_VERSION" \
    REVISION="" PREV_VERSION="" DATE="$DATE" \
    NOTES_FILE=/dev/null SUMMARY_FILE=/dev/null SUMMARY_OK=false \
    bash "$HERE/render-aggregate.sh"
  PAGES_DIR="$PAGES_DIR" bash "$HERE/render-root-index.sh"
  out published true
  exit 0
fi

# ---- normal path ------------------------------------------------------------
# Range lower bound = the last release reachable from HEAD, by commit topology
# (git describe finds the nearest ancestor tag). We accept BOTH the new bare
# `N.N.N` and legacy `vN.N.N` tags, so a repo migrating from the old convention
# baselines against its last old release and follows the new scheme forward.
# Pre-release tags (anything with a '-') are excluded. On a release build we also
# exclude the tag being cut, to capture "since the PREVIOUS release".
dargs=(--tags --abbrev=0 --exclude '*-*'
       --match '[0-9]*.[0-9]*.[0-9]*' --match 'v[0-9]*.[0-9]*.[0-9]*')
[ "${FROZEN:-false}" = true ] && dargs+=(--exclude "$VERSION")
FROM=$(git describe "${dargs[@]}" HEAD 2>/dev/null || true)
printf '%s' "$FROM" | grep -qE '^v?[0-9]+\.[0-9]+\.[0-9]+$' || FROM=""
PREV_VERSION="$FROM"

# Diverged-gitflow fallback: if no release tag is an ANCESTOR of HEAD but a
# release exists on a separate line (e.g. an old `v2.0.1` never merged back, or a
# release line never merged into develop), baseline at the merge-base — "changes
# since it branched from the release line" — instead of dumping the whole
# history. Applies to BOTH develop and frozen releases, so a release tagged on
# develop shows the same "since <last release>" baseline as develop does. On a
# frozen build we exclude the tag being cut from the candidates.
if [ -z "$FROM" ]; then
  latest_rel=$(git tag --list --sort=-v:refname 2>/dev/null \
    | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | grep -vx "$VERSION" | head -1 || true)
  if [ -n "$latest_rel" ]; then
    mb=$(git merge-base HEAD "$latest_rel" 2>/dev/null || true)
    if [ -n "$mb" ] && [ "$mb" != "$(git rev-parse HEAD)" ]; then
      FROM="$mb"
      PREV_VERSION="$latest_rel"
    fi
  fi
fi

# MODE decides the page shape:
#   frozen   -> durable versions/<version>.md, cumulative-only (a release / a tag)
#   rc       -> durable versions/<version>.md, two diffs (release candidate — last
#               few RC builds kept so you can see what changed rc-to-rc)
#   develop  -> durable versions/0.0.0-develop.N.md, two diffs (last few kept)
#   library  -> a library repo's non-tag build: one ROLLING page per branch, keyed by
#               branch (the identity is the commit SHA), listing the last KEEP commits
#               + a summary since the last tag. A library TAG is just a frozen release.
if [ "${CHANGELOG_KIND:-service}" = library ] && [ "${FROZEN:-false}" != true ]; then
  MODE=library
elif [ "${FROZEN:-false}" = true ]; then
  MODE=frozen
elif printf '%s' "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$'; then
  MODE=rc
else
  MODE=develop
fi

# A library's rolling branch page lists the last KEEP commits (not a since-last-build
# diff). Gather them once here; render.sh drops them into the page.
RECENT_FILE=""
if [ "$MODE" = library ]; then
  RANGE_LIMIT="${KEEP:-5}" RANGE_FROM="" RANGE_TO=HEAD \
    bash "$HERE/assemble.sh" >"$work/recent.md" || true
  RECENT_FILE="$work/recent.md"
fi

# ---------------------------------------------------------------- diff baseline
# What this page diffs against. A develop/RC page shows ONE delta -- the changes since
# the previous build -- NOT a cumulative "since the last release" list: the cumulative
# view belongs on the release page, and a per-build delta keeps each page (and its AI
# summary) short and readable. Resolution order:
#   1. the previous page of the SAME kind (previous develop build / previous RC)
#   2. FIRST RC on a new line -> the newest develop build that is an ANCESTOR
#   3. otherwise the last release tag, else the start of history
# A frozen release always takes (3): cumulative since the previous tag.
page_marker(){ grep -oE '<!-- build:[^ ]+ revision:[0-9a-f]+( ts:[0-9]+)? -->' "$1" 2>/dev/null \
  | head -1 | sed -E 's/<!-- build:([^ ]+) revision:([0-9a-f]+).*/\1 \2/'; }
# Usable as a baseline only if the commit is still in THIS branch's history (a reset or
# a rebase can strip it, and a develop build after the release line was cut is not one).
usable(){ [ -n "${1:-}" ] && git rev-parse -q --verify "${1}^{commit}" >/dev/null 2>&1 \
  && git merge-base --is-ancestor "$1" HEAD 2>/dev/null; }

vdir="${PAGES_DIR}/${REPO}/versions"
BASELINE=""; BASE_LABEL=""

prev_page=""
if [ "$MODE" = develop ]; then
  cur="${VERSION##*.}"; best=-1
  for f in "$vdir"/0.0.0-develop.*.md; do
    [ -e "$f" ] || continue
    m=$(basename "$f" .md); m="${m##*.}"
    case "$m" in ''|*[!0-9]*) continue ;; esac
    if [ "$m" -lt "$cur" ] && [ "$m" -gt "$best" ]; then best="$m"; prev_page="$f"; fi
  done
elif [ "$MODE" = rc ]; then
  target="${VERSION%-rc.*}"; cur="${VERSION##*-rc.}"; best=-1
  for f in "$vdir/${target}-rc."*.md; do
    [ -e "$f" ] || continue
    m=$(basename "$f" .md); m="${m##*-rc.}"
    case "$m" in ''|*[!0-9]*) continue ;; esac
    if [ "$m" -lt "$cur" ] && [ "$m" -gt "$best" ]; then best="$m"; prev_page="$f"; fi
  done
fi
if [ -n "$prev_page" ]; then
  set -- $(page_marker "$prev_page")
  if usable "${2:-}"; then BASELINE="$2"; BASE_LABEL="$1"; fi
fi

# First RC on a new release line: diff against the branch point. It must be the newest
# ANCESTOR develop build -- develop keeps moving after the line is cut, so simply taking
# the highest develop.N would diff against a commit this RC never contained.
if [ -z "$BASELINE" ] && [ "$MODE" = rc ]; then
  best=-1
  for f in "$vdir"/0.0.0-develop.*.md; do
    [ -e "$f" ] || continue
    m=$(basename "$f" .md); m="${m##*.}"
    case "$m" in ''|*[!0-9]*) continue ;; esac
    set -- $(page_marker "$f")
    usable "${2:-}" || continue
    if [ "$m" -gt "$best" ]; then best="$m"; BASELINE="$2"; BASE_LABEL="$1"; fi
  done
fi

# Fallback (and the normal path for a release, and for the first RC of a NEW patch line
# whose predecessor's RC pages were deleted when that release shipped).
if [ "$MODE" = frozen ] || [ -z "$BASELINE" ]; then
  BASELINE="$FROM"; BASE_LABEL="${PREV_VERSION:-}"
fi
[ -n "$BASE_LABEL" ] || BASE_LABEL="the start"

# ---- the notes for THIS page: exactly the range decided above
RANGE_FROM="$BASELINE" RANGE_TO=HEAD bash "$HERE/assemble.sh" >"$work/notes.md" || true

# An empty delta on develop means the pipeline re-ran on the same commit -- nothing to
# publish. An RC branched at the same commit as the last develop build legitimately has
# an empty delta and STILL gets its page (the version exists), as does a release.
if [ ! -s "$work/notes.md" ] && [ "$MODE" = develop ]; then
  echo "No new commits since ${BASE_LABEL}; nothing to publish."
  out published false
  exit 0
fi

# Structural digest of this page's range -- grounds the summary in what actually changed.
DIGEST_FILE=""
RANGE_FROM="$BASELINE" RANGE_TO=HEAD bash "$HERE/digest.sh" >"$work/digest.md" 2>/dev/null || true
[ -s "$work/digest.md" ] && DIGEST_FILE="$work/digest.md"

# Summarise -- except for a trivial delta: with per-build deltas a 0/1-commit page's
# "summary" would only restate the commit, so the commit list IS the summary. Releases
# (and library pages) always get one; their range is the whole cumulative story.
SUMMARY_OMIT=false
ncommits=$(grep -c '^- ' "$work/notes.md" 2>/dev/null || true); ncommits=${ncommits:-0}
if [ "$ncommits" -lt 2 ] && { [ "$MODE" = develop ] || [ "$MODE" = rc ]; }; then
  SUMMARY_OMIT=true; SUMMARY_OK=false
  echo "delta is ${ncommits} commit(s); skipping the AI summary"
else
  summarise_into "$work/notes.md" "$work/summary.md"
fi

# Commit time (epoch) -> the aggregate sorts the summary table by this, so versions
# published the same day still order correctly. Reproducible from the revision.
TS=$(git show -s --format=%ct "$REVISION" 2>/dev/null || echo 0)

# Release notes shown at the top of a release page. Two sources, in priority order:
#   1. An externally provided RELEASE_NOTES_FILE — the wrapper fetches the editable
#      platform Release description (GitLab Release / GitHub Release body). This lets
#      you refine notes AFTER cutting the release WITHOUT moving the tag: edit the
#      Release in the UI and re-run the pipeline on the tag. Every build/publish job
#      is idempotent, so only this changelog page changes.
#   2. Else the ANNOTATED tag's message (core git). An annotated tag is a real object
#      (objecttype=tag) carrying a message; a lightweight tag's ref points straight at
#      a commit (objecttype=commit) and is skipped, so a commit subject is never
#      mistaken for release notes. subject+body omits any PGP signature.
# Whichever wins is normalised (trailing spaces + surrounding blank lines trimmed).
# render.sh only emits the section for a frozen release, so a stray value is inert
# on develop/RC builds.
notes_src=""
if [ -n "${RELEASE_NOTES_FILE:-}" ] && [ -s "${RELEASE_NOTES_FILE}" ] \
   && grep -q '[^[:space:]]' "${RELEASE_NOTES_FILE}" 2>/dev/null; then
  notes_src="${RELEASE_NOTES_FILE}"   # editable platform Release description
elif [ "${FROZEN:-false}" = true ] \
   && [ "$(git for-each-ref "refs/tags/${VERSION}" --format='%(objecttype)' 2>/dev/null || true)" = tag ]; then
  git for-each-ref "refs/tags/${VERSION}" \
      --format='%(contents:subject)%0a%0a%(contents:body)' 2>/dev/null > "$work/tagmsg.md" || true
  notes_src="$work/tagmsg.md"
fi
RELEASE_NOTES_FILE=""
if [ -n "$notes_src" ] && [ -s "$notes_src" ]; then
  # Drop the hidden "publish link" footer the wrapper appends to an auto-created
  # GitLab Release (everything from the marker line on) so it never shows here, then
  # normalise. Absent on hand-written notes / other forges -> the cut is a no-op.
  awk '/<!-- openg2p:publish-link -->/{exit} {print}' "$notes_src" \
    | sed 's/[[:space:]]*$//' \
    | awk '{l[NR]=$0}
           END{s=1; while(s<=NR && l[s]~/^$/) s++;
               e=NR; while(e>=s && l[e]~/^$/) e--;
               for(i=s;i<=e;i++) print l[i]}' > "$work/relnotes.md"
  grep -q '[^[:space:]]' "$work/relnotes.md" 2>/dev/null && RELEASE_NOTES_FILE="$work/relnotes.md"
fi

PAGES_DIR="$PAGES_DIR" REPO="$REPO" REPO_DISPLAY="$REPO_DISPLAY" VERSION="$VERSION" REVISION="$REVISION" TS="$TS" \
  PREV_VERSION="$PREV_VERSION" DATE="$DATE" MODE="$MODE" \
  NOTES_FILE="$work/notes.md" SUMMARY_FILE="$work/summary.md" SUMMARY_OK="$SUMMARY_OK" \
  BASE_LABEL="$BASE_LABEL" SUMMARY_OMIT="$SUMMARY_OMIT" \
  RELEASE_NOTES_FILE="$RELEASE_NOTES_FILE" \
  BRANCH="${BRANCH:-}" RECENT_FILE="$RECENT_FILE" KEEP="$KEEP" \
  bash "$HERE/render.sh"

PAGES_DIR="$PAGES_DIR" bash "$HERE/render-root-index.sh"

out published true
