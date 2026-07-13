#!/usr/bin/env bash
#
# Tests for changelog assembly, ranges, the two-diff Unreleased page, frozen
# release pages, and the root index. No network: AI is always skipped. Notes
# come from COMMIT MESSAGES.
#
#   ./ci/changelog/test-changelog.sh

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(mktemp -d)"
PAGES="$(mktemp -d)"
trap 'rm -rf "$REPO_DIR" "$PAGES"' EXIT

pass=0; fail=0
contains() { case "$2" in *"$3"*) printf '  ok   %s\n' "$1"; pass=$((pass+1));; *) printf '  FAIL %s (missing: %s)\n' "$1" "$3"; fail=$((fail+1));; esac; }
excludes() { case "$2" in *"$3"*) printf '  FAIL %s (leaked: %s)\n' "$1" "$3"; fail=$((fail+1));; *) printf '  ok   %s\n' "$1"; pass=$((pass+1));; esac; }
check()    { if [ "$2" = "$3" ]; then printf '  ok   %s\n' "$1"; pass=$((pass+1)); else printf '  FAIL %s want=%s got=%s\n' "$1" "$2" "$3"; fail=$((fail+1)); fi; }
commit()   { git -C "$REPO_DIR" commit -q --allow-empty -m "$1"; }

git -C "$REPO_DIR" init -q -b develop
git -C "$REPO_DIR" config user.email t@t.t; git -C "$REPO_DIR" config user.name t

commit "root"
commit "G2P-1 Staff portal supports bulk consent import"
commit "G2P-2 Fix partner-API pagination dropping the last page"

