#!/usr/bin/env bash
#
# Regenerate the changelog site's root landing page: a list of every repo that
# has a published changelog. Regenerated wholesale each run, so new repos appear
# automatically and removed ones drop off.
#
#   env: PAGES_DIR
#        ROOT_INDEX_FILE  landing filename (default index.md for GitHub Pages;
#                         README.md for GitLab, so it renders as the repo home)
#        LINK_SUFFIX      appended to cross-file links ('' for GitHub Pages;
#                         '.md' for GitLab's plain file browser)
#        PLAIN_MD         true => plain-markdown repo browsing (GitLab): a real H1
#                         title, no Jekyll front matter, and no _config.yml (the
#                         GitHub-Pages index.md/_config.yml are also cleaned up)

set -euo pipefail

index_file="${ROOT_INDEX_FILE:-index.md}"
link_suffix="${LINK_SUFFIX:-}"
plain="${PLAIN_MD:-false}"

repos=""
for d in "$PAGES_DIR"/*/; do
  [ -f "${d}CHANGELOG.md" ] || continue     # only real changelog folders
  repos="${repos}$(basename "$d")"$'\n'
done
repos=$(printf '%s' "$repos" | sed '/^$/d' | sort)

# Site config: sets the header title (otherwise Jekyll uses the repo name). Only
# for the GitHub Pages site -- not written for plain-markdown (GitLab) browsing.
if [ "$plain" != true ]; then
  cat > "$PAGES_DIR/_config.yml" <<'YAML'
theme: jekyll-theme-primer
title: OpenG2P Versions & Change logs
description: Published version history and change logs for OpenG2P repositories
YAML
fi

{
  if [ "$plain" = true ]; then
    # Plain markdown (GitLab): a real H1 -- there is no Jekyll theme header.
    echo "# OpenG2P Versions & Change logs"
  else
    # Empty front matter still makes Jekyll render this as index.html at "/".
    # No page H1 -- the theme header already shows the site title above.
    echo "---"
    echo "---"
  fi
  echo
  echo "Version history and change logs, one page per repository. See the"
  echo "[versioning & CI docs](https://docs.openg2p.org/operations/deployment/helm-docker-versioning-and-ci)"
  echo "for how these are produced."
  echo
  if [ -z "$repos" ]; then
    echo "_No changelogs published yet._"
  else
    printf '%s\n' "$repos" | while IFS= read -r r; do
      [ -n "$r" ] || continue
      # Link to the changelog page. LINK_SUFFIX is '' for the Jekyll-rendered
      # view and '.md' for GitLab's raw file browser.
      echo "- [${r}](./${r}/CHANGELOG${link_suffix})"
    done
  fi
} > "$PAGES_DIR/${index_file}"

# On GitLab, drop the GitHub-Pages artifacts so the repo shows only the README.
if [ "$plain" = true ]; then
  rm -f "$PAGES_DIR/index.md" "$PAGES_DIR/_config.yml"
fi

n=$(printf '%s\n' "$repos" | grep -c . || true)
echo "wrote ${PAGES_DIR}/${index_file} (${n} repos)"
