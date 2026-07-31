#!/usr/bin/env bash
#
# List the images to delete alongside a withdrawn chart version, by reading the
# PUBLISHED chart itself. A version spans every image in the repo, and rather than
# duplicating that list into a second config (which would drift), we recover it from
# the artifact being withdrawn: the chart's values.yaml already carries the
# repository + tag the CI stamped in.
#
# Only images whose tag EQUALS the version being withdrawn are printed, so a
# third-party dependency pinned to its own version (postgres, redis, …) can never be
# selected -- that filter is the safety property here.
#
#   env : CHART_TGZ  path to the packaged chart (.tgz)
#         VERSION    the version being withdrawn; only tags equal to it are listed
#   out : one image repository per line, WITHOUT the tag, e.g.
#           openg2p/openg2p-pbms-staff-portal-api
#           registry.gitlab.com/openg2p/consent-manager/consent-manager-api
#
#   CHART_TGZ=x.tgz VERSION=0.0.0-develop.297 ./chart-images.sh

set -euo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }
[ -n "${CHART_TGZ:-}" ] || die "CHART_TGZ is required"
[ -f "$CHART_TGZ" ]     || die "no such chart archive: $CHART_TGZ"
[ -n "${VERSION:-}" ]   || die "VERSION is required"
command -v yq >/dev/null || die "yq (mikefarah) is required"

work=$(mktemp -d); trap 'rm -rf "$work"' EXIT
tar -xzf "$CHART_TGZ" -C "$work" || die "could not unpack $CHART_TGZ"

# The chart's own values.yaml (depth 2: <chart>/values.yaml). Subchart values are
# skipped on purpose -- a dependency's images are not ours to delete.
values=$(find "$work" -mindepth 2 -maxdepth 2 -name values.yaml | head -1)
[ -n "$values" ] || { echo "no values.yaml in $CHART_TGZ" >&2; exit 0; }

# Every mapping carrying BOTH repository and tag, where tag is exactly VERSION.
# `registry` is optional: some charts render `repository:tag` and hold the full path
# in repository, others split it into registry + repository. Separated by '|' (which
# cannot appear in an image path) -- NOT "\t": yq emits that escape literally.
VERSION="$VERSION" yq -r '
  .. | select(type == "!!map" and has("repository") and has("tag"))
     | select(.tag == strenv(VERSION))
     | ((.registry // "") + "|" + .repository)' "$values" 2>/dev/null \
  | while IFS='|' read -r registry repository; do
      [ -n "${repository:-}" ] || continue
      case "$registry" in null) registry="" ;; esac
      if [ -n "$registry" ]; then
        printf '%s/%s\n' "${registry%/}" "${repository#/}"
      else
        printf '%s\n' "$repository"
      fi
    done | sort -u
