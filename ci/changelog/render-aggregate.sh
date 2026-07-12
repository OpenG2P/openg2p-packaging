#!/usr/bin/env bash
#
# Regenerate a repo's aggregate CHANGELOG.md from its per-version pages.
# Wholesale rebuild (never appended), so parallel branches cannot make it
# diverge. Unreleased first, then frozen releases newest-first.
#
#   env: PAGES_DIR REPO

set -euo pipefail

repo_dir="${PAGES_DIR}/${REPO}"
[ -d "${repo_dir}/versions" ] || { echo "no versions/ for ${REPO}"; exit 0; }

# Frozen version pages, newest-first. Captured first so a no-match grep does
# not trip pipefail.
frozen=$(ls "${repo_dir}/versions/" 2>/dev/null \
           | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.md$' || true)
frozen=$(printf '%s\n' "$frozen" | sed 's/\.md$//' | sed '/^$/d' | sort -rV)

{
  echo "# ${REPO} changelog"
  echo
  echo "_Published automatically on release. Newest first._"
  echo
  if [ -f "${repo_dir}/versions/unreleased.md" ]; then
    cat "${repo_dir}/versions/unreleased.md"
    echo
  fi
  printf '%s\n' "$frozen" | while IFS= read -r v; do
    [ -n "$v" ] || continue
    cat "${repo_dir}/versions/${v}.md"
    echo
  done
} > "${repo_dir}/CHANGELOG.md"
