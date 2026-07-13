#!/usr/bin/env bash
#
# Regenerate a repo's aggregate CHANGELOG.md from its per-version pages.
# Wholesale rebuild (never appended), so parallel branches cannot make it
# diverge. Layout:
#
#   1. a summary TABLE of every version (Version | Date | Type), newest first
#   2. Releases               — frozen N.N.N pages, newest-first
#   3. Release candidates     — RC pages whose release is not yet frozen
#   4. Unreleased             — the develop rolling page
#
# Releases are shown first so the latest release is the most prominent thing on
# the page; the develop stream sits at the bottom.
#
#   env: PAGES_DIR REPO

set -euo pipefail

repo_dir="${PAGES_DIR}/${REPO}"
vdir="${repo_dir}/versions"
[ -d "$vdir" ] || { echo "no versions/ for ${REPO}"; exit 0; }

list_versions() { ls "$vdir" 2>/dev/null | sed 's/\.md$//'; }

frozen=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -rV || true)

rcs_all=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$' || true)
inprogress=""
while IFS= read -r v; do
  [ -n "$v" ] || continue
  [ -f "${vdir}/${v%-rc.*}.md" ] && continue     # released -> keep file, hide here
  inprogress="${inprogress}${v}"$'\n'
done <<EOF
$rcs_all
EOF
inprogress=$(printf '%s' "$inprogress" | sed '/^$/d' | sort -rV || true)

# A YYYY-MM-DD from a page's heading, or em dash.
pdate() { grep -m1 '^## ' "$1" 2>/dev/null | grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}' | head -1; }
# The develop version string out of "Unreleased (<version>, <date>)".
uver()  { grep -m1 '^## ' "$1" 2>/dev/null | sed -n 's/.*Unreleased (\([^,]*\),.*/\1/p'; }
# A stable HTML-anchor id for a version (so the table can link to its section).
anchor() { printf 'v-%s' "$(printf '%s' "$1" | sed 's/[^A-Za-z0-9]/-/g')"; }

{
  echo "# ${REPO} changelog"
  echo
  echo "_Published automatically._"
  echo

  # ---- summary table (Version links to that version's section) ----
  echo "| Version | Date | Type |"
  echo "| --- | --- | --- |"
  printf '%s\n' "$frozen" | while IFS= read -r v; do
    [ -n "$v" ] || continue
    echo "| [\`$v\`](#$(anchor "$v")) | $(pdate "${vdir}/${v}.md") | release |"
  done
  printf '%s\n' "$inprogress" | while IFS= read -r v; do
    [ -n "$v" ] || continue
    echo "| [\`$v\`](#$(anchor "$v")) | $(pdate "${vdir}/${v}.md") | release candidate |"
  done
  if [ -f "${vdir}/unreleased.md" ]; then
    uv=$(uver "${vdir}/unreleased.md")
    echo "| [\`$uv\`](#$(anchor "$uv")) | $(pdate "${vdir}/unreleased.md") | develop |"
  fi
  echo

  # ---- Releases (newest first) ----
  if [ -n "$frozen" ]; then
    echo "# Releases"
    echo
    printf '%s\n' "$frozen" | while IFS= read -r v; do
      [ -n "$v" ] || continue
      echo "<a id=\"$(anchor "$v")\"></a>"
      echo
      cat "${vdir}/${v}.md"; echo
    done
  fi

  # ---- Release candidates in progress ----
  if [ -n "$inprogress" ]; then
    echo "# Release candidates (in progress)"
    echo
    printf '%s\n' "$inprogress" | while IFS= read -r v; do
      [ -n "$v" ] || continue
      echo "<a id=\"$(anchor "$v")\"></a>"
      echo
      cat "${vdir}/${v}.md"; echo
    done
  fi

  # ---- Unreleased (develop) ----
  if [ -f "${vdir}/unreleased.md" ]; then
    echo "<a id=\"$(anchor "$(uver "${vdir}/unreleased.md")")\"></a>"
    echo
    cat "${vdir}/unreleased.md"
    echo
  fi
} > "${repo_dir}/CHANGELOG.md"
