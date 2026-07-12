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
#     CHANGES_DIR  default: changes
#     SKIP_AI      true -> human notes only, no API call
#     REGEN_VERSION  non-empty -> re-summarise an existing page, nothing else
#     OPENROUTER_API_KEY / OPENROUTER_MODEL / OPENROUTER_FALLBACKS / MAX_TOKENS
#
#   env out (to GITHUB_OUTPUT if set):
#     published   true|false   (false = nothing to do this run)

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHANGES_DIR="${CHANGES_DIR:-changes}"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

out() { [ -n "${GITHUB_OUTPUT:-}" ] && printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"; printf '%s=%s\n' "$1" "$2"; }

summarise_into() {   # $1 = notes file, $2 = summary out file; sets SUMMARY_OK
  SUMMARY_OK=false
  if [ "${SKIP_AI:-false}" = true ]; then
    echo "::notice::AI summary skipped (changelog_skip_ai)"
    return
  fi
  if bash "$HERE/summarize.sh" <"$1" >"$2" 2>"$work/aierr"; then
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
  out published true
  exit 0
fi

# ---- normal path ------------------------------------------------------------
# Range lower bound = the last frozen release reachable from HEAD. On a release
# build, exclude the tag being cut so we capture "since the PREVIOUS release".
rels=$(git tag --list --merged HEAD --sort=-v:refname 2>/dev/null \
        | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' || true)
if [ "${FROZEN:-false}" = true ]; then
  rels=$(printf '%s\n' "$rels" | grep -vx "$VERSION" || true)
fi
FROM=$(printf '%s\n' "$rels" | sed '/^$/d' | head -1)
PREV_VERSION="$FROM"

RANGE_FROM="$FROM" RANGE_TO=HEAD CHANGES_DIR="$CHANGES_DIR" \
  bash "$HERE/assemble.sh" >"$work/notes.md" || true

if [ ! -s "$work/notes.md" ]; then
  echo "No new change notes since ${FROM:-start of history}; nothing to publish."
  out published false
  exit 0
fi

summarise_into "$work/notes.md" "$work/summary.md"

MODE=$([ "${FROZEN:-false}" = true ] && echo frozen || echo unreleased)
PAGES_DIR="$PAGES_DIR" REPO="$REPO" VERSION="$VERSION" REVISION="$REVISION" \
  PREV_VERSION="$PREV_VERSION" DATE="$DATE" MODE="$MODE" \
  NOTES_FILE="$work/notes.md" SUMMARY_FILE="$work/summary.md" SUMMARY_OK="$SUMMARY_OK" \
  bash "$HERE/render.sh"

out published true
