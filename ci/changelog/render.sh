#!/usr/bin/env bash
#
# Write a version's human-readable page and regenerate the repo's CHANGELOG.md.
# Everything is markdown; Gitbook / GitHub Pages render it.
#
# Catalogue retention (KEEP, default 3) keeps the published page count bounded:
#
#   release  N.N.N           durable, ALL kept
#   RC       N.N.N-rc.M      durable, last KEEP per release line; DELETED once that
#                            release N.N.N is published (the release supersedes them)
#   develop  0.0.0-develop.N durable, last KEEP kept (was a single rolling page)
#
#   env: PAGES_DIR REPO REPO_DISPLAY VERSION REVISION PREV_VERSION DATE TS MODE(…)
#        NOTES_FILE            cumulative notes since PREV_VERSION (last release)
#        SUMMARY_FILE SUMMARY_OK
#        RELEASE_NOTES_FILE    (frozen only) annotated-tag message -> "Release notes"
#   rc/develop also use:
#        INCR_NOTES_FILE       notes since the previous build (incremental)
#        PREV_BUILD            previous build's version string (may be empty)
#        KEEP                  how many rc/develop pages to keep (default 3)
#
# Pages embed a hidden `<!-- build:V revision:R ts:EPOCH -->` marker: the next
# build diffs against it, and the aggregate sorts the summary table by commit
# time (ts) so versions published on the same day still order correctly.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="${PAGES_DIR}/${REPO}"
vdir="${repo_dir}/versions"
mkdir -p "$vdir"
KEEP="${KEEP:-3}"

short_rev=$(printf '%s' "${REVISION:-}" | cut -c1-7)
marker="<!-- build:${VERSION} revision:${REVISION} ts:${TS:-0} -->"
# Display name in headings keeps subgroup slashes (spar/spar); REPO stays the flat
# folder key used for paths. Falls back to the folder key on forges without subgroups.
disp="${REPO_DISPLAY:-$REPO}"

if [ "${SUMMARY_OK:-false}" = true ] && [ -s "${SUMMARY_FILE:-/dev/null}" ]; then
  summary=$(bash "$HERE/linkify.sh" <"$SUMMARY_FILE")
else
  summary="_AI summary unavailable — re-run the workflow with \`changelog_regenerate=${VERSION}\` to generate it._"
fi

cum_notes=$(bash "$HERE/linkify.sh" <"$NOTES_FILE")
rel_label="${PREV_VERSION:-the start}"

# Where the artifacts for this version live (shown in the header). Empty -> hidden.
art=""
[ -n "${ARTIFACT_SOURCE:-}" ] && art=" · artifacts: \`${ARTIFACT_SOURCE}\`"

# Keep only the newest $KEEP pages named "<prefix>.<number>.md"; delete the rest.
prune() {
  local prefix="$1" esc
  esc=$(printf '%s' "$prefix" | sed 's/[.]/\\./g')
  find "$vdir" -maxdepth 1 -type f -name "${prefix}.*.md" 2>/dev/null \
    | sed -E "s#.*/${esc}\.([0-9]+)\.md\$#\1 &#" \
    | grep -E '^[0-9]+ ' \
    | sort -rn \
    | awk -v k="$KEEP" 'NR>k{print $2}' \
    | while IFS= read -r f; do [ -n "$f" ] && rm -f "$f"; done || true
}

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
  echo "${base}${art}_"
  echo "${marker}"
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
      echo "## ${disp} ${VERSION} — ${DATE}"
      echo
      echo "${marker}"
      echo
      if [ -n "${PREV_VERSION:-}" ]; then
        echo "_commit \`${short_rev}\` · changes since release ${PREV_VERSION}${art}_"
      else
        echo "_commit \`${short_rev}\` · first release${art}_"
      fi
      echo
      # Curated release notes from the annotated tag message (verbatim, Jira-linkified),
      # shown above the auto-generated summary. Absent for lightweight tags.
      if [ -n "${RELEASE_NOTES_FILE:-}" ] && [ -s "$RELEASE_NOTES_FILE" ]; then
        echo "### Release notes"; echo
        bash "$HERE/linkify.sh" <"$RELEASE_NOTES_FILE"; echo
      fi
      echo "### Summary"; echo
      printf '%s\n' "$summary"; echo
      echo "### Changes"; echo
      printf '%s\n' "$cum_notes"
    } > "${vdir}/${VERSION}.md"
    # This release supersedes its own RCs -> drop them from the catalogue. Develop
    # pages are LEFT ALONE: the last few develop builds stay visible even after a
    # release tagged on develop.
    rm -f "${vdir}/${VERSION}-rc."*.md
    ;;
  rc)
    two_diff_body "${disp} ${VERSION} — ${DATE}" > "${vdir}/${VERSION}.md"
    prune "${VERSION%-rc.*}-rc"        # keep the last KEEP RCs of this release line
    ;;
  *)  # develop build (MODE=develop): durable per-N page, last KEEP kept
    two_diff_body "${disp} — develop ${VERSION} (${DATE})" > "${vdir}/${VERSION}.md"
    rm -f "${vdir}/unreleased.md"      # retire the legacy single rolling page
    prune "0.0.0-develop"
    ;;
esac

PAGES_DIR="$PAGES_DIR" REPO="$REPO" KEEP="$KEEP" bash "$HERE/render-aggregate.sh"
echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
