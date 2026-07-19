#!/usr/bin/env bash
#
# Summarise assembled change notes into a few user-facing bullets via OpenRouter.
# Reads the notes on stdin, prints the summary on stdout.
#
# Best-effort by contract: on ANY failure it exits non-zero with the reason on
# stderr, and the caller turns that into a warning + placeholder. It never
# blocks the human changelog.
#
#   env: OPENROUTER_API_KEY (required), OPENROUTER_MODEL, OPENROUTER_FALLBACKS
#        (comma-separated), MAX_TOKENS
#   cat notes.md | ./summarize.sh > summary.md

set -euo pipefail

[ -n "${OPENROUTER_API_KEY:-}" ] || { echo "OPENROUTER_API_KEY is not set" >&2; exit 3; }

notes=$(cat)
[ -n "$notes" ] || { echo "no notes to summarise" >&2; exit 2; }

model="${OPENROUTER_MODEL:-openai/gpt-4o-mini}"

# models = [model, ...fallbacks] — OpenRouter routes down the list IN ORDER on
# failure, so dedup must preserve order (unique_by/sort would not).
models_arr=$(
  { printf '%s\n' "$model"
    printf '%s' "${OPENROUTER_FALLBACKS:-}" | tr ',' '\n'
  } | sed '/^[[:space:]]*$/d' | jq -R . \
    | jq -s 'reduce .[] as $m ([]; if index($m) then . else . + [$m] end)'
)

# Optional structural digest (from digest.sh) grounds the summary in what
# actually changed, so it can surface changes the commit notes omit.
digest=""
if [ -n "${DIGEST_FILE:-}" ] && [ -s "$DIGEST_FILE" ]; then
  digest=$(cat "$DIGEST_FILE")
fi

# A SUMMARY, not a reproduction: the full per-commit list is rendered separately
# right below this summary, so the model must SYNTHESISE (group by theme) rather
# than emit one bullet per commit. The two failure modes we guard against: (a) a
# large range enumerating into a 30-item list that reads like the raw log, and
# (b) flattening into vague filler that hides the one change that matters.
rules=$(cat <<'RULES'
You are writing a concise CHANGELOG SUMMARY. The full per-commit list is shown separately BELOW your summary, so do NOT reproduce it — SYNTHESISE, do not enumerate.

Rules:
- Synthesise into a SHORT set of themed bullets (typically 4-10, even for a large range). Group related changes by area — e.g. security, testing, CI/build, a named feature, dependencies, migrations. NEVER emit one bullet per commit or per ticket.
- Make each bullet dense: state the theme and name the concrete significant items inside it, e.g. "Security hardening: fail-closed partner-signature and consent enforcement by default, CSRF validation, non-root containers".
- Order most significant first. Do NOT hide a genuinely significant change — breaking changes, security/auth/crypto, switching a core component or library, new or removed features, data migrations must be visible, but may sit inside a themed bullet.
- Accentuate ONLY when the notes make it unambiguous: if a change is clearly major or breaking (a note literally says "major", "breaking" or "removed", or names a component swap or a data migration), prefix that one bullet with "**Major:** ". If you are not sure it is major, add NO label — never guess, never inflate.
- Be concrete. Name the actual component, technology or behaviour. Do NOT use vague filler like "improved stability", "enhanced integration" or "updated defaults".
- Plain language, no headings, no preamble. Start each line with "- ".
RULES
)

if [ -n "$digest" ]; then
  prompt=$(printf '%s\n\nUse the developer commit notes as the primary source of INTENT, and the change digest to ground and complete them (surface meaningful changes the digest implies even if the notes omit them).\n\n=== Developer commit notes (intent) ===\n%s\n\n=== Change digest from git (what actually changed) ===\n%s' \
    "$rules" "$notes" "$digest")
else
  prompt=$(printf '%s\n\n=== Developer commit notes ===\n%s' "$rules" "$notes")
fi

body=$(jq -n \
  --argjson models "$models_arr" \
  --arg content "$prompt" \
  --argjson max "${MAX_TOKENS:-400}" \
  '{models: $models, max_tokens: $max, temperature: 0.2,
    messages: [{role: "user", content: $content}]}')

resp=$(curl -sS --max-time 60 --retry 2 --retry-delay 3 \
  -H "Authorization: Bearer ${OPENROUTER_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "HTTP-Referer: https://github.com/openg2p" \
  -H "X-Title: OpenG2P changelog" \
  -X POST https://openrouter.ai/api/v1/chat/completions \
  -d "$body") || { echo "request to OpenRouter failed (network/timeout)" >&2; exit 4; }

err=$(printf '%s' "$resp" | jq -r '.error.message // empty' 2>/dev/null || true)
[ -z "$err" ] || { echo "OpenRouter error: $err" >&2; exit 5; }

content=$(printf '%s' "$resp" | jq -r '.choices[0].message.content // empty' 2>/dev/null || true)
[ -n "$content" ] || { echo "OpenRouter returned an empty completion" >&2; exit 6; }

printf '%s\n' "$content"
