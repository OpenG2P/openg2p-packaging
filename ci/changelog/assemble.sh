#!/usr/bin/env bash
#
# Assemble the change notes for a git range from COMMIT MESSAGES — the check-in
# comments developers already write. No separate note files: the commit subject
# is the note. Prints a markdown bullet list; prints nothing (exit 0) if the
# range has no commits.
#
# Range: commits in (RANGE_FROM .. RANGE_TO]. RANGE_FROM empty (or unknown)
# means from the start of history — used for the first release. Merge commits
# are excluded (they carry no authored message of their own).
#
#   RANGE_FROM=1.0.0 RANGE_TO=HEAD ./assemble.sh

set -euo pipefail

FROM="${RANGE_FROM:-}"
TO="${RANGE_TO:-HEAD}"

if [ -n "$FROM" ] && git rev-parse --verify -q "$FROM" >/dev/null 2>&1; then
  range="${FROM}..${TO}"
else
  range="$TO"
fi

# One bullet per commit, newest first: subject + short sha for traceability.
# tformat: emits a trailing newline per entry (and nothing at all when empty).
git log "$range" --no-merges --no-color --pretty=tformat:'- %s (`%h`)' 2>/dev/null || true
