#!/usr/bin/env bash
#
# Assemble human change notes for a git range into grouped, Keep-a-Changelog
# markdown. Prints nothing (and exits 0) if the range contains no new notes.
#
# A note is a file under $CHANGES_DIR (default: changes/):
#
#     type: changed
#     Consent receipts are signed JWTs instead of opaque IDs (G2P-5678)
#
# The first line may be `type: <added|changed|deprecated|removed|fixed|security>`
# (default: changed). The rest is the human sentence(s). README.md is ignored.
#
# Range: notes ADDED or MODIFIED in (RANGE_FROM .. RANGE_TO]. RANGE_FROM empty
# means "from the start of history" (first release). Nothing is ever deleted
# from the source repo, so the range — not a mutable directory — defines what
# belongs to a version.
#
# Portable to bash 3.2 (macOS): no associative arrays, no mapfile.
#
#   CHANGES_DIR=changes RANGE_FROM=1.0.0 RANGE_TO=HEAD ./assemble.sh

set -euo pipefail

CHANGES_DIR="${CHANGES_DIR:-changes}"
FROM="${RANGE_FROM:-}"
TO="${RANGE_TO:-HEAD}"

ORDER="added changed deprecated removed fixed security"

label_for() {
  case "$1" in
    added) echo "Added" ;; changed) echo "Changed" ;;
    deprecated) echo "Deprecated" ;; removed) echo "Removed" ;;
    fixed) echo "Fixed" ;; security) echo "Security" ;;
    *) echo "" ;;
  esac
}

# Fragment files in range. Added/modified only (diff-filter=AM drops deletions).
if [ -n "$FROM" ] && git rev-parse --verify -q "$FROM" >/dev/null 2>&1; then
  files=$(git log "${FROM}..${TO}" --diff-filter=AM --name-only --pretty=format: \
            -- "$CHANGES_DIR" 2>/dev/null | sort -u | grep -E '\.md$' || true)
else
  # No lower bound (or it is unknown): every fragment present at TO.
  files=$(git ls-tree -r --name-only "$TO" -- "$CHANGES_DIR" 2>/dev/null \
            | grep -E '\.md$' || true)
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
have=0

while IFS= read -r f; do
  [ -n "$f" ] || continue
  case "$(basename "$f" | tr '[:upper:]' '[:lower:]')" in readme.md) continue ;; esac
  # Read the file's content AT the range end (skip if deleted by TO).
  content=$(git show "${TO}:${f}" 2>/dev/null) || continue

  first=$(printf '%s\n' "$content" | sed -n '1p')
  type=""
  case "$first" in
    type:*|Type:*)
      type=$(printf '%s' "$first" | sed 's/^[Tt]ype:[[:space:]]*//' \
               | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
      body=$(printf '%s\n' "$content" | sed '1d')
      ;;
    *) body="$content" ;;
  esac
  [ -n "$(label_for "$type")" ] || type="changed"

  # Collapse the note to a single bullet line; drop blank lines.
  body=$(printf '%s\n' "$body" | sed '/^[[:space:]]*$/d' | tr '\n' ' ' \
           | sed 's/[[:space:]]\{1,\}/ /g; s/^ //; s/ $//')
  [ -n "$body" ] || continue

  printf -- '- %s\n' "$body" >> "$tmp/$type"
  have=1
done <<EOF
$files
EOF

[ "$have" = 1 ] || exit 0

for k in $ORDER; do
  if [ -f "$tmp/$k" ]; then
    printf '**%s**\n' "$(label_for "$k")"
    cat "$tmp/$k"
    printf '\n'
  fi
done
