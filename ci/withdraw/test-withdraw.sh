#!/usr/bin/env bash
#
# Tests for the withdraw safety rules and the catalogue side-effects. No network.
#
#   ./ci/withdraw/test-withdraw.sh

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CL="$(cd "$HERE/../changelog" && pwd)"
pass=0; fail=0
ok()   { printf '  ok   %s\n' "$1"; pass=$((pass+1)); }
bad()  { printf '  FAIL %s (%s)\n' "$1" "$2"; fail=$((fail+1)); }
check(){ if [ "$2" = "$3" ]; then ok "$1"; else bad "$1" "want=$2 got=$3"; fi; }
contains(){ case "$2" in *"$3"*) ok "$1";; *) bad "$1" "missing: $3";; esac; }
excludes(){ case "$2" in *"$3"*) bad "$1" "leaked: $3";; *) ok "$1";; esac; }

PUB=$(printf '0.0.0-develop.%s\n' 10 11 12 13 14; printf '%s\n' 1.0.0 1.1.0-rc.7 v0.9.0)

echo "select: only develop builds are eligible"
out=$(printf '%s\n' "$PUB" | MODE=single VERSION=1.0.0 bash "$HERE/select.sh" 2>&1); rc=$?
check "release N.N.N refused"            1 "$rc"
contains "release refusal explains why"  "$out" "only develop builds"
out=$(printf '%s\n' "$PUB" | MODE=single VERSION=1.1.0-rc.7 bash "$HERE/select.sh" 2>&1); rc=$?
check "release candidate refused"        1 "$rc"
contains "RC refusal mentions en route"  "$out" "en route"

echo
echo "select: the newest develop build is never withdrawn"
out=$(printf '%s\n' "$PUB" | MODE=single VERSION=0.0.0-develop.14 bash "$HERE/select.sh" 2>&1); rc=$?
check "newest refused"                   2 "$rc"
contains "newest refusal explains"       "$out" "newest build"

echo
echo "select: modes"
out=$(printf '%s\n' "$PUB" | MODE=single VERSION=0.0.0-develop.12 bash "$HERE/select.sh" 2>/dev/null)
check "single selects exactly one"       "0.0.0-develop.12" "$out"
out=$(printf '%s\n' "$PUB" | MODE=range FROM=10 TO=12 bash "$HERE/select.sh" 2>/dev/null | tr '\n' ' ')
check "range is inclusive, newest first" "0.0.0-develop.12 0.0.0-develop.11 0.0.0-develop.10 " "$out"
# The catalogue shows full version strings, so that is what people paste into the form.
out=$(printf '%s\n' "$PUB" | MODE=range FROM=0.0.0-develop.10 TO=0.0.0-develop.12 bash "$HERE/select.sh" 2>/dev/null | tr '\n' ' ')
check "range accepts full version bounds" "0.0.0-develop.12 0.0.0-develop.11 0.0.0-develop.10 " "$out"
out=$(printf '%s\n' "$PUB" | MODE=range FROM=10 TO=0.0.0-develop.11 bash "$HERE/select.sh" 2>/dev/null | tr '\n' ' ')
check "range accepts mixed bounds"        "0.0.0-develop.11 0.0.0-develop.10 " "$out"
out=$(printf '%s\n' "$PUB" | MODE=range FROM=1.0.0 TO=12 bash "$HERE/select.sh" 2>&1); rc=$?
check "a release as a bound is refused"   1 "$rc"
contains "bound error is actionable"      "$out" "or the full version"
out=$(printf '%s\n' "$PUB" | MODE=keep KEEP_LAST=2 bash "$HERE/select.sh" 2>/dev/null | tr '\n' ' ')
check "keep keeps the newest N"          "0.0.0-develop.12 0.0.0-develop.11 0.0.0-develop.10 " "$out"
out=$(printf '%s\n' "$PUB" | MODE=keep KEEP_LAST=99 bash "$HERE/select.sh" 2>&1); rc=$?
check "keep beyond the pile is a no-op"  2 "$rc"
out=$(printf '%s\n' "$PUB" | MODE=single VERSION=0.0.0-develop.99 bash "$HERE/select.sh" 2>&1); rc=$?
check "unpublished version refused"      1 "$rc"
out=$(printf '%s\n' "$PUB" | MODE=range FROM=12 TO=10 bash "$HERE/select.sh" 2>&1); rc=$?
check "inverted range refused"           1 "$rc"

echo
echo "chart-images: only OUR images at that exact version"
# mikefarah yq only; the legacy yq v3 on some machines speaks a different language.
if yq --version 2>&1 | grep -q mikefarah; then
  T=$(mktemp -d); mkdir -p "$T/c"
  printf 'apiVersion: v2\nname: c\nversion: 0.0.0-develop.297\n' > "$T/c/Chart.yaml"
  cat > "$T/c/values.yaml" <<'Y'
