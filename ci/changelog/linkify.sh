#!/usr/bin/env bash
#
# Turn Jira ticket references in changelog text into markdown links.
# Reads stdin, writes linkified stdout. Idempotent: an already-linked ref is
# left unchanged, so it is safe to run on regenerated pages.
#
#   env: JIRA_BASE  (default https://openg2p.atlassian.net/browse)
#        JIRA_PROJECT (default G2P) — the ticket key prefix
#
#   echo "G2P-5335 fix" | ./linkify.sh  ->  [G2P-5335](.../G2P-5335) fix

set -euo pipefail

base="${JIRA_BASE:-https://openg2p.atlassian.net/browse}"
proj="${JIRA_PROJECT:-G2P}"

# Empty project prefix disables linking.
if [ -z "$proj" ]; then cat; exit 0; fi

# 1) strip any existing link for this project key back to the bare ref
# 2) link every bare ref (sed does not rescan replacement text, so no double-link)
sed -E "s/\[(${proj}-[0-9]+)\]\([^)]*\)/\1/g" \
  | sed -E "s#(${proj}-[0-9]+)#[\1](${base}/\1)#g"
