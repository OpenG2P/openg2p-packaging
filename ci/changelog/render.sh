#!/usr/bin/env bash
#
# Write a version's human-readable page and regenerate the repo's CHANGELOG.md.
# Everything is markdown; Gitbook / GitHub Pages render it.
#
# Catalogue retention keeps the published page count bounded:
#
#   release  N.N.N           durable, ALL kept -- never pruned, however long the list
#   RC       N.N.N-rc.M      durable, last KEEP_RC per release line; KEPT after the
#                            release ships (the audit trail of that release run)
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
#        KEEP                  how many develop pages to keep (default 20)
#        KEEP_RC               how many RC pages to keep per line (default 10)
#        CHART_PACKAGE_URL     direct link to this version's packaged chart, so the
#                              page points at the artifact (open it to see exactly
#                              what the version contains -- pinned dependencies,
#                              image tags). Empty -> the line is omitted.
#        CHART_LABEL           what to call it, e.g. "openg2p-nsr 1.1.0"
#        PROMOTED_FROM         (frozen only) the build this release retags
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
KEEP="${KEEP:-20}"      # develop builds
KEEP_RC="${KEEP_RC:-10}"   # release candidates, per release line

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

# A version listed in <repo>/.marked has been declared known-good by hand ("Intermediate
# Stable Version" and the like). Retention must not delete it: the whole point of marking
# a build is that you can still find it later, and a develop page would otherwise age out
# after KEEP builds and take the mark with it. Marked pages live until unmarked.
marked_file="${repo_dir}/.marked"
is_marked() { [ -f "$marked_file" ] && grep -q "^${1}|" "$marked_file" 2>/dev/null; }

# Keep only the newest $2 pages named "<prefix>.<number>.md"; delete the rest.
prune() {   # $1 = filename prefix, $2 = how many to keep
  local prefix="$1" keep="$2" esc
  esc=$(printf '%s' "$prefix" | sed 's/[.]/\\./g')
  find "$vdir" -maxdepth 1 -type f -name "${prefix}.*.md" 2>/dev/null \
    | sed -E "s#.*/${esc}\.([0-9]+)\.md\$#\1 &#" \
    | grep -E '^[0-9]+ ' \
    | sort -rn \
    | awk -v k="$keep" 'NR>k{print $2}' \
    | while IFS= read -r f; do
        [ -n "$f" ] || continue
        is_marked "$(basename "$f" .md)" && continue   # marked -> exempt from retention
        rm -f "$f"
      done || true
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
  # Point at the artifact itself: everything a version actually contains -- its
  # pinned chart dependencies and image tags -- is inside the package.
  if [ -n "${CHART_PACKAGE_URL:-}" ]; then
    echo "**Chart:** [${CHART_LABEL:-download the chart}](${CHART_PACKAGE_URL})"
    echo
  fi
  # A trivial delta (0-1 commits) skips the AI summary: the commit list IS the summary.
  if [ "${SUMMARY_OMIT:-false}" != true ]; then
    echo "### Summary"
    echo
    printf '%s\n' "$summary"
    echo
  fi
  # Just "Changes" -- the italic line above already says what the range is measured
  # from, and repeating it in the heading reads as a stutter. Matches the release page,
  # which has always used a bare "### Changes".
  echo "### Changes"
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
      # The "Changes" below are cumulative since the previous RELEASE, which leaves one
      # question unanswered: does this release differ from the last candidate? It never
      # does -- a release retags the artifact built at its own commit. Say so, so nobody
      # has to guess whether something slipped in between the RC and the tag.
      if [ -n "${PROMOTED_FROM:-}" ]; then
        promoted_anchor=$(printf 'v-%s' "$(printf '%s' "$PROMOTED_FROM" | sed 's/[^A-Za-z0-9]/-/g')")
        echo "**Same artifact as [\`${PROMOTED_FROM}\`](#${promoted_anchor})** — built from the"
        echo "same commit and *promoted* (retagged), not rebuilt. No code changed between them."
        echo
      fi
      # Point at the artifact itself: everything a version actually contains --
      # its pinned chart dependencies and image tags -- is inside the package.
      if [ -n "${CHART_PACKAGE_URL:-}" ]; then
        echo "**Chart:** [${CHART_LABEL:-download the chart}](${CHART_PACKAGE_URL})"
        echo
      fi
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
    # RC pages are KEPT after the release ships: they are the audit trail of the
    # release run -- what changed between rc.N and rc.N+1 is exactly what QA needs
    # to look back at. They are pruned only by KEEP_RC, like any other build.
    ;;
  rc)
    delta_body "${disp} ${VERSION} — ${DATE}" > "${vdir}/${VERSION}.md"
    prune "${VERSION%-rc.*}-rc" "$KEEP_RC"   # last KEEP_RC RCs of this release line
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
    prune "0.0.0-develop" "$KEEP"
    ;;
esac

PAGES_DIR="$PAGES_DIR" REPO="$REPO" KEEP="$KEEP" KEEP_RC="$KEEP_RC" bash "$HERE/render-aggregate.sh"
echo "wrote ${repo_dir}/CHANGELOG.md (${MODE} ${VERSION})"
