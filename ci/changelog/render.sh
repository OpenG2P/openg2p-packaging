#!/usr/bin/env bash
#
# Write a version's human-readable page and regenerate the repo's CHANGELOG.md.
# Everything is markdown; Gitbook / GitHub Pages render it.
#
#   env: PAGES_DIR REPO VERSION REVISION PREV_VERSION DATE MODE(frozen|unreleased)
#        NOTES_FILE            cumulative notes since PREV_VERSION (last release)
#        SUMMARY_FILE SUMMARY_OK
#   unreleased mode also uses:
#        INCR_NOTES_FILE       notes since the previous build (incremental)
#        PREV_BUILD            previous build's version string (may be empty)
#
# frozen    -> versions/<version>.md (cumulative since the previous release),
#              and the Unreleased page is cleared
# unreleased-> versions/unreleased.md showing BOTH diffs: "new in this build"
#              (since the previous build) and "since last release" (cumulative).
#              A hidden marker records this build so the next one can diff against it.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="${PAGES_DIR}/${REPO}"
mkdir -p "${repo_dir}/versions"

short_rev=$(printf '%s' "${REVISION:-}" | cut -c1-7)

if [ "${SUMMARY_OK:-false}" = true ] && [ -s "${SUMMARY_FILE:-/dev/null}" ]; then
  summary=$(bash "$HERE/linkify.sh" <"$SUMMARY_FILE")
else
  summary="_AI summary unavailable — re-run the workflow with \`changelog_regenerate=${VERSION}\` to generate it._"
fi

cum_notes=$(bash "$HERE/linkify.sh" <"$NOTES_FILE")

if [ "$MODE" = frozen ]; then
  {
    echo "## ${REPO} ${VERSION} — ${DATE}"
    echo
    if [ -n "${PREV_VERSION:-}" ]; then
      echo "_commit \`${short_rev}\` · changes since release ${PREV_VERSION}_"
    else
      echo "_commit \`${short_rev}\` · first release_"
    fi
    echo
    echo "### Summary"
    echo
    printf '%s\n' "$summary"
    echo
    echo "### Changes"
    echo
    printf '%s\n' "$cum_notes"
  } > "${repo_dir}/versions/${VERSION}.md"
  rm -f "${repo_dir}/versions/unreleased.md"

else
  rel_label="${PREV_VERSION:-the start}"
  incr_notes=""
  if [ -n "${INCR_NOTES_FILE:-}" ] && [ -s "$INCR_NOTES_FILE" ]; then
    incr_notes=$(bash "$HERE/linkify.sh" <"$INCR_NOTES_FILE")
  fi
  {
    echo "## ${REPO} — Unreleased (${VERSION}, ${DATE})"
    echo
    base="_commit \`${short_rev}\` · baseline: release ${rel_label}"
    [ -n "${PREV_BUILD:-}" ] && base="${base} · previous build ${PREV_BUILD}"
    echo "${base}_"
    # Hidden marker: lets the NEXT build compute "new in this build".
    echo "<!-- build:${VERSION} revision:${REVISION} -->"
    echo
    echo "### Summary"
    echo
    echo "_All changes since release ${rel_label}:_"
    echo
    printf '%s\n' "$summary"
    echo
    # Incremental section only when it adds information over the cumulative one
    # (i.e. there is a previous build and its delta differs from the whole range).
    if [ -n "${PREV_BUILD:-}" ] && [ -n "$incr_notes" ] && [ "$incr_notes" != "$cum_notes" ]; then
      echo "### New in this build (since ${PREV_BUILD})"
      echo
      printf '%s\n' "$incr_notes"
      echo
    fi
    echo "### Since last release (${rel_label})"
    echo
    printf '%s\n' "$cum_notes"
  } > "${repo_dir}/versions/unreleased.md"
fi

PAGES_DIR="$PAGES_DIR" REPO="$REPO" bash "$HERE/render-aggregate.sh"
echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
