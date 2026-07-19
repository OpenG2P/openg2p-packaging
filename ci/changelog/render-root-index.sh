#!/usr/bin/env bash
#
# Regenerate the changelog site's root landing page: a list of every repo that
# has a published changelog. Regenerated wholesale each run, so new repos appear
# automatically and removed ones drop off.
#
#   env: PAGES_DIR
#        ROOT_INDEX_FILE   landing filename (default index.md for GitHub Pages;
#                          README.md for GitLab, so it renders as the repo home)
#        LINK_SUFFIX       appended to cross-file links ('' for GitHub Pages;
#                          '.md' for GitLab's plain file browser)
#        PLAIN_MD          true => plain-markdown repo browsing (GitLab): a real H1
#                          title, no Jekyll front matter, and no _config.yml
#        HELM_REGISTRY_URL if set, the intro links the browsable Helm package
#                          registry and mentions per-repo Container Registries
#        DOCS_URL          versioning & CI docs (has a default)
#
# Each repo's clickable "repository" link comes from PAGES_DIR/<repo>/.meta
# (written by the changelog run) -- the repo path can't be reconstructed from the
# flattened folder name once subgroups exist, so it is stored, not guessed.

set -euo pipefail

index_file="${ROOT_INDEX_FILE:-index.md}"
link_suffix="${LINK_SUFFIX:-}"
plain="${PLAIN_MD:-false}"
docs_url="${DOCS_URL:-https://docs.openg2p.org/operations/deployment/helm-docker-versioning-and-ci}"

meta_get() { grep -m1 "^${2}=" "${PAGES_DIR}/${1}/.meta" 2>/dev/null | sed "s/^${2}=//" || true; }

# One markdown bullet per repo in a newline-separated list: display name links to the
# repo's CHANGELOG; a "repository" link is added when .meta carries the source URL.
bullets() {
  printf '%s\n' "$1" | while IFS= read -r r; do
    [ -n "$r" ] || continue
    url=$(meta_get "$r" repo)
    disp=$(meta_get "$r" name); [ -n "$disp" ] || disp="$r"   # keep subgroup slashes
    if [ -n "$url" ]; then
      echo "- **[${disp}](./${r}/CHANGELOG${link_suffix})** · [repository ↗](${url})"
    else
      echo "- **[${disp}](./${r}/CHANGELOG${link_suffix})**"
    fi
  done
}

repos=""
for d in "$PAGES_DIR"/*/; do
  [ -f "${d}CHANGELOG.md" ] || continue     # only real changelog folders
  repos="${repos}$(basename "$d")"$'\n'
done
repos=$(printf '%s' "$repos" | sed '/^$/d' | sort)

# Jekyll site config (GitHub Pages only; not for plain-markdown GitLab browsing).
if [ "$plain" != true ]; then
  cat > "$PAGES_DIR/_config.yml" <<'YAML'
theme: jekyll-theme-primer
title: OpenG2P Versions & Change logs
description: Published version history and change logs for OpenG2P repositories
YAML
fi

{
  if [ "$plain" = true ]; then
    echo "# OpenG2P Versions & Change logs"
  else
    echo "---"
    echo "---"
  fi
  echo
  echo "This site presents the **published versions and change logs of every OpenG2P"
  echo "module and service**, produced automatically as part of the CI pipeline. Each"
  echo "entry below is a **Helm package**; its Helm chart version and the Docker image"
  echo "versions it references are **locked together** — one immutable version per commit."
  echo
  if [ -n "${HELM_REGISTRY_URL:-}" ]; then
    echo "Browse all charts in the **[Helm package registry](${HELM_REGISTRY_URL})**."
    echo "The Docker images for each service live in that repository's **Container"
    echo "Registry** (linked at the top of each repository's page below). See the"
    echo "**[versioning & CI docs](${docs_url})** for how these are produced."
  else
    echo "See the **[versioning & CI docs](${docs_url})** for how these are produced."
  fi
  echo
  if [ -z "$repos" ]; then
    echo "_No changelogs published yet._"
  else
    # Partition by kind: services (build image/chart) vs libraries (consumed by git ref).
    svc=""; lib=""
    while IFS= read -r r; do
      [ -n "$r" ] || continue
      if [ "$(meta_get "$r" kind)" = library ]; then lib="${lib}${r}"$'\n'; else svc="${svc}${r}"$'\n'; fi
    done <<EOF
$repos
EOF
    svc=$(printf '%s' "$svc" | sed '/^$/d'); lib=$(printf '%s' "$lib" | sed '/^$/d')
    if [ -n "$lib" ]; then
      # Headed sections only once libraries exist, so the all-services view stays flat.
      echo "### Services"; echo
      [ -n "$svc" ] && bullets "$svc" || echo "_None yet._"
      echo
      echo "### Libraries"; echo
      bullets "$lib"
    else
      bullets "$svc"
    fi
  fi
} > "$PAGES_DIR/${index_file}"

# On GitLab, drop the GitHub-Pages artifacts so the repo shows only the README.
if [ "$plain" = true ]; then
  rm -f "$PAGES_DIR/index.md" "$PAGES_DIR/_config.yml"
fi

n=$(printf '%s\n' "$repos" | grep -c . || true)
echo "wrote ${PAGES_DIR}/${index_file} (${n} repos)"
