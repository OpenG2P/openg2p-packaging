#!/usr/bin/env bash
#
# Write a version's human-readable page and regenerate the repo's CHANGELOG.md.
# Everything is markdown; Gitbook / GitHub Pages render it.
#
# Catalogue retention (KEEP, default 10) keeps the published page count bounded:
#
#   release  N.N.N           durable, ALL kept
#   RC       N.N.N-rc.M      durable, last KEEP per release line; DELETED once that
#                            release N.N.N is published (the release supersedes them)
#   develop  0.0.0-develop.N durable, last KEEP kept
#
# Page shape: a RELEASE is cumulative (everything since the previous tag -- the "what
# shipped" view). A develop/RC page is a single DELTA since its baseline (previous
# build, or the branch point for the first RC of a line), which keeps each page and its
# summary short; the cumulative view is not repeated on every build.
#
#   env: PAGES_DIR REPO REPO_DISPLAY VERSION REVISION PREV_VERSION DATE TS MODE(…)
#        NOTES_FILE            the notes for THIS page's range (delta, or cumulative
#                              for a release)
#        BASE_LABEL            what the range is measured from, as shown on the page
#        SUMMARY_FILE SUMMARY_OK
#        SUMMARY_OMIT          true -> trivial delta, render no Summary section at all
#        RELEASE_NOTES_FILE    (frozen only) annotated-tag message -> "Release notes"
#        KEEP                  how many rc/develop pages to keep (default 10)
#   library (a library repo's non-tag build) also uses:
#        BRANCH                the moving branch being tracked (page id)
#        RECENT_FILE           the last KEEP commits, as a bullet list
#        KEEP                  how many recent commits to list (default 5)
#
# Pages embed a hidden `<!-- build:V revision:R ts:EPOCH -->` marker: the next
# build diffs against it, and the aggregate sorts the summary table by commit
# time (ts) so versions published on the same day still order correctly.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="${PAGES_DIR}/${REPO}"
vdir="${repo_dir}/versions"
mkdir -p "$vdir"
KEEP="${KEEP:-10}"

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
# What this page's notes are measured from (previous build / branch point / last tag).
base_label="${BASE_LABEL:-$rel_label}"

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

# Emit a single-delta body: what changed since BASE_LABEL, and nothing else. Develop and
# RC pages are deliberately NOT cumulative -- the cumulative "what shipped" view lives on
# the release page, and a per-build delta keeps the page (and its summary) readable.
delta_body() {   # $1 = heading line
  echo "## $1"
  echo
  echo "_commit \`${short_rev}\` · changes since ${base_label}${art}_"
  echo "${marker}"
  echo
  # A trivial delta (0-1 commits) skips the AI summary: the commit list IS the summary.
  if [ "${SUMMARY_OMIT:-false}" != true ]; then
    echo "### Summary"
    echo
    printf '%s\n' "$summary"
    echo
  fi
  echo "### Changes since ${base_label}"
  echo
  if [ -n "$cum_notes" ]; then
    printf '%s\n' "$cum_notes"
  else
    # e.g. a release line cut at the same commit as the last develop build.
    echo "_No new commits since ${base_label}._"
  fi
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
    delta_body "${disp} ${VERSION} — ${DATE}" > "${vdir}/${VERSION}.md"
    prune "${VERSION%-rc.*}-rc"        # keep the last KEEP RCs of this release line
    ;;
  library)
    # A library's moving branch: one ROLLING page per branch (regenerated each push),
    # keyed by the branch name; the identity of "what you get" is the tip SHA. Lists the
    # last KEEP commits + a summary since the last tag. No pruning (one page per branch).
    branch="${BRANCH:-$VERSION}"
    safe=$(printf '%s' "$branch" | sed 's#[^A-Za-z0-9._-]#-#g')   # filesystem-safe id
    {
      echo "## ${disp} — \`${branch}\` branch (${DATE})"
      echo
      echo "_moving branch · latest commit \`${short_rev}\` · baseline: ${rel_label}${art}_"
      echo "${marker}"
      echo
      echo "### Summary"
      echo
      echo "_Changes on \`${branch}\` since ${rel_label}:_"
      echo
      printf '%s\n' "$summary"
      echo
      echo "### Recent commits (latest ${KEEP})"
      echo
      if [ -n "${RECENT_FILE:-}" ] && [ -s "$RECENT_FILE" ]; then
        bash "$HERE/linkify.sh" <"$RECENT_FILE"
      else
        printf '%s\n' "$cum_notes"
      fi
    } > "${vdir}/branch-${safe}.md"
    ;;
  *)  # develop build (MODE=develop): durable per-N page, last KEEP kept
    delta_body "${disp} — develop ${VERSION} (${DATE})" > "${vdir}/${VERSION}.md"
    rm -f "${vdir}/unreleased.md"      # retire the legacy single rolling page
    prune "0.0.0-develop"
    ;;
esac

PAGES_DIR="$PAGES_DIR" REPO="$REPO" KEEP="$KEEP" bash "$HERE/render-aggregate.sh"
echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
