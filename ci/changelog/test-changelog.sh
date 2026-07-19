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
u=$(cat "$PAGES/demo/versions/0.0.0-develop.3.md")
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
u2=$(cat "$PAGES/demo/versions/0.0.0-develop.4.md")
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
[ -f "$PAGES/demo/versions/0.0.0-develop.4.md" ] && u3=yes || u3=no
check "develop pages preserved by a release" yes "$u3"   # kept even when tagged on develop
rel=$(cat "$PAGES/demo/versions/1.0.1.md")
contains "release labels baseline" "$rel" "changes since release 1.0.0"
agg=$(cat "$PAGES/demo/CHANGELOG.md")
contains "aggregate lists 1.0.1"   "$agg" "demo 1.0.1"
# 1.0.1 is a LIGHTWEIGHT tag -> no release-notes section, and the tagged commit's
# own subject must not be mistaken for release notes.
excludes "lightweight tag: no release-notes section" "$rel" "### Release notes"

echo
echo "annotated release tag -> its message renders as Release notes"
at=$(mktemp -d); Pa=$(mktemp -d)
git -C "$at" init -q -b develop; git -C "$at" config user.email t@t; git -C "$at" config user.name t
git -C "$at" commit -q --allow-empty -m "G2P-50 First feature"
git -C "$at" commit -q --allow-empty -m "G2P-51 Second feature"
git -C "$at" tag -a 2.0.0 -m "$(printf 'GA release.\n\nHighlights:\n\n- Stable public API (G2P-50)\n- Ships the new engine')"
( cd "$at" && REPO=an VERSION=2.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Pa" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
ap=$(cat "$Pa/an/versions/2.0.0.md")
contains "annotated: Release notes section present" "$ap" "### Release notes"
contains "annotated: message subject shown"         "$ap" "GA release."
contains "annotated: message body shown"            "$ap" "Ships the new engine"
contains "annotated: jira ref in notes linkified"   "$ap" "[G2P-50](https://openg2p.atlassian.net/browse/G2P-50)"
# Release notes must sit ABOVE the auto summary, and the section shows on the aggregate.
notes_before_summary=$(printf '%s' "$ap" | awk '/^### Release notes/{r=NR} /^### Summary/{s=NR} END{print (r>0 && r<s)?"yes":"no"}')
check "annotated: notes appear before Summary"      yes "$notes_before_summary"
contains "annotated: aggregate carries release notes" "$(cat "$Pa/an/CHANGELOG.md")" "### Release notes"
rm -rf "$at" "$Pa"

echo
echo "external release notes (editable platform Release description) override the tag"
ov=$(mktemp -d); Pov=$(mktemp -d)
git -C "$ov" init -q -b develop; git -C "$ov" config user.email t@t; git -C "$ov" config user.name t
git -C "$ov" commit -q --allow-empty -m "G2P-70 feature"
git -C "$ov" tag -a 3.0.0 -m "Original tag message."
notesf="$ov/desc.md"
printf '\n\nEdited later via the Release UI.\n\nMore info: https://docs.openg2p.org/x  \n\n' > "$notesf"
( cd "$ov" && REPO=ov VERSION=3.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    RELEASE_NOTES_FILE="$notesf" PAGES_DIR="$Pov" SKIP_AI=true DATE=2026-07-18 \
    bash "$HERE/run.sh" >/dev/null )
ovp=$(cat "$Pov/ov/versions/3.0.0.md")
contains "override: uses Release description" "$ovp" "Edited later via the Release UI."
contains "override: keeps the link"           "$ovp" "https://docs.openg2p.org/x"
excludes "override: tag message not used"     "$ovp" "Original tag message."
# surrounding blank lines trimmed: content sits right under the (blank-separated) heading
adjacent=$(printf '%s' "$ovp" | awk '/^### Release notes/{getline; getline; print; exit}')
contains "override: leading blanks trimmed"   "$adjacent" "Edited later"
rm -rf "$ov" "$Pov"

echo
echo "blank external release notes -> fall back to the annotated tag"
fb=$(mktemp -d); Pfb=$(mktemp -d)
git -C "$fb" init -q -b develop; git -C "$fb" config user.email t@t; git -C "$fb" config user.name t
git -C "$fb" commit -q --allow-empty -m "G2P-71 feature"
git -C "$fb" tag -a 3.1.0 -m "Fallback tag notes."
empty="$fb/empty.md"; printf '   \n\n' > "$empty"     # whitespace-only == effectively empty
( cd "$fb" && REPO=fb VERSION=3.1.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    RELEASE_NOTES_FILE="$empty" PAGES_DIR="$Pfb" SKIP_AI=true DATE=2026-07-18 \
    bash "$HERE/run.sh" >/dev/null )
contains "blank override: tag message used" "$(cat "$Pfb/fb/versions/3.1.0.md")" "Fallback tag notes."
rm -rf "$fb" "$Pfb"

echo
echo "auto-created Release: the hidden publish-link footer is stripped from the page"
ft=$(mktemp -d); Pft=$(mktemp -d)
git -C "$ft" init -q -b develop; git -C "$ft" config user.email t@t; git -C "$ft" config user.name t
git -C "$ft" commit -q --allow-empty -m "G2P-72 feature"
git -C "$ft" tag -a 4.0.0 -m "unused"
descf="$ft/desc.md"
printf 'Real release notes here.\n\n<!-- openg2p:publish-link -->\n---\n*Edited these notes? [Publish to the changelog](https://gitlab.example/x/-/pipelines/new?ref=4.0.0)*\n' > "$descf"
( cd "$ft" && REPO=ft VERSION=4.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    RELEASE_NOTES_FILE="$descf" PAGES_DIR="$Pft" SKIP_AI=true DATE=2026-07-18 \
    bash "$HERE/run.sh" >/dev/null )
ftp=$(cat "$Pft/ft/versions/4.0.0.md")
contains "footer: real notes shown"       "$ftp" "Real release notes here."
excludes "footer: publish link stripped"  "$ftp" "Publish to the changelog"
excludes "footer: marker stripped"        "$ftp" "openg2p:publish-link"
rm -rf "$ft" "$Pft"

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
contains "baselines against v2.3.0"  "$(cat "$P2/demo2/versions/0.0.0-develop.2.md")" "Since last release (v2.3.0)"
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
dvu=$(cat "$Pd/dv/versions/0.0.0-develop.3.md")
contains "diverged: baselines at v1.2.1"     "$dvu" "Since last release (v1.2.1)"
contains "diverged: lists develop-only work" "$dvu" "develop-only work B"
excludes "diverged: excludes shared base"    "$dvu" "shared base"
excludes "diverged: excludes release-only"   "$dvu" "release-only fix"
# A FROZEN release tagged on develop must show the SAME v1.2.1 baseline (not "first release").
git -C "$dv" tag 2.0.0
( cd "$dv" && REPO=dv VERSION=2.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Pd" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
contains "diverged frozen: since v1.2.1"     "$(cat "$Pd/dv/versions/2.0.0.md")" "changes since release v1.2.1"
excludes "diverged frozen: not first release" "$(cat "$Pd/dv/versions/2.0.0.md")" "first release"
rm -rf "$dv" "$Pd"

echo
echo "retention: develop keeps the last 3 (KEEP); older ones pruned"
rd=$(mktemp -d); Pr=$(mktemp -d)
git -C "$rd" init -q -b develop; git -C "$rd" config user.email t@t; git -C "$rd" config user.name t
git -C "$rd" commit -q --allow-empty -m base; git -C "$rd" tag 1.0.0
rbuild() { ( cd "$rd" && REPO=rd VERSION="$1" FROZEN="${2:-false}" REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Pr" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ); }
present() { [ -f "$Pr/rd/versions/$1.md" ] && echo yes || echo no; }
for n in 10 11 12 13 14; do git -C "$rd" commit -q --allow-empty -m "G2P-$n dev $n"; rbuild "0.0.0-develop.$n"; done
check "develop.14 kept"  yes "$(present 0.0.0-develop.14)"
check "develop.12 kept"  yes "$(present 0.0.0-develop.12)"
check "develop.11 pruned" no "$(present 0.0.0-develop.11)"
check "develop.10 pruned" no "$(present 0.0.0-develop.10)"
agg=$(cat "$Pr/rd/CHANGELOG.md")
contains "has Develop builds section" "$agg" "# Develop builds"
excludes "table drops pruned develop" "$agg" "0.0.0-develop.10"

echo
echo "retention: RCs keep last 3 per line; a release deletes that line's RCs"
git -C "$rd" checkout -q -b 2.0
for n in 20 21 22 23 24; do git -C "$rd" commit -q --allow-empty -m "G2P-$n rc $n"; rbuild "2.0.0-rc.$n"; done
check "rc.24 kept"   yes "$(present 2.0.0-rc.24)"
check "rc.22 kept"   yes "$(present 2.0.0-rc.22)"
check "rc.21 pruned"  no "$(present 2.0.0-rc.21)"
git -C "$rd" tag 2.0.0
rbuild 2.0.0 true
check "release 2.0.0 written"     yes "$(present 2.0.0)"
check "rc.24 deleted by release"   no "$(present 2.0.0-rc.24)"
check "rc.22 deleted by release"   no "$(present 2.0.0-rc.22)"
excludes "table has no RCs after release" "$(cat "$Pr/rd/CHANGELOG.md")" "2.0.0-rc."
rm -rf "$rd" "$Pr"

echo
echo "summary table sorts by datetime (a same-day release below a newer develop build)"
sd=$(mktemp -d); Ps=$(mktemp -d)
git -C "$sd" init -q -b develop; git -C "$sd" config user.email t@t; git -C "$sd" config user.name t
git -C "$sd" commit -q --allow-empty -m base
GIT_COMMITTER_DATE="2026-08-01T08:00:00" GIT_AUTHOR_DATE="2026-08-01T08:00:00" \
  git -C "$sd" commit -q --allow-empty -m "G2P-50 release commit (early)"
git -C "$sd" tag 3.0.0
( cd "$sd" && REPO=sd VERSION=3.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Ps" SKIP_AI=true DATE=2026-08-01 bash "$HERE/run.sh" >/dev/null )
GIT_COMMITTER_DATE="2026-08-01T15:00:00" GIT_AUTHOR_DATE="2026-08-01T15:00:00" \
  git -C "$sd" commit -q --allow-empty -m "G2P-51 develop commit (later, same day)"
( cd "$sd" && REPO=sd VERSION=0.0.0-develop.4 FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Ps" SKIP_AI=true DATE=2026-08-01 bash "$HERE/run.sh" >/dev/null )
first_row=$(awk '/^\| \[/{print; exit}' "$Ps/sd/CHANGELOG.md")
contains "newest-by-time row is the later develop build" "$first_row" "0.0.0-develop.4"
rm -rf "$sd" "$Ps"

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
echo "repo + registry links (.meta) and the elaborated intro"
mp=$(mktemp -d); mkdir -p "$mp/svc/versions"
printf '## svc 1.0.0 — 2026-07-13\n\n<!-- build:1.0.0 revision:abc ts:100 -->\n\n### Summary\n\n- x\n' > "$mp/svc/versions/1.0.0.md"
printf 'repo=https://gitlab.com/openg2p/svc\nimages=https://gitlab.com/openg2p/svc/container_registry\n' > "$mp/svc/.meta"
PAGES_DIR="$mp" REPO=svc bash "$HERE/render-aggregate.sh"
agg=$(cat "$mp/svc/CHANGELOG.md")
contains "CHANGELOG shows repository link"    "$agg" "(https://gitlab.com/openg2p/svc)"
contains "CHANGELOG shows container registry" "$agg" "svc/container_registry)"
HELM_REGISTRY_URL="https://gitlab.com/openg2p/charts/-/packages" PAGES_DIR="$mp" bash "$HERE/render-root-index.sh" >/dev/null
idx2=$(cat "$mp/index.md")
contains "intro names Helm packages"    "$idx2" "Helm package"
contains "intro: versions locked"       "$idx2" "locked together"
contains "intro links helm registry"    "$idx2" "openg2p/charts/-/packages"
contains "listing links the repo"       "$idx2" "(https://gitlab.com/openg2p/svc)"
PAGES_DIR="$mp" bash "$HERE/render-root-index.sh" >/dev/null   # no HELM_REGISTRY_URL
idx3=$(cat "$mp/index.md")
excludes "generic intro omits registry" "$idx3" "openg2p/charts/-/packages"
contains "generic intro still elaborate" "$idx3" "Helm package"
rm -rf "$mp"

echo
echo "subgrouped project keeps its path (spar/spar) in the display, folder stays flat"
sg=$(mktemp -d); Psg=$(mktemp -d)
git -C "$sg" init -q -b develop; git -C "$sg" config user.email t@t; git -C "$sg" config user.name t
git -C "$sg" commit -q --allow-empty -m "G2P-60 initial"
( cd "$sg" && REPO=spar-spar REPO_DISPLAY=spar/spar VERSION=0.0.0-develop.2 FROZEN=false \
    REVISION=$(git rev-parse HEAD) PAGES_DIR="$Psg" SKIP_AI=true DATE=2026-07-18 \
    bash "$HERE/run.sh" >/dev/null )
check "folder key stays flat (spar-spar)" yes "$([ -d "$Psg/spar-spar" ] && echo yes || echo no)"
sgp=$(cat "$Psg/spar-spar/versions/0.0.0-develop.2.md")
contains "page heading shows spar/spar"   "$sgp" "spar/spar — develop"
excludes "page heading not flattened"     "$sgp" "spar-spar — develop"
sga=$(cat "$Psg/spar-spar/CHANGELOG.md")
contains "aggregate title is the module name" "$sga" "# spar/spar"
excludes "aggregate title drops 'changelog'"  "$sga" "# spar/spar changelog"
sgi=$(cat "$Psg/index.md")
contains "index label shows spar/spar"     "$sgi" "[spar/spar](./spar-spar/CHANGELOG"
excludes "index label not flattened"       "$sgi" "[spar-spar]"
rm -rf "$sg" "$Psg"

echo
echo "library repo: rolling per-branch page (last 5 commits) + tag release, grouped separately"
lb=$(mktemp -d); Plb=$(mktemp -d)
git -C "$lb" init -q -b develop; git -C "$lb" config user.email t@t; git -C "$lb" config user.name t
for i in 1 2 3 4 5 6; do git -C "$lb" commit -q --allow-empty -m "G2P-$((600+i)) lib change $i"; done
git -C "$lb" tag -a 1.0.0 -m "First library release."
librun() { ( cd "$lb" && REPO=mylib REPO_DISPLAY=mylib CHANGELOG_KIND=library \
  REPO_URL=https://github.com/OpenG2P/mylib PAGES_DIR="$Plb" SKIP_AI=true \
  REVISION=$(git -C "$lb" rev-parse HEAD) env "$@" bash "$HERE/run.sh" >/dev/null ); }
# a tagged library release (frozen)
librun VERSION=1.0.0 FROZEN=true DATE=2026-07-18
# then two more commits on the branch, and a branch build
git -C "$lb" commit -q --allow-empty -m "G2P-700 post-release work A"
git -C "$lb" commit -q --allow-empty -m "G2P-701 post-release work B"
librun VERSION=develop FROZEN=false BRANCH=develop DATE=2026-07-19
check "library: rolling branch page written"  yes "$([ -f "$Plb/mylib/versions/branch-develop.md" ] && echo yes || echo no)"
check "library: tag release page written"     yes "$([ -f "$Plb/mylib/versions/1.0.0.md" ] && echo yes || echo no)"
bpg=$(cat "$Plb/mylib/versions/branch-develop.md")
contains "library: page names the branch"     "$bpg" "\`develop\` branch"
contains "library: recent-commits heading"     "$bpg" "Recent commits (latest 5)"
contains "library: baseline is the tag"        "$bpg" "since 1.0.0"
contains "library: lists newest commit"        "$bpg" "post-release work B"
contains "library: keeps the 5th-newest"       "$bpg" "lib change 4"
excludes "library: drops the 6th-newest"       "$bpg" "lib change 3"
lagg=$(cat "$Plb/mylib/CHANGELOG.md")
contains "library agg: Branches section"       "$lagg" "# Branches (moving)"
contains "library agg: Releases section"       "$lagg" "# Releases"
contains "library agg: table shows branch name" "$lagg" "[\`develop\`](#v-branch-develop)"
contains "library agg: library footnote"       "$lagg" "consumed directly by git"
excludes "library agg: no develop-N wording"   "$lagg" "develop builds"
contains "index: Libraries section"            "$(cat "$Plb/index.md")" "### Libraries"
# a v-prefixed tag (legacy convention some libraries use) is still listed as a release
git -C "$lb" tag -a v2.0.0 -m "Second lib release."
librun VERSION=v2.0.0 FROZEN=true DATE=2026-07-20
check "library: v-tag release page written"    yes "$([ -f "$Plb/mylib/versions/v2.0.0.md" ] && echo yes || echo no)"
contains "library: v-tag listed in table"      "$(cat "$Plb/mylib/CHANGELOG.md")" "[\`v2.0.0\`]"
rm -rf "$lb" "$Plb"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
