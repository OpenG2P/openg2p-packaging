#!/usr/bin/env bash
#
# Derive the artifact version for the current git ref.
#
# One version per commit, shared by every Docker image and the Helm chart that
# the repo publishes. Nothing is read from the working tree: the version lives
# in git (branch names, tags, commit count), not in a file.
#
#   ref                        version              frozen  alias    chart
#   ------------------------------------------------------------------------
#   develop                    0.0.0-develop.<n>    no      develop  yes
#   N.N      (release line)    N.N.<next>-rc.<n>    no      -        yes
#   tag N.N.N (release)        N.N.N                yes     -        yes
#   anything else (feature)    0.0.0-<slug>.<n>     no      -        no
#
# <n> is `git rev-list --count HEAD` -- the commit's ordinal, so <n> and the
# commit are one-to-one and the SHA never needs to appear in the tag.
#
# A frozen version is never built. It is promoted by retagging the digest that
# the release line already published; `promote_from` lists the candidate source
# tags in priority order.
#
# Requires a full clone with tags: actions/checkout with fetch-depth: 0.
#
# Usage:
#   REF_NAME=develop REF_TYPE=branch ./derive-version.sh
#
# Emits KEY=VALUE lines on stdout, and appends them to $GITHUB_OUTPUT when set.

set -euo pipefail

DEVELOP_BRANCH="${DEVELOP_BRANCH:-develop}"

die() {
  echo "::error::$*" >&2
  exit 1
}

emit() {
  printf '%s=%s\n' "$1" "$2"
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"
  fi
}

# https://semver.org -- the official recommended regex.
is_semver() {
  [[ "$1" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]
}

# A Docker tag is [a-zA-Z0-9_][a-zA-Z0-9._-]{0,127}. Note '+' is legal in SemVer
# build metadata but illegal here, which is why we never emit build metadata.
is_docker_tag() {
  [[ "$1" =~ ^[a-zA-Z0-9_][a-zA-Z0-9._-]{0,127}$ ]]
}

# Reduce an arbitrary ref name to something usable as a SemVer pre-release
# identifier and a Docker tag: feature/G2P-5629 -> g2p-5629
slugify() {
  printf '%s' "$1" |
    tr '[:upper:]' '[:lower:]' |
    sed -E 's/[^a-z0-9-]+/-/g; s/-+/-/g; s/^-+//; s/-+$//'
}

# Highest existing release on line $1 (e.g. "1.0"), reachable from HEAD.
# $2, when "exclude-head", drops tags that point at HEAD -- used on a release
# tag build so we can reconstruct the version the commit had *before* it was
# tagged, which is the RC we promote from.
last_release_on_line() {
  local line="$1" mode="${2:-}" args=(--list "${1}.*" --merged HEAD --sort=-v:refname)
  [ "$mode" = "exclude-head" ] && args+=(--no-contains HEAD)
  git tag "${args[@]}" | grep -Ex "${line//./\\.}\.[0-9]+" | head -1 || true
}

next_patch_on_line() {
  local last="$1"
  if [ -n "$last" ]; then
    echo $((${last##*.} + 1))
  else
    echo 0
  fi
}

# --- inputs ------------------------------------------------------------------

ref_name="${REF_NAME:-${GITHUB_REF_NAME:-}}"
ref_type="${REF_TYPE:-${GITHUB_REF_TYPE:-branch}}"
[ -n "$ref_name" ] || die "REF_NAME is required"

git rev-parse --git-dir >/dev/null 2>&1 || die "not a git repository"

count="$(git rev-list --count HEAD)"
revision="$(git rev-parse HEAD)"

version=""
channel=""
frozen="false"
alias=""
publish_chart="true"
promote_from=""

# --- policy ------------------------------------------------------------------

if [ "$ref_type" = "tag" ]; then

  [[ "$ref_name" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] ||
    die "tag '$ref_name' is not N.N.N -- releases are bare-SemVer tags, e.g. 1.0.0"

  version="$ref_name"
  channel="release"
  frozen="true"

  line="${ref_name%.*}"
  patch="$(next_patch_on_line "$(last_release_on_line "$line" exclude-head)")"

  [ "$patch" = "${ref_name##*.}" ] ||
    die "tag '$ref_name' skips a patch: the next release on line $line is ${line}.${patch}"

  # The release line published this commit as an RC. A commit tagged straight
  # off develop never did, so fall back to the develop build of the same commit.
  promote_from="${line}.${patch}-rc.${count} 0.0.0-${DEVELOP_BRANCH}.${count}"

elif [ "$ref_name" = "$DEVELOP_BRANCH" ]; then

  version="0.0.0-${DEVELOP_BRANCH}.${count}"
  channel="develop"
  alias="$DEVELOP_BRANCH"

elif [[ "$ref_name" =~ ^[0-9]+\.[0-9]+$ ]]; then

  patch="$(next_patch_on_line "$(last_release_on_line "$ref_name")")"
  version="${ref_name}.${patch}-rc.${count}"
  channel="rc"

elif [[ "$ref_name" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then

  die "branch '$ref_name' names a frozen version.
A branch is mutable, so publishing N.N.N from one lets a second push overwrite a
released artifact. Use branch '${ref_name%.*}' as the release line -- it publishes
${ref_name}-rc.<n> -- then tag the blessed commit '$ref_name' to release it."

else

  slug="$(slugify "$ref_name")"
  [ -n "$slug" ] || die "ref '$ref_name' slugifies to the empty string"
  # A purely numeric pre-release identifier must not have a leading zero.
  [[ "$slug" =~ ^0[0-9]+$ ]] && slug="b${slug}"

  version="0.0.0-${slug}.${count}"
  channel="feature"
  publish_chart="false"

fi

# --- validate ----------------------------------------------------------------

is_semver "$version" || die "derived version '$version' is not valid SemVer"
is_docker_tag "$version" || die "derived version '$version' is not a valid Docker tag"

# --- outputs -----------------------------------------------------------------

emit version "$version"
emit channel "$channel"
emit frozen "$frozen"
emit alias "$alias"
emit publish_chart "$publish_chart"
emit promote_from "$promote_from"
emit revision "$revision"
emit count "$count"
