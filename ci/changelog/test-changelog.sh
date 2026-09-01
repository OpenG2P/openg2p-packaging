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
# no previous develop page yet -> baseline falls back to the last release tag
contains "baseline is the last tag"  "$u" "changes since 1.0.0"
contains "delta section header"      "$u" "### Changes"
excludes "baseline not repeated in heading" "$u" "### Changes since"
contains "lists the commit"          "$u" "signed JWTs"
contains "jira linked"               "$u" "[G2P-3](https://openg2p.atlassian.net/browse/G2P-3)"
contains "records a build marker"    "$u" "<!-- build:0.0.0-develop.3 revision:"
excludes "no cumulative section"     "$u" "Since last release"

echo
echo "develop build #2 (delta vs the PREVIOUS develop build, not cumulative)"
commit "G2P-4 Add JWKS rotation endpoint"
build 0.0.0-develop.4
u2=$(cat "$PAGES/demo/versions/0.0.0-develop.4.md")
contains "diffs against previous develop" "$u2" "changes since 0.0.0-develop.3"
contains "delta section header"           "$u2" "### Changes"
excludes "baseline not repeated in heading" "$u2" "### Changes since"
contains "marker advanced"                "$u2" "<!-- build:0.0.0-develop.4 revision:"
contains "delta has the new commit"       "$u2" "JWKS rotation"
# the whole point: an older commit already shown on develop.3 is NOT repeated here
excludes "delta omits the earlier commit" "$u2" "signed JWTs"

