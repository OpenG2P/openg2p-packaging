#!/usr/bin/env bash
#
# Record withdrawn versions in the catalogue, as `<repo>/.withdrawn` next to the
# `.meta` written by the changelog run. One line per version:
#
#     0.0.0-develop.297|2026-07-26|bad migration, do not deploy
#
# The file is the single source of truth for two things:
#   * render-aggregate.sh renders the "Withdrawn" section from it, and flags the
#     version in the summary table -- the changelog PAGE is deliberately kept so the
#     "changes since <previous build>" thread never dangles;
#   * the build pipeline refuses to publish a version listed here. That matters
#     because `0.0.0-develop.N` is derived from the commit COUNT: after a force-push
#     a different commit can land on a withdrawn N, and with the artifact already
#     deleted nothing else would notice -- anyone still pinning that version would
#     silently get different bytes instead of a clean "not found".
#
#   env : PAGES_DIR  checkout of the changelog branch/repo
#         REPO       the repo's folder in the catalogue
#         DATE       YYYY-MM-DD (passed in, for reproducibility)
#         REASON     why it was withdrawn (rendered verbatim; required)
#   in  : the withdrawn versions on stdin, one per line
#
#   printf '%s\n' 0.0.0-develop.297 | PAGES_DIR=… REPO=pbms DATE=… REASON="…" ./tombstone.sh

set -euo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }
[ -n "${PAGES_DIR:-}" ] || die "PAGES_DIR is required"
[ -n "${REPO:-}" ]      || die "REPO is required"
[ -n "${REASON:-}" ]    || die "REASON is required (it is rendered in the catalogue)"
DATE="${DATE:-$(date -u +%Y-%m-%d)}"

# Keep the record on ONE line per version: the renderer splits on '|'.
reason=$(printf '%s' "$REASON" | tr '\n|' '  ' | sed 's/  */ /g; s/^ //; s/ $//')
[ -n "$reason" ] || die "REASON is empty after trimming"

file="${PAGES_DIR}/${REPO}/.withdrawn"
mkdir -p "${PAGES_DIR}/${REPO}"
touch "$file"

added=0
while IFS= read -r v; do
  [ -n "$v" ] || continue
  # Idempotent: a version already recorded keeps its original date and reason, so
  # re-running a partially-completed withdrawal never rewrites history.
  if grep -q "^${v}|" "$file" 2>/dev/null; then
    echo "  already recorded: $v"
    continue
  fi
  printf '%s|%s|%s\n' "$v" "$DATE" "$reason" >> "$file"
  echo "  recorded: $v"
  added=$((added + 1))
done

# Newest first, so the rendered section reads like the rest of the catalogue.
sort -t. -k4,4rn -o "$file" "$file" 2>/dev/null || true
echo "wrote ${file} (${added} new)"
