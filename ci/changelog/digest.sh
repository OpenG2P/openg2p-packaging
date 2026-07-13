#!/usr/bin/env bash
#
# Build a compact, BOUNDED structural digest of the changes in a git range —
# derived from `git diff --stat/--name-status`, never from diff CONTENT. So it
# is cheap and stays small regardless of how large the diff is, and it grounds
# the AI summary in what actually changed (catching things the commit messages
# omit: new endpoints, migrations, dependency/config changes, …).
#
# Prints nothing when there is no baseline (RANGE_FROM empty) — a whole-history
# digest is not useful — or when nothing changed.
#
#   RANGE_FROM=1.0.0 RANGE_TO=HEAD ./digest.sh
#
# Portable to bash 3.2 (macOS): no associative arrays.

set -euo pipefail

FROM="${RANGE_FROM:-}"
TO="${RANGE_TO:-HEAD}"

# Need a real baseline to diff against; skip otherwise.
[ -n "$FROM" ] && git rev-parse --verify -q "$FROM" >/dev/null 2>&1 || exit 0
range="${FROM}..${TO}"

shortstat=$(git diff --shortstat "$range" 2>/dev/null | sed 's/^[[:space:]]*//')
[ -n "$shortstat" ] || exit 0

cat_of() {
  case "$1" in
    */migrations/*|*migrate*|*.sql)                              echo migrations ;;
    pyproject.toml|*/pyproject.toml|poetry.lock|*/poetry.lock|\
    package.json|*/package.json|package-lock.json|*/package-lock.json|\
    requirements*.txt|*/requirements*.txt|go.mod|go.sum)         echo dependencies ;;
    Dockerfile*|*/Dockerfile*|docker/*|*/docker/*)               echo docker ;;
    .github/*|*/.github/*)                                       echo ci ;;
    Chart.yaml|*/Chart.yaml|values.yaml|*/values.yaml|*.tpl|\
    */charts/*|*/deployment/*|*/deployments/*)                   echo chart/deploy ;;
    *controller*|*/api/*|*route*|*endpoint*)                     echo api ;;
    ui/*|*/ui/*|*.tsx|*.jsx|*.vue|*.svelte)                      echo ui ;;
    *test*|*/tests/*|*/test/*)                                   echo tests ;;
    *.md|docs/*|*/docs/*)                                        echo docs ;;
    *)                                                           echo other ;;
  esac
}

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
: > "$tmp/new"; : > "$tmp/del"; : > "$tmp/deps"; : > "$tmp/migs"

while IFS=$'\t' read -r status path rest; do
  [ -n "${status:-}" ] || continue
  p="$path"; [ -n "${rest:-}" ] && p="$rest"   # rename: use the new path
  c=$(cat_of "$p")
  echo "$p" >> "$tmp/cat.$c"
  case "$status" in A*) echo "$p" >> "$tmp/new" ;; D*) echo "$p" >> "$tmp/del" ;; esac
  [ "$c" = dependencies ] && echo "$p" >> "$tmp/deps"
  [ "$c" = migrations ]   && echo "$p" >> "$tmp/migs"
done <<EOF
$(git diff --name-status "$range" 2>/dev/null)
EOF

cap()   { sed '/^$/d' "$1" 2>/dev/null | sort -u | head -"$2" | paste -sd',' - | sed 's/,/, /g' ; }
ncount(){ sed '/^$/d' "$1" 2>/dev/null | sort -u | grep -c . || true ; }
more()  { [ "$1" -gt "$2" ] && printf ', …(+%d more)' "$(( $1 - $2 ))" || true ; }

echo "- ${shortstat}"

areas=""
for c in api migrations dependencies chart/deploy docker ui ci tests docs other; do
  f="$tmp/cat.$c"
  [ -f "$f" ] || continue
  n=$(ncount "$f")
  [ "$n" -gt 0 ] && areas="${areas}${c} (${n}), "
done
areas=$(printf '%s' "$areas" | sed 's/, $//')
[ -n "$areas" ] && echo "- Areas touched: ${areas}"

n=$(ncount "$tmp/new");  [ "$n" -gt 0 ] && echo "- New files (${n}): $(cap "$tmp/new" 8)$(more "$n" 8)"
n=$(ncount "$tmp/del");  [ "$n" -gt 0 ] && echo "- Removed files (${n}): $(cap "$tmp/del" 8)$(more "$n" 8)"
n=$(ncount "$tmp/deps"); [ "$n" -gt 0 ] && echo "- Dependency manifests changed: $(cap "$tmp/deps" 5)"
n=$(ncount "$tmp/migs"); [ "$n" -gt 0 ] && echo "- Migrations touched: $(cap "$tmp/migs" 5)"