echo
echo "RC builds are durably paged, with rc-to-rc diffs"
git -C "$REPO_DIR" checkout -q -b 1.1
git -C "$REPO_DIR" commit -q --allow-empty -m "G2P-10 RC work one"
rcbuild() { ( cd "$REPO_DIR" && REPO=demo VERSION="$1" FROZEN=false REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$PAGES" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ); }
rcbuild 1.1.0-rc.7
[ -f "$PAGES/demo/versions/1.1.0-rc.7.md" ] && r1=yes || r1=no
check "rc.7 durable page written" yes "$r1"
# FIRST RC on a new line diffs against the branch point: the newest ANCESTOR develop build
rc7=$(cat "$PAGES/demo/versions/1.1.0-rc.7.md")
contains "first RC diffs vs branch-point develop" "$rc7" "changes since 0.0.0-develop.4"
contains "first RC delta has its commit"          "$rc7" "RC work one"
git -C "$REPO_DIR" commit -q --allow-empty -m "G2P-11 RC work two"
rcbuild 1.1.0-rc.8
[ -f "$PAGES/demo/versions/1.1.0-rc.8.md" ] && r2=yes || r2=no
check "rc.8 durable page written"  yes "$r2"
check "rc.7 page still there"      yes "$([ -f "$PAGES/demo/versions/1.1.0-rc.7.md" ] && echo yes || echo no)"
rc8=$(cat "$PAGES/demo/versions/1.1.0-rc.8.md")
contains "rc.8 diffs vs rc.7"           "$rc8" "changes since 1.1.0-rc.7"
contains "rc.8 delta has its commit"    "$rc8" "RC work two"
excludes "rc.8 delta omits rc.7 commit" "$rc8" "RC work one"
agg=$(cat "$PAGES/demo/CHANGELOG.md")
contains "aggregate has an RC section" "$agg" "# Release candidates"

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
echo "annotated tag survives actions/checkout clobbering the ref to a lightweight tag"
# actions/checkout fetches a tag as `+<commit-sha>:refs/tags/<name>`, which REPLACES the
# annotated tag object with a lightweight ref -- the message then isn't in the clone.
# run.sh must re-fetch the tag ref from origin and still render the release notes.
cb=$(mktemp -d); cbwork=$(mktemp -d); Pcb=$(mktemp -d)
git -C "$cb" init -q -b develop; git -C "$cb" config user.email t@t; git -C "$cb" config user.name t
git -C "$cb" commit -q --allow-empty -m "G2P-80 the feature"
git -C "$cb" tag -a 5.0.0 -m "Annotated notes that must survive."
git clone -q "$cb" "$cbwork/clone" 2>/dev/null
git -C "$cbwork/clone" config user.email t@t; git -C "$cbwork/clone" config user.name t
# simulate actions/checkout: force the tag ref to point straight at the COMMIT
sha=$(git -C "$cbwork/clone" rev-list -n1 5.0.0)
git -C "$cbwork/clone" tag -f 5.0.0 "$sha" >/dev/null 2>&1
check "precondition: tag is lightweight in the clone" commit \
  "$(git -C "$cbwork/clone" for-each-ref refs/tags/5.0.0 --format='%(objecttype)')"
( cd "$cbwork/clone" && REPO=cb VERSION=5.0.0 FROZEN=true REVISION=$(git rev-parse HEAD) \
    PAGES_DIR="$Pcb" SKIP_AI=true DATE=2026-07-25 bash "$HERE/run.sh" >/dev/null )
cbp=$(cat "$Pcb/cb/versions/5.0.0.md")
contains "clobbered tag: Release notes still rendered" "$cbp" "### Release notes"
contains "clobbered tag: message recovered"           "$cbp" "Annotated notes that must survive."
rm -rf "$cb" "$cbwork" "$Pcb"

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
contains "baselines against v2.3.0"  "$(cat "$P2/demo2/versions/0.0.0-develop.2.md")" "changes since v2.3.0"
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
contains "diverged: baselines at v1.2.1"     "$dvu" "changes since v1.2.1"
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
echo "retention: every develop page is KEPT; the catalogue shows the newest RENDER_KEEP"
rd=$(mktemp -d); Pr=$(mktemp -d)
git -C "$rd" init -q -b develop; git -C "$rd" config user.email t@t; git -C "$rd" config user.name t
git -C "$rd" commit -q --allow-empty -m base; git -C "$rd" tag 1.0.0
rbuild() { ( cd "$rd" && REPO=rd VERSION="$1" FROZEN="${2:-false}" REVISION=$(git rev-parse HEAD) \
    KEEP=3 KEEP_RC=3 PAGES_DIR="$Pr" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ); }
present() { [ -f "$Pr/rd/versions/$1.md" ] && echo yes || echo no; }
for n in 10 11 12 13 14; do git -C "$rd" commit -q --allow-empty -m "G2P-$n dev $n"; rbuild "0.0.0-develop.$n"; done
check "develop.14 kept"  yes "$(present 0.0.0-develop.14)"
check "develop.12 kept"  yes "$(present 0.0.0-develop.12)"
# Pages are permanent now: nothing deletes them, so a note written on an old build
# cannot silently disappear with it.
check "develop.11 KEPT on disk" yes "$(present 0.0.0-develop.11)"
check "develop.10 KEPT on disk" yes "$(present 0.0.0-develop.10)"
agg=$(cat "$Pr/rd/CHANGELOG.md")
contains "has Develop builds section" "$agg" "# Develop builds"
# ...but the rendered catalogue is bounded, so the oldest are simply not shown.
agg3=$(RENDER_KEEP=3 PAGES_DIR="$Pr" REPO=rd bash "$HERE/render-aggregate.sh" >/dev/null 2>&1; cat "$Pr/rd/CHANGELOG.md")
contains "catalogue shows the newest"      "$agg3" "0.0.0-develop.14"
excludes "catalogue omits beyond the cap"  "$agg3" "0.0.0-develop.10"

echo
echo "retention: RC pages are KEPT; a release keeps them too (audit trail)"
git -C "$rd" checkout -q -b 2.0
for n in 20 21 22 23 24; do git -C "$rd" commit -q --allow-empty -m "G2P-$n rc $n"; rbuild "2.0.0-rc.$n"; done
check "rc.24 kept"   yes "$(present 2.0.0-rc.24)"
check "rc.22 kept"   yes "$(present 2.0.0-rc.22)"
check "rc.21 KEPT on disk" yes "$(present 2.0.0-rc.21)"
git -C "$rd" tag 2.0.0
rbuild 2.0.0 true
check "release 2.0.0 written"     yes "$(present 2.0.0)"
check "rc.24 SURVIVES the release" yes "$(present 2.0.0-rc.24)"
check "rc.22 SURVIVES the release" yes "$(present 2.0.0-rc.22)"
contains "table still lists the RCs" "$(cat "$Pr/rd/CHANGELOG.md")" "2.0.0-rc.24"
contains "RC section still rendered"  "$(cat "$Pr/rd/CHANGELOG.md")" "# Release candidates"
rm -rf "$rd" "$Pr"

echo
echo "defaults: every page kept on disk, catalogue renders the newest 20 develop builds"
kd=$(mktemp -d); Pk=$(mktemp -d)
git -C "$kd" init -q -b develop; git -C "$kd" config user.email t@t; git -C "$kd" config user.name t
git -C "$kd" commit -q --allow-empty -m base; git -C "$kd" tag 1.0.0
for n in $(seq 1 22); do
  git -C "$kd" commit -q --allow-empty -m "G2P-$n dev $n"
  ( cd "$kd" && REPO=kd VERSION="0.0.0-develop.$n" FROZEN=false REVISION=$(git rev-parse HEAD) \
      PAGES_DIR="$Pk" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null )
done
kept=$(ls "$Pk/kd/versions" | grep -c '^0\.0\.0-develop\.' || true)
check "every page kept on disk"    22  "$kept"
check "newest (22) kept"           yes "$([ -f "$Pk/kd/versions/0.0.0-develop.22.md" ] && echo yes || echo no)"
check "oldest (1) kept too"        yes "$([ -f "$Pk/kd/versions/0.0.0-develop.1.md" ] && echo yes || echo no)"
# The catalogue is bounded at 20 by default, so the two oldest are not rendered.
kagg=$(cat "$Pk/kd/CHANGELOG.md")
contains "catalogue renders the newest"   "$kagg" "0.0.0-develop.22"
excludes "catalogue omits the 21st-oldest" "$kagg" "0.0.0-develop.2.md"
contains "footnote states both numbers" "$(cat "$Pk/kd/CHANGELOG.md")" "latest 20 develop builds"
contains "footnote states RC number"    "$(cat "$Pk/kd/CHANGELOG.md")" "latest 10 release"
rm -rf "$kd" "$Pk"

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
echo "a release states which build it is identical to (promoted, not rebuilt)"
pf=$(mktemp -d); Ppf=$(mktemp -d)
git -C "$pf" init -q -b develop; git -C "$pf" config user.email t@t; git -C "$pf" config user.name t
git -C "$pf" commit -q --allow-empty -m "G2P-80 base"
git -C "$pf" commit -q --allow-empty -m "G2P-81 release work"
git -C "$pf" checkout -q -b 1.3
pfrun(){ ( cd "$pf" && REPO=pf REPO_DISPLAY=pf VERSION="$1" FROZEN="${2:-false}" \
   REVISION=$(git -C "$pf" rev-parse HEAD) PAGES_DIR="$Ppf" SKIP_AI=true DATE=2026-08-06 \
   bash "$HERE/run.sh" >/dev/null 2>&1 ); }
cnt=$(git -C "$pf" rev-list --count HEAD)
pfrun "1.3.0-rc.${cnt}"          # the RC at this commit
git -C "$pf" tag 1.3.0
pfrun 1.3.0 true                 # the release, SAME commit
rp=$(cat "$Ppf/pf/versions/1.3.0.md")
contains "release names its source build" "$rp" "Same artifact as [\`1.3.0-rc.${cnt}\`]"
contains "release says not rebuilt"       "$rp" "promoted"
contains "release says no code changed"   "$rp" "No code changed between them"
check    "the RC page survives"           yes "$([ -f "$Ppf/pf/versions/1.3.0-rc.${cnt}.md" ] && echo yes || echo no)"
rm -rf "$pf" "$Ppf"

# --- marking a develop build known-good, without releasing it ---------------
#
# Not every good build is shipped. A version can be declared "Intermediate Stable
# Version" by adding a line to <repo>/.marked in the versions repo -- a plain,
# hand-editable file, no tag and therefore no release. Two things must hold or the
# mark is worthless: it shows in the table, and retention must never delete the page
# it points at (a develop page would otherwise age out after KEEP builds).
echo "a hand-edited version page is never regenerated over"
# The point of keeping pages forever is that you can write on them. That only holds
# if a re-run of the same version leaves the page alone -- a version is immutable,
# so its page is written once.
wd=$(mktemp -d); Pw=$(mktemp -d)
git -C "$wd" init -q -b develop; git -C "$wd" config user.email t@t; git -C "$wd" config user.name t
git -C "$wd" commit -q --allow-empty -m base; git -C "$wd" tag 1.0.0
git -C "$wd" commit -q --allow-empty -m "G2P-1 first"
wbuild() { ( cd "$wd" && REPO=wd VERSION="$1" FROZEN="${2:-false}" REVISION=$(git rev-parse HEAD) \
  PAGES_DIR="$Pw" SKIP_AI=true DATE=2026-07-13 bash "$HERE/run.sh" >/dev/null ); }
wbuild 0.0.0-develop.1
page="$Pw/wd/versions/0.0.0-develop.1.md"
check "the page was written" yes "$([ -f "$page" ] && echo yes || echo no)"
printf '\n> Hand-written: verified on staging, safe to deploy.\n' >> "$page"
wbuild 0.0.0-develop.1                      # same version, built again
contains "the hand-written note survives a re-run" "$(cat "$page")" "verified on staging"
# ...and a release page is protected the same way.
git -C "$wd" tag 2.0.0
wbuild 2.0.0 true
rpage="$Pw/wd/versions/2.0.0.md"
printf '\n> Hand-written release addendum.\n' >> "$rpage"
wbuild 2.0.0 true
contains "a release page is protected too" "$(cat "$rpage")" "release addendum"
rm -rf "$wd" "$Pw"

echo
echo "a marked develop build is flagged in the catalogue"
mk=$(mktemp -d); Pmk=$(mktemp -d)
git -C "$mk" init -q -b develop; git -C "$mk" config user.email t@t; git -C "$mk" config user.name t
mkrun(){ git -C "$mk" commit -q --allow-empty -m "G2P-9$1 change $1"
  ( cd "$mk" && REPO=mk REPO_DISPLAY=mk VERSION="0.0.0-develop.$1" FROZEN=false \
      REVISION=$(git -C "$mk" rev-parse HEAD) PAGES_DIR="$Pmk" SKIP_AI=true DATE=2026-08-25 \
      KEEP=3 bash "$HERE/run.sh" >/dev/null 2>&1 ); }
mkrun 1
# Mark build 1 by hand, exactly as an operator would edit the file.
printf '0.0.0-develop.1|**Intermediate Stable Version** — verified on staging\n' > "$Pmk/mk/.marked"
for n in 2 3 4 5; do mkrun "$n"; done      # KEEP=3, so 1 and 2 would normally be pruned
check    "the marked page is present"          yes "$([ -f "$Pmk/mk/versions/0.0.0-develop.1.md" ] && echo yes || echo no)"
check    "an unmarked page is present too"     yes "$([ -f "$Pmk/mk/versions/0.0.0-develop.2.md" ] && echo yes || echo no)"
mkagg=$(cat "$Pmk/mk/CHANGELOG.md")
contains "table has a Notes column"  "$mkagg" "| Version | Date | Type | Notes |"
# The note must also reach the version's own section on the page, and it must get
# there WITHOUT rebuilding: marking happens long after the page was written, so
# re-rendering only the aggregate has to be enough.
PAGES_DIR="$Pmk" REPO=mk bash "$HERE/render-aggregate.sh" >/dev/null
mkagg=$(cat "$Pmk/mk/CHANGELOG.md")
contains "the note appears in the version's section" "$mkagg" "> **Note** — **Intermediate Stable Version** — verified on staging"
contains "the note renders as written" "$mkagg" "**Intermediate Stable Version** — verified on staging"
excludes "the note is not double-wrapped" "$mkagg" "***Intermediate"
rm -rf "$mk" "$Pmk"

# --- a NON-SemVer version must still reach the catalogue -------------------
#
# Some artefacts are not versioned by the derived SemVer scheme at all: the themed
# Keycloak image is tagged 24.0.5-debian-12-r1-g2pN, chosen by the operator. Its page
# was written correctly, but the aggregate selected releases by MATCHING a SemVer
# pattern, so the version appeared in no section and the catalogue rendered an empty
# table -- silently, with no error anywhere. Releases are now selected by EXCLUDING
# the three transient shapes instead.
echo "a non-SemVer version is listed as a release"
nv=$(mktemp -d); Pnv=$(mktemp -d)
git -C "$nv" init -q -b develop; git -C "$nv" config user.email t@t; git -C "$nv" config user.name t
git -C "$nv" commit -q --allow-empty -m "G2P-90 add the agent portal theme"
( cd "$nv" && REPO=nv REPO_DISPLAY=nv VERSION=24.0.5-debian-12-r1-g2p2 FROZEN=true \
    REVISION=$(git -C "$nv" rev-parse HEAD) PAGES_DIR="$Pnv" SKIP_AI=true DATE=2026-08-25 \
    bash "$HERE/run.sh" >/dev/null 2>&1 )
nvp="$Pnv/nv/versions/24.0.5-debian-12-r1-g2p2.md"
check    "the version page is written" yes "$([ -f "$nvp" ] && echo yes || echo no)"
nvagg=$(cat "$Pnv/nv/CHANGELOG.md")
contains "aggregate lists it in the table"   "$nvagg" "24.0.5-debian-12-r1-g2p2"
contains "and renders its section"           "$nvagg" "# Releases"
excludes "it is not treated as a develop build" "$nvagg" "develop 24.0.5"
rm -rf "$nv" "$Pnv"

# --- HTML in a commit subject must not escape into the page ----------------
#
# A subject reading "Drop the inline maps <style>" opened a real <style> element
# on the published catalogue and swallowed the 29,686 characters after it — five
# changelog entries invisible in a browser while curl returned a complete
# document. `<style>`, `<script>`, `<textarea>` and `<title>` are the dangerous
# ones: the HTML parser treats their contents as raw text, so anything following
# is consumed rather than rendered.
esc="$(mktemp -d)"; Pesc="$(mktemp -d)"
git -C "$esc" init -q -b develop
git -C "$esc" config user.email t@t.t; git -C "$esc" config user.name t
git -C "$esc" commit -q --allow-empty -m "root"
git -C "$esc" commit -q --allow-empty -m "Drop the inline maps <style>; theme injected at build"
git -C "$esc" commit -q --allow-empty -m "Handle A & B and <script>alert(1)</script>"
git -C "$esc" commit -q --allow-empty -m "It produces 0.0.0-develop.<n> and develop"
notes=$(cd "$esc" && RANGE_FROM= RANGE_TO=HEAD REPO_URL=https://x/y COMMIT_PATH=-/commit \
        bash "$HERE/assemble.sh")
excludes "no raw <style> reaches the page"    "$notes" "<style>"
excludes "no raw <script> reaches the page"   "$notes" "<script>"
excludes "no raw unknown tag reaches the page" "$notes" "<n>"
contains "style is escaped"                   "$notes" "&lt;style&gt;"
contains "ampersand is escaped"               "$notes" "A &amp; B"
contains "the sha link is still live markdown" "$notes" "](https://x/y/-/commit/"
rm -rf "$esc" "$Pesc"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
