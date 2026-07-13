#!/usr/bin/env bash
#
# Regenerate a repo's aggregate CHANGELOG.md from its per-version pages.
# Wholesale rebuild (never appended), so parallel branches cannot make it
# diverge. Three sections:
#
#   Unreleased               — the develop rolling page (versions/unreleased.md)
#   Release candidates       — RC pages whose target release is NOT yet frozen
#                              (in progress), newest-first
#   Releases                 — frozen N.N.N pages, newest-first
#
# RC pages whose release HAS been frozen stay as files (browsable by URL) but
# drop out of the in-progress list, keeping the index readable.
#
#   env: PAGES_DIR REPO

set -euo pipefail

repo_dir="${PAGES_DIR}/${REPO}"
[ -d "${repo_dir}/versions" ] || { echo "no versions/ for ${REPO}"; exit 0; }

list_versions() { ls "${repo_dir}/versions/" 2>/dev/null | sed 's/\.md$//'; }

frozen=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -rV || true)

# In-progress RCs: <rel>-rc.<n> whose <rel>.md does not exist.
rcs_all=$(list_versions | grep -E '^[0-9]+\.[0-9]+\.[0-9]+-rc\.[0-9]+$' || true)
inprogress=""
while IFS= read -r v; do
  [ -n "$v" ] || continue
  rel="${v%-rc.*}"
  [ -f "${repo_dir}/versions/${rel}.md" ] && continue   # released -> keep file, hide here
  inprogress="${inprogress}${v}"$'\n'
done <<EOF
$rcs_all
EOF
inprogress=$(printf '%s' "$inprogress" | sed '/^$/d' | sort -rV || true)

{
  echo "# ${REPO} changelog"
  echo
  echo "_Published automatically. Newest first._"
  echo

  if [ -f "${repo_dir}/versions/unreleased.md" ]; then
    cat "${repo_dir}/versions/unreleased.md"
    echo
  fi

  if [ -n "$inprogress" ]; then
    echo "# Release candidates (in progress)"
    echo
    printf '%s\n' "$inprogress" | while IFS= read -r v; do
      [ -n "$v" ] || continue
      cat "${repo_dir}/versions/${v}.md"
      echo
    done
  fi

  if [ -n "$frozen" ]; then
    echo "# Releases"
    echo
    printf '%s\n' "$frozen" | while IFS= read -r v; do
      [ -n "$v" ] || continue
      cat "${repo_dir}/versions/${v}.md"
      echo
    done
  fi
} > "${repo_dir}/CHANGELOG.md"