api:
  image: {repository: openg2p/api, tag: "0.0.0-develop.297"}
celery:
  image: {registry: registry.gitlab.com, repository: openg2p/cm/celery, tag: "0.0.0-develop.297"}
redis:
  image: {repository: openg2p/redis, tag: 7.2.5}
Y
  ( cd "$T" && tar -czf c.tgz c )
  got=$(CHART_TGZ="$T/c.tgz" VERSION=0.0.0-develop.297 bash "$HERE/chart-images.sh" | tr '\n' ' ')
  check "plain + registry-split images found" "openg2p/api registry.gitlab.com/openg2p/cm/celery " "$got"
  excludes "third-party image excluded"       "$got" "redis"
  got=$(CHART_TGZ="$T/c.tgz" VERSION=0.0.0-develop.999 bash "$HERE/chart-images.sh" | tr '\n' ' ')
  check "no match -> nothing selected"        "" "$got"
  rm -rf "$T"
else
  echo "  skip (needs mikefarah yq; CI installs it)"
fi

echo
echo "tombstone: records, is idempotent, and never rewrites history"
P=$(mktemp -d)
printf '%s\n' 0.0.0-develop.12 0.0.0-develop.11 \
  | PAGES_DIR="$P" REPO=demo DATE=2026-07-26 REASON="bad migration" bash "$HERE/tombstone.sh" >/dev/null
w=$(cat "$P/demo/.withdrawn")
contains "records the version"     "$w" "0.0.0-develop.12|2026-07-26|bad migration"
check    "records both"            2 "$(grep -c . "$P/demo/.withdrawn")"
printf '%s\n' 0.0.0-develop.12 \
  | PAGES_DIR="$P" REPO=demo DATE=2026-08-01 REASON="different reason" bash "$HERE/tombstone.sh" >/dev/null
check    "re-run adds nothing"     2 "$(grep -c . "$P/demo/.withdrawn")"
contains "original reason kept"    "$(cat "$P/demo/.withdrawn")" "2026-07-26|bad migration"
excludes "not rewritten"           "$(cat "$P/demo/.withdrawn")" "different reason"
# a multi-line reason must stay on ONE line, or the renderer would split it
printf '%s\n' 0.0.0-develop.10 \
  | PAGES_DIR="$P" REPO=demo DATE=2026-07-26 REASON="$(printf 'line one\nline two|piped')" \
    bash "$HERE/tombstone.sh" >/dev/null
check    "reason flattened to one line" 3 "$(grep -c . "$P/demo/.withdrawn")"

echo
echo "catalogue: Withdrawn section + the page (and its diff thread) are kept"
mkdir -p "$P/demo/versions"
printf 'name=demo\nkind=service\n' > "$P/demo/.meta"
for n in 11 12; do
  printf '## demo — develop 0.0.0-develop.%s (2026-07-2%s)\n\n_commit `abc` · changes since 0.0.0-develop.%s_\n<!-- build:0.0.0-develop.%s revision:abc%s ts:10%s -->\n' \
    "$n" "$n" "$((n-1))" "$n" "$n" "$n" > "$P/demo/versions/0.0.0-develop.$n.md"
done
PAGES_DIR="$P" REPO=demo bash "$CL/render-aggregate.sh" >/dev/null
agg=$(cat "$P/demo/CHANGELOG.md")
contains "Withdrawn section rendered"   "$agg" "# Withdrawn"
contains "lists the withdrawn version"  "$agg" '`0.0.0-develop.12`'
contains "shows the reason"             "$agg" "bad migration"
contains "table flags it"               "$agg" "withdrawn"
contains "page is KEPT (thread intact)" "$agg" "changes since 0.0.0-develop.11"
check    "page file still on disk"      yes "$([ -f "$P/demo/versions/0.0.0-develop.12.md" ] && echo yes || echo no)"
rm -rf "$P"

echo
echo "catalogue: no .withdrawn -> no Withdrawn section at all"
P2=$(mktemp -d); mkdir -p "$P2/demo/versions"
printf 'name=demo\nkind=service\n' > "$P2/demo/.meta"
printf '## demo 1.0.0 — 2026-07-20\n<!-- build:1.0.0 revision:a ts:1 -->\n' > "$P2/demo/versions/1.0.0.md"
PAGES_DIR="$P2" REPO=demo bash "$CL/render-aggregate.sh" >/dev/null
excludes "clean repos are unchanged" "$(cat "$P2/demo/CHANGELOG.md")" "# Withdrawn"
rm -rf "$P2"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
