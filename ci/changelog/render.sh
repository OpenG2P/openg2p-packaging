#!/usr/bin/env bash
#
# Write a version's human-readable page and regenerate the repo's CHANGELOG.md.
# Everything is markdown; Gitbook / GitHub Pages render it.
#
#   env: PAGES_DIR REPO VERSION REVISION PREV_VERSION DATE MODE(frozen|rc|unreleased)
#        NOTES_FILE            cumulative notes since PREV_VERSION (last release)
#        SUMMARY_FILE SUMMARY_OK
#   rc/unreleased also use:
#        INCR_NOTES_FILE       notes since the previous build (incremental)
#        PREV_BUILD            previous build's version string (may be empty)
#
# frozen     -> durable versions/<version>.md, cumulative since the previous release
# rc         -> durable versions/<version>.md, TWO diffs (kept per RC build, so you
#               can see what changed between release candidates)
# unreleased -> rolling versions/unreleased.md, TWO diffs (develop stream)
#
# rc/unreleased embed a hidden marker so the next build can diff against them.

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
rel_label="${PREV_VERSION:-the start}"

# Emit a two-diff body (Summary + New-in-this-build + Since-last-release).
two_diff_body() {   # $1 = heading line
  local incr_notes=""
  if [ -n "${INCR_NOTES_FILE:-}" ] && [ -s "$INCR_NOTES_FILE" ]; then
    incr_notes=$(bash "$HERE/linkify.sh" <"$INCR_NOTES_FILE")
  fi
  echo "## $1"
  echo
  local base="_commit \`${short_rev}\` · baseline: release ${rel_label}"
  [ -n "${PREV_BUILD:-}" ] && base="${base} · previous build ${PREV_BUILD}"
  echo "${base}_"
  echo "<!-- build:${VERSION} revision:${REVISION} -->"
  echo
  echo "### Summary"
  echo
  echo "_All changes since release ${rel_label}:_"
  echo
  printf '%s\n' "$summary"
  echo
  if [ -n "${PREV_BUILD:-}" ] && [ -n "$incr_notes" ] && [ "$incr_notes" != "$cum_notes" ]; then
    echo "### New in this build (since ${PREV_BUILD})"
    echo
    printf '%s\n' "$incr_notes"
    echo
  fi
  echo "### Since last release (${rel_label})"
  echo
  printf '%s\n' "$cum_notes"
}

case "$MODE" in
  frozen)
    {
      echo "## ${REPO} ${VERSION} — ${DATE}"
      echo
      if [ -n "${PREV_VERSION:-}" ]; then
        echo "_commit \`${short_rev}\` · changes since release ${PREV_VERSION}_"
      else
        echo "_commit \`${short_rev}\` · first release_"
      fi
      echo
      echo "### Summary"; echo
      printf '%s\n' "$summary"; echo
      echo "### Changes"; echo
      printf '%s\n' "$cum_notes"
    } > "${repo_dir}/versions/${VERSION}.md"
    # Clear develop's rolling page ONLY when this release is on the default
    # branch (tagged on develop / merged in) — its unreleased changes are now
    # released, so the stale page would double-list them. For a diverged
    # release-line tag we leave develop's page alone (CLEAR_UNRELEASED=false).
    [ "${CLEAR_UNRELEASED:-false}" = true ] && rm -f "${repo_dir}/versions/unreleased.md"
    ;;
  rc)
    two_diff_body "${REPO} ${VERSION} — ${DATE}" > "${repo_dir}/versions/${VERSION}.md"
    ;;
  *)  # unreleased (develop): rolling page
    two_diff_body "${REPO} — Unreleased (${VERSION}, ${DATE})" > "${repo_dir}/versions/unreleased.md"
    ;;
esac

PAGES_DIR="$PAGES_DIR" REPO="$REPO" bash "$HERE/render-aggregate.sh"
echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
