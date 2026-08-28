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
# RANGE_LIMIT caps the number of commits (newest-first) — used by a library's
# rolling branch page to list just the last few commits.
#
#   RANGE_FROM=1.0.0 RANGE_TO=HEAD ./assemble.sh
#   RANGE_LIMIT=5 ./assemble.sh            # last 5 commits on HEAD

set -euo pipefail

FROM="${RANGE_FROM:-}"
TO="${RANGE_TO:-HEAD}"
LIMIT="${RANGE_LIMIT:-}"

if [ -n "$FROM" ] && git rev-parse --verify -q "$FROM" >/dev/null 2>&1; then
  range="${FROM}..${TO}"
else
  range="$TO"
fi

# One bullet per commit, newest first: subject + short sha. When REPO_URL is set
# the sha links to the commit on the forge so it's clickable in the changelog.
# COMMIT_PATH is the forge's commit path segment: `commit` for GitHub (default),
# `-/commit` for GitLab. tformat: one trailing newline per entry, nothing when empty.
base="${REPO_URL:-}"

# A commit subject is UNTRUSTED TEXT on its way into HTML, and markdown passes raw
# HTML straight through. A subject that mentions a tag therefore emits a real
# element — and for `<style>`, `<script>`, `<textarea>` or `<title>` the HTML
# parser then treats everything after it as that element's raw text.
#
# Not hypothetical. A commit reading "Drop the inline maps <style>; the platform
# injects the shared theme" opened a real <style> on the published page and
# swallowed 29,686 characters: the five changelog entries below it vanished in a
# browser while curl still returned a complete document, because curl does not
# parse. The page looked truncated and the build looked broken; neither was.
#
# So the subject is escaped, and ONLY the subject — the sha link is built here and
# has to stay live markdown. Ampersand first, or the escapes escape themselves.
# Emitted through a delimiter because git's --pretty cannot escape a field.
SEP=$'\x1f'   # unit separator: cannot appear in a commit subject
git log "$range" ${LIMIT:+-n $LIMIT} --no-merges --no-color \
    --pretty=tformat:"%s${SEP}%h${SEP}%H" 2>/dev/null \
  | awk -v FS="$SEP" -v base="$base" -v path="${COMMIT_PATH:-commit}" '
      NF >= 3 {
        s = $1
        gsub(/&/, "\\&amp;", s)
        gsub(/</, "\\&lt;",  s)
        gsub(/>/, "\\&gt;",  s)
        if (base != "")
          printf "- %s ([`%s`](%s/%s/%s))\n", s, $2, base, path, $3
        else
          printf "- %s (`%s`)\n", s, $2
      }' || true
