#!/usr/bin/env bash
#
# Regenerate a repo's aggregate CHANGELOG.md from its per-version pages.
# Wholesale rebuild (never appended), so parallel branches cannot make it
# diverge, and pruned pages drop off automatically. Layout:
#
#   1. a summary TABLE of every kept version (Version | Date | Type), newest-first
#      BY COMMIT TIME (the `ts` marker) so versions published the same day still
#      order correctly
#   2. Releases            — N.N.N pages (all kept), newest-first
#   3. Release candidates  — RC pages whose release is not yet published (last few)
#   4. Develop builds      — 0.0.0-develop.N pages (last few)
#
#   env: PAGES_DIR REPO

set -euo pipefail

repo_dir="${PAGES_DIR}/${REPO}"
vdir="${repo_dir}/versions"
KEEP="${KEEP:-10}"   # matches run.sh's service default; render.sh passes the real value
[ -d "$vdir" ] || { echo "no versions/ for ${REPO}"; exit 0; }

list_versions() { ls "$vdir" 2>/dev/null | sed 's/\.md$//'; }

# Release pages: bare N.N.N and legacy v-prefixed vN.N.N (some libraries still tag v…).
frozen=$(list_versions | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | sort -rV || true)
develop=$(list_versions | grep -E '^0\.0\.0-develop\.[0-9]+$' | sort -t. -k4,4rn || true)
# Library repos: one rolling page per tracked branch (branch-<name>.md). Empty for
# services, so the branch table rows + section simply don't appear for them.
branches=$(list_versions | grep -E '^branch-' | sort || true)

kind=$(grep -m1 '^kind=' "${repo_dir}/.meta" 2>/dev/null | sed 's/^kind=//' || true)
[ -n "$kind" ] || kind=service

rcs_all=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$' || true)
inprogress=""
while IFS= read -r v; do
  [ -n "$v" ] || continue
  [ -f "${vdir}/${v%-rc.*}.md" ] && continue     # released -> hidden (also deleted at release)
  inprogress="${inprogress}${v}"$'\n'
done <<EOF
$rcs_all
EOF
inprogress=$(printf '%s' "$inprogress" | sed '/^$/d' | sort -rV || true)

# A YYYY-MM-DD from a page's heading, or em dash.
pdate() { grep -m1 '^## ' "$1" 2>/dev/null | grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}' | head -1; }
# The commit-time epoch embedded in the page's marker (sort key).
pts()   { grep -m1 -oE 'ts:[0-9]+' "$1" 2>/dev/null | sed 's/^ts://'; }
# A stable HTML-anchor id for a version (so the table can link to its section).
anchor() { printf 'v-%s' "$(printf '%s' "$1" | sed 's/[^A-Za-z0-9]/-/g')"; }

# Print one section: an anchored dump of each version's page.
section() {  # $1 = heading  $2 = newline list of versions
  [ -n "$2" ] || return 0
  echo "# $1"; echo
  printf '%s\n' "$2" | while IFS= read -r v; do
    [ -n "$v" ] || continue
    echo "<a id=\"$(anchor "$v")\"></a>"
    echo
    cat "${vdir}/${v}.md"; echo
  done
}

{
  # Display name keeps subgroup slashes (spar/spar) from .meta; folder key is flat.
  disp=$(grep -m1 '^name=' "${repo_dir}/.meta" 2>/dev/null | sed 's/^name=//' || true)
  [ -n "$disp" ] || disp="$REPO"
  echo "# ${disp}"
  echo
  echo "_Published automatically._"
  echo
  # Links to the source repo + its container registry (from .meta, written by the
  # changelog run). Reaches the GitLab/GitHub repo from under each repo's page.
  repo_url=$(grep -m1 '^repo=' "${repo_dir}/.meta" 2>/dev/null | sed 's/^repo=//' || true)
  images_url=$(grep -m1 '^images=' "${repo_dir}/.meta" 2>/dev/null | sed 's/^images=//' || true)
  if [ -n "$repo_url" ] || [ -n "$images_url" ]; then
    line=""
    [ -n "$repo_url" ] && line="**Repository:** [${repo_url#*://}](${repo_url})"
    [ -n "$images_url" ] && line="${line:+${line} · }**Container images:** [Container Registry](${images_url})"
    echo "$line"
    echo
  fi

  # ---- summary table, newest-first by commit time (ts) across ALL kinds ----
  # Emitting releases, then RCs, then develop would bury a fresh develop build
  # under an older release; rows are collected as "ts|date|version|type" and
  # reverse-sorted on ts. Stable, so same-ts rows keep release > rc > develop.
  tbl=$(mktemp)
  emit() {  # $1 = version list  $2 = type label
    printf '%s\n' "$1" | while IFS= read -r v; do
      [ -n "$v" ] || continue
      f="${vdir}/${v}.md"
      printf '%s|%s|%s|%s\n' "$(pts "$f")" "$(pdate "$f")" "$v" "$2"
    done
  }
  {
    emit "$frozen"     "release"
    emit "$inprogress" "release candidate"
    emit "$develop"    "develop"
    emit "$branches"   "branch"
  } | sed 's/^|/0|/' > "$tbl"     # missing ts -> 0, so it sorts last

  echo "| Version | Date | Type |"
  echo "| --- | --- | --- |"
  sort -s -t'|' -k1,1rn "$tbl" | while IFS='|' read -r ts d v t; do
    [ -n "$v" ] || continue
    [ -n "$d" ] || d="—"
    label="$v"; case "$v" in branch-*) label="${v#branch-}" ;; esac   # show branch name, not the file key
    echo "| [\`$label\`](#$(anchor "$v")) | $d | $t |"
  done
  rm -f "$tbl"
  echo

  section "Releases" "$frozen"
  section "Release candidates (in progress)" "$inprogress"
  section "Develop builds" "$develop"
  section "Branches (moving)" "$branches"

  # ---- retention footnote: make it clear what is (and isn't) listed ----
  echo "---"
  echo
  if [ "$kind" = library ]; then
    echo "> **What's shown here.** This is a **library**, consumed directly by git"
    echo "> reference (a branch, tag, or commit) — there is no image or chart. Each"
    echo "> **tagged version** is listed in full; each tracked **branch** shows its"
    echo "> current state and its **last ${KEEP} commits**. Pin a **tag** (or a commit)"
    echo "> for a fixed version, or a **branch** to track the latest. This page is"
    echo "> generated automatically from commit history; do not edit it by hand."
  else
    echo "> **What's shown here.** This catalogue lists **every stable release**, plus"
    echo "> the **latest ${KEEP} develop builds** and the **latest ${KEEP} release"
    echo "> candidates** per release line. Older develop builds and release candidates"
    echo "> are pruned as they are superseded, and a release's candidates are removed"
    echo "> once it ships. Those versions still exist in the container and Helm"
    echo "> registries — they are simply not listed here. This page is generated"
    echo "> automatically from commit history; do not edit it by hand."
  fi
} > "${repo_dir}/CHANGELOG.md"
