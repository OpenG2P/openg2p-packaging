#!/usr/bin/env bash
#
# Regenerate the changelog site's root landing page: a list of every repo that
# has a published changelog. Keeps the gh-pages root from 404-ing and gives a
# human entry point. Regenerated wholesale each run, so new repos appear
# automatically and removed ones drop off.
#
#   env: PAGES_DIR

set -euo pipefail

repos=""
for d in "$PAGES_DIR"/*/; do
  [ -f "${d}CHANGELOG.md" ] || continue     # only real changelog folders
  repos="${repos}$(basename "$d")"$'\n'
done
repos=$(printf '%s' "$repos" | sed '/^$/d' | sort)

# Site config: sets the header title (otherwise Jekyll uses the repo name
# "openg2p-packaging"). Pin jekyll-theme-primer explicitly so the look is
# unchanged. Written idempotently on every run.
cat > "$PAGES_DIR/_config.yml" <<'YAML'
theme: jekyll-theme-primer
title: OpenG2P Versions & Change logs
description: Published version history and change logs for OpenG2P repositories
YAML

{
  # Empty front matter still makes Jekyll render this as index.html at "/".
  # No page H1 here — the theme header already shows the site title above.
  echo "---"
  echo "---"
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
      # Link to the Jekyll-rendered view; the raw .md is at ./<repo>/CHANGELOG.md
      echo "- [${r}](./${r}/CHANGELOG)"
    done
  fi
} > "$PAGES_DIR/index.md"

n=$(printf '%s\n' "$repos" | grep -c . || true)
echo "wrote ${PAGES_DIR}/index.md + _config.yml (${n} repos)"
