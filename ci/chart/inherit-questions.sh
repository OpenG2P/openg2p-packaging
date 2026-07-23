#!/usr/bin/env bash
# Rebuild a wrapper chart's questions.yaml from one of its dependencies.
#
# WHY THIS EXISTS
#   Rancher reads questions.yaml ONLY from the root of the chart being installed;
#   a subchart's questions.yaml is never surfaced. So a "wrapper" chart -- one
#   that owns no templates and just pins another chart as a dependency plus a
#   values overlay -- shows an empty form in Rancher, even though every knob its
#   dependency exposes is still perfectly valid.
#
#   Copying the dependency's questions.yaml into the wrapper by hand duplicates
#   content that then rots against the pinned dependency. Instead this script
#   regenerates it at PACKAGE time, from the exact dependency version that
#   `helm dep up` just resolved -- so it can never drift.
#
# WHAT IT DOES
#   A subchart's values live under its key in the parent (`<alias>.foo.bar`),
#   while `global.*` is shared and propagates untouched. So the only edit needed
#   is to prefix every non-global variable path with the alias:
#
#       - variable: staffApi.image.tag   ->  - variable: registry.staffApi.image.tag
#       - variable: global.postgresqlHost ->  (unchanged)
#       show_if: sanity.runE2e=true       ->  show_if: registry.sanity.runE2e=true
#
#   The rewrite is line-oriented on purpose: it preserves the source file's
#   comments and grouping, which a YAML round-trip (yq) would strip.
#
# USAGE
#   inherit-questions.sh <chart-path> <dependency-name> <alias>
#
#   Run it AFTER `helm dep up` (the dependency .tgz must be in <chart>/charts/)
#   and BEFORE `helm package`.
set -euo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }

CHART_PATH="${1:-}"
DEPENDENCY="${2:-}"
ALIAS="${3:-}"

[ -n "$CHART_PATH" ] || die "usage: inherit-questions.sh <chart-path> <dependency-name> <alias>"
[ -n "$DEPENDENCY" ] || die "usage: inherit-questions.sh <chart-path> <dependency-name> <alias>"
[ -n "$ALIAS" ]      || die "usage: inherit-questions.sh <chart-path> <dependency-name> <alias>"
[ -d "$CHART_PATH" ] || die "chart path '$CHART_PATH' does not exist"

# The alias becomes a values path segment, so keep it to what Helm/Rancher can
# address. A hyphen is legal in YAML but makes the resulting path awkward to
# express, so require a plain identifier.
case "$ALIAS" in
  *[!A-Za-z0-9_]*) die "alias '$ALIAS' must be alphanumeric/underscore (it becomes a values key)";;
esac

# `helm dep up` unpacks nothing -- it leaves the dependency as a .tgz here.
tgz=$(ls "${CHART_PATH}/charts/${DEPENDENCY}"-*.tgz 2>/dev/null | head -1 || true)
[ -n "$tgz" ] || die "no ${DEPENDENCY}-*.tgz in ${CHART_PATH}/charts -- run 'helm dep up ${CHART_PATH}' first"

src=$(tar -xzOf "$tgz" "${DEPENDENCY}/questions.yaml" 2>/dev/null || true)
[ -n "$src" ] || die "dependency '${DEPENDENCY}' ships no questions.yaml (nothing to inherit)"

# Compound conditions would need per-operand rewriting. None of our charts use
# them; refuse loudly rather than emit a silently-wrong condition.
if printf '%s\n' "$src" | grep -qE '^[[:space:]]*(show_if|show_subquestion_if):.*&&'; then
  die "dependency uses a compound show_if (&&), which this rewriter does not handle -- extend ci/chart/inherit-questions.sh"
fi

before=$(printf '%s\n' "$src" | grep -cE '^[[:space:]]*(-[[:space:]]+)?variable:' || true)
[ "$before" -gt 0 ] || die "dependency questions.yaml declares no variables -- refusing to write an empty form"

# Prefix EVERY variable/condition path, then put the `global.` ones back. Doing
# it in that order avoids needing a negative lookahead, which POSIX/RE2 regex
# engines (busybox sed, Go) do not support.
out=$(printf '%s\n' "$src" | sed -E \
  -e "s|^([[:space:]]*(-[[:space:]]+)?variable:[[:space:]]*)([^[:space:]#]+)|\1${ALIAS}.\3|" \
  -e "s|^([[:space:]]*show_if:[[:space:]]*)|\1${ALIAS}.|" \
  -e "s|^([[:space:]]*show_subquestion_if:[[:space:]]*)|\1${ALIAS}.|" \
  | sed -E "s/${ALIAS}\.global\./global./g")

printf '%s\n' "$out" > "${CHART_PATH}/questions.yaml"

globals=$(printf '%s\n' "$out" | grep -cE '^[[:space:]]*(-[[:space:]]+)?variable:[[:space:]]*global\.' || true)
scoped=$(printf '%s\n' "$out" | grep -cE "^[[:space:]]*(-[[:space:]]+)?variable:[[:space:]]*${ALIAS}\." || true)
after=$((globals + scoped))

# Every variable must have landed in exactly one bucket; anything else means the
# rewrite missed a line shape and the form would be subtly wrong.
[ "$after" -eq "$before" ] || die "rewrote $after of $before variables -- unexpected line shape in the dependency questions.yaml"

echo "  ok  questions.yaml inherited from ${DEPENDENCY} ($(basename "$tgz"))"
echo "      ${before} variables: ${globals} global.* kept, ${scoped} prefixed with '${ALIAS}.'"
