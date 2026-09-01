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
#   3. Release candidates  — RC pages (last few per line), kept after release
#   4. Develop builds      — 0.0.0-develop.N pages (last few)
#
#   env: PAGES_DIR REPO

set -euo pipefail

repo_dir="${PAGES_DIR}/${REPO}"
vdir="${repo_dir}/versions"
KEEP="${KEEP:-20}"      # develop builds; render.sh passes the real value
KEEP_RC="${KEEP_RC:-10}"   # release candidates, per release line
[ -d "$vdir" ] || { echo "no versions/ for ${REPO}"; exit 0; }

list_versions() { ls "$vdir" 2>/dev/null | sed 's/\.md$//'; }

# Release pages: everything that is NOT a develop build, an RC, or a library branch
# page. Defined by EXCLUSION on purpose. The three transient shapes are precisely
# known, so anything else is a durable, immutable published version -- which covers
# bare N.N.N, legacy v-prefixed vN.N.N (some libraries still tag v…), AND versions
# that are not SemVer at all, such as an image tag like 24.0.5-debian-12-r1-g2p2.
# Matching releases positively against a SemVer pattern silently dropped those from
# every section: the page was written, and the catalogue listed nothing.
frozen=$(list_versions \
  | grep -vE '^0\.0\.0-develop\.[0-9]+$' \
  | grep -vE '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$' \
  | grep -vE '^branch-' \
  | sort -rV || true)
# How much of the history the CATALOGUE shows. Pages are never deleted -- every
# build's page stays in versions/ permanently -- so this bounds only what is
# rendered here. Retention used to be enforced by deleting pages, which took any
# note written on one with it; the page is bounded at render time instead, and an
# older build stays readable in the versions repo.
#
# The table is built from these same lists, so capping here keeps table and
# sections in step and never leaves a row linking to an anchor that was not
# emitted.
RENDER_KEEP="${RENDER_KEEP:-20}"        # newest develop builds shown
RENDER_KEEP_RC="${RENDER_KEEP_RC:-10}"  # newest RCs shown PER release line
develop=$(list_versions | grep -E '^0\.0\.0-develop\.[0-9]+$' | sort -t. -k4,4rn \
  | head -n "$RENDER_KEEP" || true)
# Library repos: one rolling page per tracked branch (branch-<name>.md). Empty for
# services, so the branch table rows + section simply don't appear for them.
branches=$(list_versions | grep -E '^branch-' | sort || true)

kind=$(grep -m1 '^kind=' "${repo_dir}/.meta" 2>/dev/null | sed 's/^kind=//' || true)
[ -n "$kind" ] || kind=service

# Withdrawn versions (ci/withdraw): "<version>|<date>|<reason>" per line. Their pages
# are KEPT -- deleting them would dangle the "changes since <previous build>" thread --
# so a withdrawn version stays in its normal section and is flagged in the table.
withdrawn_file="${repo_dir}/.withdrawn"
is_withdrawn() { [ -f "$withdrawn_file" ] && grep -q "^${1}|" "$withdrawn_file" 2>/dev/null; }

# Marked versions (ci/mark): "<version>|<note>" per line, one per marked version.
# A build can be declared known-good WITHOUT tagging a release -- tagging means
# "shipped", and most good builds are never shipped. The note is free text, shown
# in bold in the Notes column, and is meant to be EDITED later (a plain file in
# this repo; correct it in the web IDE, no pipeline needed). Marked versions are
# also exempt from retention (render.sh) and refused by withdraw, so the mark
# cannot outlive the thing it points at.
marked_file="${repo_dir}/.marked"
mark_note() {   # $1 = version -> its note, or empty
  [ -f "$marked_file" ] || return 0
  # Take the FIRST match: a hand-edited file may end up with duplicates.
  grep -m1 "^${1}|" "$marked_file" 2>/dev/null | cut -d'|' -f2- || true
}

# Every RC page, whether or not its release has shipped -- an RC is the audit trail
# of a release run, so it stays visible afterwards (pruned only by KEEP_RC).
# Newest RENDER_KEEP_RC per release line, not overall: capping globally would hide
# an older line's candidates entirely the moment a newer line started building.
rcs=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$' | sort -rV \
  | awk -v k="$RENDER_KEEP_RC" -F'-rc.' '{ if (++seen[$1] <= k) print }' || true)