echo "assemble: all commits / range since a tag"
notes=$(cd "$REPO_DIR" && bash "$HERE/assemble.sh")
contains "lists commits"       "$notes" "G2P-1 Staff portal supports bulk consent import"
contains "short sha ref"       "$notes" '(`'
linked=$(cd "$REPO_DIR" && REPO_URL=https://github.com/OpenG2P/demo bash "$HERE/assemble.sh")
contains "commit sha links to GitHub" "$linked" "https://github.com/OpenG2P/demo/commit/"
git -C "$REPO_DIR" tag 1.0.0
commit "G2P-3 Consent receipts are now signed JWTs"
since=$(cd "$REPO_DIR" && RANGE_FROM=1.0.0 RANGE_TO=HEAD bash "$HERE/assemble.sh")
contains "range includes new"  "$since" "signed JWTs"
excludes "range excludes old"  "$since" "bulk consent import"

# helper: run the changelog for the current HEAD as a develop build
build() { # $1 = version
  ( cd "$REPO_DIR" && REPO=demo VERSION="$1" FROZEN=false REVISION=$(git rev-parse HEAD) \
      PAGES_DIR="$PAGES" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
}

echo
echo "develop build #1 (first since release 1.0.0)"
build 0.0.0-develop.3
u=$(cat "$PAGES/demo/versions/unreleased.md")
contains "baseline names release"   "$u" "baseline: release 1.0.0"
contains "since-last-release header" "$u" "Since last release (1.0.0)"
contains "lists the commit"          "$u" "signed JWTs"
contains "jira linked"               "$u" "[G2P-3](https://openg2p.atlassian.net/browse/G2P-3)"
contains "records a build marker"    "$u" "<!-- build:0.0.0-develop.3 revision:"
excludes "no incremental on 1st build" "$u" "New in this build"

echo
echo "develop build #2 (adds one commit)"
commit "G2P-4 Add JWKS rotation endpoint"
build 0.0.0-develop.4
u2=$(cat "$PAGES/demo/versions/unreleased.md")
contains "incremental section present" "$u2" "New in this build (since 0.0.0-develop.3)"
contains "marker advanced"             "$u2" "<!-- build:0.0.0-develop.4 revision:"
# the incremental section should contain the new commit, not the older one
incr=$(printf '%s' "$u2" | awk '/^### New in this build/{f=1;next} /^### Since last release/{f=0} f')
contains "incremental has new commit"  "$incr" "JWKS rotation"
excludes "incremental omits older"     "$incr" "signed JWTs"
# cumulative still has both
contains "cumulative has both"         "$u2" "signed JWTs"

echo
echo "RC builds are durably paged, with rc-to-rc diffs"
git -C "$REPO_DIR" checkout -q -b 1.1
git -C "$REPO_DIR" commit -q --allow-empty -m "G2P-10 RC work one"
rcbuild() { ( cd "$REPO_DIR" && REPO=demo VERSION="$1" FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$PAGES" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ); }
rcbuild 1.1.0-rc.7
[ -f "$PAGES/demo/versions/1.1.0-rc.7.md" ] && r1=yes || r1=no
check "rc.7 durable page written" yes "$r1"
git -C "$REPO_DIR" commit -q --allow-empty -m "G2P-11 RC work two"
rcbuild 1.1.0-rc.8
[ -f "$PAGES/demo/versions/1.1.0-rc.8.md" ] && r2=yes || r2=no
check "rc.8 durable page written"  yes "$r2"
check "rc.7 page still there"      yes "$([ -f "$PAGES/demo/versions/1.1.0-rc.7.md" ] && echo yes || echo no)"
rc8=$(cat "$PAGES/demo/versions/1.1.0-rc.8.md")
contains "rc.8 shows diff vs rc.7"  "$rc8" "New in this build (since 1.1.0-rc.7)"
incr8=$(printf '%s' "$rc8" | awk '/^### New in this build/{f=1;next} /^### Since last release/{f=0} f')
contains "rc.8 delta has its commit"   "$incr8" "RC work two"
excludes "rc.8 delta omits rc.7 commit" "$incr8" "RC work one"
agg=$(cat "$PAGES/demo/CHANGELOG.md")
contains "aggregate has RC-in-progress section" "$agg" "Release candidates (in progress)"

echo
echo "cut release 1.0.1 (frozen)"
git -C "$REPO_DIR" checkout -q develop
git -C "$REPO_DIR" tag 1.0.1
( cd "$REPO_DIR" && REPO=demo VERSION=1.0.1 FROZEN=true REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$PAGES" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
[ -f "$PAGES/demo/versions/1.0.1.md" ] && v=yes || v=no
check "frozen page written"        yes "$v"
[ -f "$PAGES/demo/versions/unreleased.md" ] && u3=yes || u3=no
check "unreleased NOT wiped by a release" yes "$u3"   # develop's page self-heals on its next build
rel=$(cat "$PAGES/demo/versions/1.0.1.md")
contains "release labels baseline" "$rel" "changes since release 1.0.0"
agg=$(cat "$PAGES/demo/CHANGELOG.md")
contains "aggregate lists 1.0.1"   "$agg" "demo 1.0.1"

echo
echo "legacy v-prefixed tag is recognised as a baseline"
git -C "$REPO_DIR" tag v0.9.0 "$(git -C "$REPO_DIR" rev-list --max-parents=0 HEAD)"  # old-convention tag at root
# a develop build on a repo whose only release is v0.9.0 should baseline against it
( cd "$REPO_DIR" && REPO=demo VERSION=0.0.0-develop.99 FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$PAGES" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ) || true
# note: repo already has bare 1.0.0/1.0.1 tags nearer HEAD, so describe picks the nearest;
# assert directly on describe with only the v-tag reachable:
solo=$(mktemp -d)
git -C "$solo" init -q -b develop; git -C "$solo" config user.email t@t; git -C "$solo" config user.name t
git -C "$solo" commit -q --allow-empty -m base; git -C "$solo" tag v2.3.0
git -C "$solo" commit -q --allow-empty -m "G2P-7 after old release"
P2=$(mktemp -d)
( cd "$solo" && REPO=demo2 VERSION=0.0.0-develop.2 FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$P2" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
contains "baselines against v2.3.0"  "$(cat "$P2/demo2/versions/unreleased.md")" "Since last release (v2.3.0)"
rm -rf "$solo" "$P2"

echo
echo "diverged release line (tag not an ancestor of develop) baselines at merge-base"
dv=$(mktemp -d); Pd=$(mktemp -d)
git -C "$dv" init -q -b develop; git -C "$dv" config user.email t@t; git -C "$dv" config user.name t
git -C "$dv" commit -q --allow-empty -m "G2P-0 shared base"          # merge-base
git -C "$dv" checkout -q -b 1.2
git -C "$dv" commit -q --allow-empty -m "G2P-90 release-only fix"; git -C "$dv" tag v1.2.1
git -C "$dv" checkout -q develop
git -C "$dv" commit -q --allow-empty -m "G2P-91 develop-only work A"
git -C "$dv" commit -q --allow-empty -m "G2P-92 develop-only work B"
( cd "$dv" && REPO=dv VERSION=0.0.0-develop.3 FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Pd" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
dvu=$(cat "$Pd/dv/versions/unreleased.md")
contains "diverged: baselines at v1.2.1"     "$dvu" "Since last release (v1.2.1)"
contains "diverged: lists develop-only work" "$dvu" "develop-only work B"
excludes "diverged: excludes shared base"    "$dvu" "shared base"
excludes "diverged: excludes release-only"   "$dvu" "release-only fix"
rm -rf "$dv" "$Pd"

echo
echo "structural digest (git-derived, bounded)"
mkdir -p "$REPO_DIR/backend/migrations" "$REPO_DIR/ui"
echo "route" > "$REPO_DIR/backend/api_controller.py"
echo "ALTER" > "$REPO_DIR/backend/migrations/0002.sql"
echo '{}'    > "$REPO_DIR/package.json"
git -C "$REPO_DIR" add -A
git -C "$REPO_DIR" commit -q -m "G2P-5 add endpoint, migration, dep"
dig=$(cd "$REPO_DIR" && RANGE_FROM=1.0.1 RANGE_TO=HEAD bash "$HERE/digest.sh")
contains "digest has shortstat"        "$dig" "files changed"
contains "digest lists areas"          "$dig" "Areas touched:"
contains "digest flags migrations"     "$dig" "Migrations touched:"
contains "digest flags dependencies"   "$dig" "Dependency manifests changed:"
nodig=$(cd "$REPO_DIR" && RANGE_FROM= RANGE_TO=HEAD bash "$HERE/digest.sh")
check "digest empty without baseline"  "" "$nodig"

echo
echo "root index lists repos with a changelog"
mkdir -p "$PAGES/other-repo"; echo x > "$PAGES/other-repo/CHANGELOG.md"
mkdir -p "$PAGES/.github"
PAGES_DIR="$PAGES" bash "$HERE/render-root-index.sh" >/dev/null
idx=$(cat "$PAGES/index.md")
contains "index links demo"        "$idx" "[demo](./demo/CHANGELOG)"
contains "index links other-repo"  "$idx" "[other-repo](./other-repo/CHANGELOG)"
excludes "index skips .github"     "$idx" ".github"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
