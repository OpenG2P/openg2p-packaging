#!/usr/bin/env bash
#
# Tests for derive-version.sh. Builds a throwaway git repo, walks it through a
# realistic develop -> release-line -> release lifecycle, and asserts the
# version derived at each ref. Run it locally before changing the policy:
#
#   ./ci/version/test-derive-version.sh
#
# No dependencies beyond git and bash.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DERIVE="$HERE/derive-version.sh"

REPO="$(mktemp -d)"
trap 'rm -rf "$REPO"' EXIT

pass=0
fail=0

# version_for <ref-name> <ref-type> -> prints the `version` output
version_for() {
  (cd "$REPO" && REF_NAME="$1" REF_TYPE="$2" GITHUB_OUTPUT="" bash "$DERIVE") |
    sed -n 's/^version=//p'
}

field_for() {
  (cd "$REPO" && REF_NAME="$1" REF_TYPE="$2" GITHUB_OUTPUT="" bash "$DERIVE") |
    sed -n "s/^$3=//p"
}

check() {
  local desc="$1" want="$2" got="$3"
  if [ "$want" = "$got" ]; then
    printf '  ok   %-52s %s\n' "$desc" "$got"
    pass=$((pass + 1))
  else
    printf '  FAIL %-52s want=%s got=%s\n' "$desc" "$want" "$got"
    fail=$((fail + 1))
  fi
}

check_fails() {
  local desc="$1" ref="$2" type="$3"
  if (cd "$REPO" && REF_NAME="$ref" REF_TYPE="$type" GITHUB_OUTPUT="" bash "$DERIVE") >/dev/null 2>&1; then
    printf '  FAIL %-52s expected a non-zero exit\n' "$desc"
    fail=$((fail + 1))
  else
    printf '  ok   %-52s rejected\n' "$desc"
    pass=$((pass + 1))
  fi
}

commit() {
  git -C "$REPO" commit -q --allow-empty -m "$1"
}

git -C "$REPO" init -q -b develop
git -C "$REPO" config user.email ci@openg2p.org
git -C "$REPO" config user.name CI

echo "develop"
commit c1
commit c2
check "first develop build" "0.0.0-develop.2" "$(version_for develop branch)"
check "  alias" "develop" "$(field_for develop branch alias)"
check "  chart published" "true" "$(field_for develop branch publish_chart)"
commit c3
check "next develop build" "0.0.0-develop.3" "$(version_for develop branch)"

echo
echo "feature branches"
git -C "$REPO" checkout -q -b g2p-5629
commit c4
check "ticket branch" "0.0.0-g2p-5629.4" "$(version_for g2p-5629 branch)"
check "  chart not published" "false" "$(field_for g2p-5629 branch publish_chart)"
check "slash + case are slugified" "0.0.0-feature-g2p-42.4" "$(version_for feature/G2P-42 branch)"
check "leading-zero slug is guarded" "0.0.0-b0123.4" "$(version_for 0123 branch)"

echo
echo "release line 1.0 (no release yet)"
git -C "$REPO" checkout -q develop
git -C "$REPO" checkout -q -b 1.0
commit c5
check "first RC targets .0" "1.0.0-rc.4" "$(version_for 1.0 branch)"
check "  not frozen" "false" "$(field_for 1.0 branch frozen)"
commit c6
check "RC number tracks commit count" "1.0.0-rc.5" "$(version_for 1.0 branch)"

echo
echo "release 1.0.0"
git -C "$REPO" tag 1.0.0
check "tag publishes the bare version" "1.0.0" "$(version_for 1.0.0 tag)"
check "  frozen" "true" "$(field_for 1.0.0 tag frozen)"
check "  promotes from the RC it was tagged on" \
  "1.0.0-rc.5 0.0.0-develop.5" "$(field_for 1.0.0 tag promote_from)"

echo
echo "release line 1.0 (after 1.0.0)"
commit c7
check "next RC targets .1, sorts above 1.0.0" "1.0.1-rc.6" "$(version_for 1.0 branch)"
git -C "$REPO" tag 1.0.1
check "1.0.1 promotes from its own RC" \
  "1.0.1-rc.6 0.0.0-develop.6" "$(field_for 1.0.1 tag promote_from)"

echo
echo "rejected refs"
check_fails "branch named N.N.N" 1.0.0 branch
check_fails "tag that is not N.N.N" v1.0.0 tag
check_fails "tag skipping a patch" 1.0.9 tag

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