# A YYYY-MM-DD from a page's heading, or em dash.
pdate() { grep -m1 '^## ' "$1" 2>/dev/null | grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}' | head -1; }
# The commit-time epoch embedded in the page's marker (sort key).
pts()   { grep -m1 -oE 'ts:[0-9]+' "$1" 2>/dev/null | sed 's/^ts://'; }
# A stable HTML-anchor id for a version (so the table can link to its section).
anchor() { printf 'v-%s' "$(printf '%s' "$1" | sed 's/[^A-Za-z0-9]/-/g')"; }

# Print one section: an anchored dump of each version's page, with the operator's
# note (if any) injected just under the heading.
#
# WHY THE NOTE IS INJECTED HERE AND NOT WRITTEN INTO THE PAGE
#   A version page is written ONCE, by the build that produced it. Marking a build is
#   something you do afterwards -- often months afterwards -- so a note written into
#   the page at build time could never appear on a version that already exists, which
#   is every version you would actually want to mark. This file, by contrast, is
#   regenerated from the pages on every push to the versions repo, so a note added
#   today shows up immediately, on any version, however old.
#
#   It is deliberately NOT called "release notes": it applies to any build, usually
#   one that was never released, and is written after the fact rather than at tag
#   time. A blockquote keeps it visibly an aside from the generated content.
section() {  # $1 = heading  $2 = newline list of versions
  [ -n "$2" ] || return 0
  echo "# $1"; echo
  printf '%s\n' "$2" | while IFS= read -r v; do
    [ -n "$v" ] || continue
    echo "<a id=\"$(anchor "$v")\"></a>"
    echo
    n=$(mark_note "$v")
    if [ -n "$n" ]; then
      head -1 "${vdir}/${v}.md"        # the "## <repo> <version> — <date>" heading
      echo
      echo "> **Note** — ${n}"
      tail -n +2 "${vdir}/${v}.md"
    else
      cat "${vdir}/${v}.md"
    fi
    echo
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
    emit "$rcs"        "release candidate"
    emit "$develop"    "develop"
    emit "$branches"   "branch"
  } | sed 's/^|/0|/' > "$tbl"     # missing ts -> 0, so it sorts last

  echo "| Version | Date | Type | Notes |"
  echo "| --- | --- | --- | --- |"
  sort -s -t'|' -k1,1rn "$tbl" | while IFS='|' read -r ts d v t; do
    [ -n "$v" ] || continue
    [ -n "$d" ] || d="—"
    label="$v"; case "$v" in branch-*) label="${v#branch-}" ;; esac   # show branch name, not the file key
    if is_withdrawn "$v"; then t="${t} · **withdrawn**"; fi
    # Passed through as markdown, exactly as written in .marked -- so `**bold**`,
    # `code`, a link, or plain text all render the way the author intended, rather
    # than the catalogue deciding. Pipes are escaped (a bare one would end the cell
    # and silently mangle the row); \| still renders as a literal pipe.
    note=$(mark_note "$v" | sed 's/|/\\|/g')
    echo "| [\`$label\`](#$(anchor "$v")) | $d | $t | ${note:-} |"
  done
  rm -f "$tbl"
  echo

  section "Releases" "$frozen"
  section "Release candidates" "$rcs"
  section "Develop builds" "$develop"
  section "Branches (moving)" "$branches"

  # ---- withdrawn versions: deleted artifacts, but the history is kept ----
  if [ -s "$withdrawn_file" ]; then
    echo "# Withdrawn"
    echo
    echo "These versions were **deleted from the registries** and can no longer be"
    echo "pulled or installed. Their entries above are kept so the history stays"
    echo "continuous, and they are never re-published under the same version."
    echo
    echo "| Version | Withdrawn | Reason |"
    echo "| --- | --- | --- |"
    while IFS='|' read -r wv wd wr; do
      [ -n "$wv" ] || continue
      echo "| \`${wv}\` | ${wd:-—} | ${wr:-—} |"
    done < "$withdrawn_file"
    echo
  fi

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
    echo "> the **latest ${KEEP} develop builds** and the **latest ${KEEP_RC} release"
    echo "> candidates** per release line -- candidates are KEPT after their release"
    echo "> ships, as the audit trail of the release run. Older develop builds and"
    echo "> release candidates are pruned as they are superseded. Those versions"
    echo "> still exist in the container and Helm"
    echo "> registries — they are simply not listed here. This page is generated"
    echo "> automatically from commit history; do not edit it by hand."
  fi
} > "${repo_dir}/CHANGELOG.md"
