#!/usr/bin/env bash
#
# Write one human-readable markdown page for a version and regenerate the repo's
# aggregate CHANGELOG.md. Everything published is markdown — Gitbook points at
# CHANGELOG.md directly.
#
#   env: PAGES_DIR REPO VERSION REVISION PREV_VERSION DATE MODE(frozen|unreleased)
#        NOTES_FILE SUMMARY_FILE SUMMARY_OK
#
# frozen    -> versions/<version>.md, and the Unreleased page is cleared
# unreleased-> versions/unreleased.md (regenerated wholesale, never grows)

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="${PAGES_DIR}/${REPO}"
mkdir -p "${repo_dir}/versions"

notes=$(cat "$NOTES_FILE")
if [ "${SUMMARY_OK:-false}" = true ] && [ -s "${SUMMARY_FILE:-/dev/null}" ]; then
  summary=$(cat "$SUMMARY_FILE")
else
  summary="_AI summary unavailable — re-run the workflow with \`changelog_regenerate=${VERSION}\` to generate it._"
fi

short_rev=$(printf '%s' "${REVISION:-}" | cut -c1-7)

page() {   # heading passed as $1
  echo "## $1"
  echo
  if [ -n "${PREV_VERSION:-}" ]; then
    echo "_commit \`${short_rev}\` · changes since ${PREV_VERSION}_"
  else
    echo "_commit \`${short_rev}\`_"
  fi
  echo
  echo "### Summary"
  echo
  printf '%s\n' "$summary"
  echo
  echo "### Changes"
  echo
  printf '%s\n' "$notes"
}

if [ "$MODE" = frozen ]; then
  page "${REPO} ${VERSION} — ${DATE}" > "${repo_dir}/versions/${VERSION}.md"
  rm -f "${repo_dir}/versions/unreleased.md"
else
  page "${REPO} — Unreleased (${VERSION}, ${DATE})" > "${repo_dir}/versions/unreleased.md"
fi

# Aggregate: Unreleased first, then frozen releases newest-first.
PAGES_DIR="$PAGES_DIR" REPO="$REPO" bash "$HERE/render-aggregate.sh"

echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
