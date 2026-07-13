#!/usr/bin/env bash
#
# Tests for the changelog assembly + range + render logic. No network: AI is
# always skipped. Notes come from COMMIT MESSAGES. Builds a throwaway repo,
# commits across a release tag, and asserts what each range produces.
#
#   ./ci/changelog/test-changelog.sh

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(mktemp -d)"
PAGES="$(mktemp -d)"
trap 'rm -rf "$REPO_DIR" "$PAGES"' EXIT

pass=0; fail=0
check() { # desc expected actual
  if [ "$2" = "$3" ]; then printf '  ok   %s\n' "$1"; pass=$((pass+1))
  else printf '  FAIL %s\n       want: %s\n       got:  %s\n' "$1" "$2" "$3"; fail=$((fail+1)); fi
}
contains() { # desc haystack needle
  case "$2" in *"$3"*) printf '  ok   %s\n' "$1"; pass=$((pass+1));;
  *) printf '  FAIL %s (missing: %s)\n' "$1" "$3"; fail=$((fail+1));; esac
}
excludes() { # desc haystack needle
  case "$2" in *"$3"*) printf '  FAIL %s (leaked: %s)\n' "$1" "$3"; fail=$((fail+1));;
  *) printf '  ok   %s\n' "$1"; pass=$((pass+1));; esac
}
commit() { git -C "$REPO_DIR" commit -q --allow-empty -m "$1"; }

git -C "$REPO_DIR" init -q -b develop
git -C "$REPO_DIR" config user.email t@t.t; git -C "$REPO_DIR" config user.name t

commit "root"
commit "G2P-1 Staff portal supports bulk consent import"
commit "G2P-2 Fix partner-API pagination dropping the last page"

echo "assemble: all commits (no lower bound)"
notes=$(cd "$REPO_DIR" && bash "$HERE/assemble.sh")
contains "lists first commit"  "$notes" "G2P-1 Staff portal supports bulk consent import"
contains "lists second commit" "$notes" "G2P-2 Fix partner-API pagination"
contains "has a short sha ref"  "$notes" '(`'
excludes "no merge/root noise" "$notes" "root
- root"

echo
echo "freeze 1.0.0, then add a commit on develop"
git -C "$REPO_DIR" tag 1.0.0
commit "G2P-3 Consent receipts are now signed JWTs"

echo "assemble: only commits since 1.0.0"
since=$(cd "$REPO_DIR" && RANGE_FROM=1.0.0 RANGE_TO=HEAD bash "$HERE/assemble.sh")
contains "includes the new one"        "$since" "signed JWTs"
excludes "excludes pre-1.0.0 commits"  "$since" "bulk consent import"

echo
echo "no commits in an empty range"
empty=$(cd "$REPO_DIR" && RANGE_FROM=HEAD RANGE_TO=HEAD bash "$HERE/assemble.sh")
check "empty output" "" "$empty"

echo
echo "render: unreleased page + aggregate"
rev=$(git -C "$REPO_DIR" rev-parse HEAD)
printf '%s\n' "$since" > "$PAGES/notes.md"
PAGES_DIR="$PAGES" REPO=demo VERSION=0.0.0-develop.4 REVISION="$rev" \
  PREV_VERSION=1.0.0 DATE=2026-07-12 MODE=unreleased \
  NOTES_FILE="$PAGES/notes.md" SUMMARY_FILE=/dev/null SUMMARY_OK=false \
  bash "$HERE/render.sh" >/dev/null
[ -f "$PAGES/demo/versions/unreleased.md" ] && u=yes || u=no
check "unreleased page written" yes "$u"
agg=$(cat "$PAGES/demo/CHANGELOG.md")
contains "aggregate has title"        "$agg" "# demo changelog"
contains "aggregate has Unreleased"   "$agg" "Unreleased"
contains "placeholder when no AI"     "$agg" "AI summary unavailable"
contains "shows since-version"        "$agg" "changes since 1.0.0"
contains "lists the commit note"      "$agg" "signed JWTs"
contains "jira ref linked"            "$agg" "[G2P-3](https://openg2p.atlassian.net/browse/G2P-3)"

echo
echo "render: freeze to 1.0.1 clears unreleased, adds a version page"
PAGES_DIR="$PAGES" REPO=demo VERSION=1.0.1 REVISION="$rev" \
  PREV_VERSION=1.0.0 DATE=2026-07-12 MODE=frozen \
  NOTES_FILE="$PAGES/notes.md" SUMMARY_FILE=/dev/null SUMMARY_OK=false \
  bash "$HERE/render.sh" >/dev/null
[ -f "$PAGES/demo/versions/1.0.1.md" ] && v=yes || v=no
check "frozen page written"        yes "$v"
[ -f "$PAGES/demo/versions/unreleased.md" ] && u2=yes || u2=no
check "unreleased cleared"         no  "$u2"
contains "aggregate lists 1.0.1"   "$(cat "$PAGES/demo/CHANGELOG.md")" "demo 1.0.1"

echo
echo "root index lists repos with a changelog"
mkdir -p "$PAGES/other-repo"; echo x > "$PAGES/other-repo/CHANGELOG.md"
mkdir -p "$PAGES/.github"     # must be ignored (no CHANGELOG.md)
PAGES_DIR="$PAGES" bash "$HERE/render-root-index.sh" >/dev/null
idx=$(cat "$PAGES/index.md")
contains "index links demo"       "$idx" "[demo](./demo/CHANGELOG)"
contains "index links other-repo" "$idx" "[other-repo](./other-repo/CHANGELOG)"
excludes "index skips .github"    "$idx" ".github"
contains "index has front matter" "$idx" "title: OpenG2P changelogs"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
