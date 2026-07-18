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
mkdir -p "${PAGES_DIR}/${REPO}"
{
  echo "name=${REPO_DISPLAY}"
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

# Cumulative notes: everything since the last release.
RANGE_FROM="$FROM" RANGE_TO=HEAD \
  bash "$HERE/assemble.sh" >"$work/notes.md" || true

if [ ! -s "$work/notes.md" ]; then
  echo "No new change notes since ${FROM:-start of history}; nothing to publish."
  out published false
  exit 0
fi

# Structural digest of the cumulative range — grounds the AI summary in what
# actually changed (bounded; empty when there is no release baseline).
DIGEST_FILE=""
RANGE_FROM="$FROM" RANGE_TO=HEAD bash "$HERE/digest.sh" >"$work/digest.md" 2>/dev/null || true
[ -s "$work/digest.md" ] && DIGEST_FILE="$work/digest.md"

summarise_into "$work/notes.md" "$work/summary.md"

# MODE decides the page shape:
#   frozen   -> durable versions/<version>.md, cumulative-only (a release)
#   rc       -> durable versions/<version>.md, two diffs (release candidate — last
#               few RC builds kept so you can see what changed rc-to-rc)
#   develop  -> durable versions/0.0.0-develop.N.md, two diffs (last few kept)
if [ "${FROZEN:-false}" = true ]; then
  MODE=frozen
elif printf '%s' "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$'; then
  MODE=rc
else
  MODE=develop
fi

# The incremental "new in this build" diff needs the PREVIOUS build's commit, read
# from a hidden marker. For develop it's the newest existing develop page; for an
# RC it's the previous RC of the same release line.
PREV_BUILD=""
INCR_NOTES_FILE=""
prev_page=""
if [ "$MODE" = develop ]; then
  cur="${VERSION##*.}"               # N in 0.0.0-develop.N
  best=-1
  for f in "${PAGES_DIR}/${REPO}/versions/0.0.0-develop."*.md; do
    [ -e "$f" ] || continue
    m=$(basename "$f" .md); m="${m##*.}"
    case "$m" in ''|*[!0-9]*) continue ;; esac
    if [ "$m" -lt "$cur" ] && [ "$m" -gt "$best" ]; then best="$m"; prev_page="$f"; fi
  done
elif [ "$MODE" = rc ]; then
  target="${VERSION%-rc.*}"          # 1.0.0
  cur="${VERSION##*-rc.}"            # 19
  best=-1
  for f in "${PAGES_DIR}/${REPO}/versions/${target}-rc."*.md; do
    [ -e "$f" ] || continue
    m=$(basename "$f" .md); m="${m##*-rc.}"
    case "$m" in ''|*[!0-9]*) continue ;; esac
    if [ "$m" -lt "$cur" ] && [ "$m" -gt "$best" ]; then best="$m"; prev_page="$f"; fi
  done
fi

# Commit time (epoch) -> the aggregate sorts the summary table by this, so versions
# published the same day still order correctly. Reproducible from the revision.
TS=$(git show -s --format=%ct "$REVISION" 2>/dev/null || echo 0)

if [ -n "$prev_page" ]; then
  marker=$(grep -oE '<!-- build:[^ ]+ revision:[0-9a-f]+( ts:[0-9]+)? -->' "$prev_page" | head -1 || true)
  if [ -n "$marker" ]; then
    PREV_BUILD=$(printf '%s' "$marker" | sed -E 's/.*build:([^ ]+) revision:.*/\1/')
    prev_rev=$(printf '%s' "$marker" | sed -E 's/.*revision:([0-9a-f]+).*/\1/')
    if [ -n "$prev_rev" ] && git rev-parse -q --verify "${prev_rev}^{commit}" >/dev/null 2>&1; then
      RANGE_FROM="$prev_rev" RANGE_TO=HEAD bash "$HERE/assemble.sh" >"$work/incr.md" || true
      INCR_NOTES_FILE="$work/incr.md"
    else
      PREV_BUILD=""   # previous build's commit not in history (e.g. after a reset)
    fi
  fi
fi

# Release notes: on a release build, surface the ANNOTATED tag's message verbatim
# at the top of the page (curated "what's in this release" prose). Core git — an
# annotated tag is a real object (objecttype=tag) carrying a message; a lightweight
# tag's ref points straight at a commit (objecttype=commit) and is skipped, so a
# commit subject is never mistaken for release notes. subject+body omits any PGP
# signature. Reachable because the release pipeline runs on the pushed tag.
RELEASE_NOTES_FILE=""
if [ "${FROZEN:-false}" = true ] \
   && [ "$(git for-each-ref "refs/tags/${VERSION}" --format='%(objecttype)' 2>/dev/null || true)" = tag ]; then
  git for-each-ref "refs/tags/${VERSION}" \
      --format='%(contents:subject)%0a%0a%(contents:body)' 2>/dev/null \
    | sed 's/[[:space:]]*$//' \
    | awk '{l[NR]=$0}
           END{s=1; while(s<=NR && l[s]~/^$/) s++;
               e=NR; while(e>=s && l[e]~/^$/) e--;
               for(i=s;i<=e;i++) print l[i]}' > "$work/relnotes.md" || true
  grep -q '[^[:space:]]' "$work/relnotes.md" 2>/dev/null && RELEASE_NOTES_FILE="$work/relnotes.md"
fi

PAGES_DIR="$PAGES_DIR" REPO="$REPO" REPO_DISPLAY="$REPO_DISPLAY" VERSION="$VERSION" REVISION="$REVISION" TS="$TS" \
  PREV_VERSION="$PREV_VERSION" DATE="$DATE" MODE="$MODE" \
  NOTES_FILE="$work/notes.md" SUMMARY_FILE="$work/summary.md" SUMMARY_OK="$SUMMARY_OK" \
  INCR_NOTES_FILE="$INCR_NOTES_FILE" PREV_BUILD="$PREV_BUILD" \
  RELEASE_NOTES_FILE="$RELEASE_NOTES_FILE" \
  bash "$HERE/render.sh"

PAGES_DIR="$PAGES_DIR" bash "$HERE/render-root-index.sh"

out published true
