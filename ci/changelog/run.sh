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

MODE=$([ "${FROZEN:-false}" = true ] && echo frozen || echo unreleased)

# Incremental notes for the rolling Unreleased page: what THIS build added since
# the previous build. The previous build's commit is recorded as a hidden marker
# in the existing unreleased.md.
PREV_BUILD=""
INCR_NOTES_FILE=""
if [ "$MODE" = unreleased ]; then
  existing="${PAGES_DIR}/${REPO}/versions/unreleased.md"
  if [ -f "$existing" ]; then
    marker=$(grep -oE '<!-- build:[^ ]+ revision:[0-9a-f]+ -->' "$existing" | head -1 || true)
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
fi

PAGES_DIR="$PAGES_DIR" REPO="$REPO" VERSION="$VERSION" REVISION="$REVISION" \
  PREV_VERSION="$PREV_VERSION" DATE="$DATE" MODE="$MODE" \
  NOTES_FILE="$work/notes.md" SUMMARY_FILE="$work/summary.md" SUMMARY_OK="$SUMMARY_OK" \
  INCR_NOTES_FILE="$INCR_NOTES_FILE" PREV_BUILD="$PREV_BUILD" \
  bash "$HERE/render.sh"

PAGES_DIR="$PAGES_DIR" bash "$HERE/render-root-index.sh"

out published true
