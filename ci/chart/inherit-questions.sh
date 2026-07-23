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
#   1. PATH PREFIX. A subchart's values live under its key in the parent
#      (`<alias>.foo.bar`), while `global.*` is shared and propagates untouched:
#
#        - variable: staffApi.image.tag    ->  - variable: registry.staffApi.image.tag
#        - variable: global.postgresqlHost ->  (unchanged)
#        show_if: sanity.runE2e=true       ->  show_if: registry.sanity.runE2e=true
#
#   2. DEFAULT BACKFILL. Rancher pre-populates a field from the ROOT chart's
#      values.yaml, falling back to the question's own `default:`. A wrapper's
#      root values.yaml holds only its overlay -- everything else lives in the
#      dependency's values.yaml, inside charts/*.tgz, which Rancher does not
#      read. Without this pass every inherited knob renders blank, and a boolean
#      rendered blank submits as FALSE -- silently disabling db-seed, AWE, audit
#      and friends on install. So each question's effective default is resolved
#      and written into the generated file, taking the WRAPPER's own values.yaml
#      first and the dependency's only as a fallback. That order matters: the
#      overlay is what makes the wrapper a distinct product, so offering the
#      dependency's image repositories as defaults would let a Rancher install
#      silently deploy the platform's images instead of the variant's.
#
#   The questions rewrite is line-oriented on purpose: it preserves the source
#   file's comments and grouping, which a YAML round-trip would strip. Only the
#   dependency's values.yaml is parsed as YAML (to resolve defaults).
#
# USAGE
#   inherit-questions.sh <chart-path> <dependency-name> <alias>
#
#   Run it AFTER `helm dep up` (the dependency .tgz must be in <chart>/charts/)
#   and BEFORE `helm package`. Requires python3 with PyYAML.
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

command -v python3 >/dev/null || die "python3 is required (with PyYAML)"

# `helm dep up` unpacks nothing -- it leaves the dependency as a .tgz here.
tgz=$(ls "${CHART_PATH}/charts/${DEPENDENCY}"-*.tgz 2>/dev/null | head -1 || true)
[ -n "$tgz" ] || die "no ${DEPENDENCY}-*.tgz in ${CHART_PATH}/charts -- run 'helm dep up ${CHART_PATH}' first"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

tar -xzOf "$tgz" "${DEPENDENCY}/questions.yaml" > "$work/questions.yaml" 2>/dev/null || true
[ -s "$work/questions.yaml" ] || die "dependency '${DEPENDENCY}' ships no questions.yaml (nothing to inherit)"

tar -xzOf "$tgz" "${DEPENDENCY}/values.yaml" > "$work/values.yaml" 2>/dev/null || true
[ -s "$work/values.yaml" ] || die "dependency '${DEPENDENCY}' ships no values.yaml -- cannot resolve question defaults"

[ -s "${CHART_PATH}/values.yaml" ] || die "wrapper chart has no values.yaml at ${CHART_PATH}/values.yaml"

ALIAS="$ALIAS" SRC="$work/questions.yaml" VALUES="$work/values.yaml" \
OWN_VALUES="${CHART_PATH}/values.yaml" \
OUT="${CHART_PATH}/questions.yaml" python3 - <<'PY'
import json, os, re, sys

try:
    import yaml
except ImportError:
    sys.exit("ERROR: PyYAML is required (pip install pyyaml / apk add py3-yaml)")

alias  = os.environ["ALIAS"]
src    = open(os.environ["SRC"]).read().splitlines()
values = yaml.safe_load(open(os.environ["VALUES"])) or {}
own    = yaml.safe_load(open(os.environ["OWN_VALUES"])) or {}
out_path = os.environ["OUT"]

VAR_RE  = re.compile(r'^(\s*(?:-\s+)?variable:\s*)(\S+)(.*)$')
COND_RE = re.compile(r'^(\s*show_(?:subquestion_)?if:\s*)(\S.*?)\s*$')
DEF_RE  = re.compile(r'^(\s*)default:\s')


def die(msg):
    sys.exit("ERROR: " + msg)


def dig(tree, path):
    """Resolve a dotted path in a values tree. Returns (value, found)."""
    cur = tree
    for key in path.split('.'):
        if not isinstance(cur, dict) or key not in cur:
            return None, False
        cur = cur[key]
    return cur, True


def lookup(path, scoped):
    """The value Helm would actually use for this question.

    The WRAPPER's own values.yaml wins -- it is the overlay that makes this
    chart a distinct product (its images, its toggles). Falling back to the
    dependency's default here would be actively dangerous: it would offer the
    platform's image repository as the default for a variant chart, and a
    Rancher install that accepted it would silently deploy the wrong images.
    Only when the wrapper says nothing do we inherit the dependency's default.
    """
    value, found = dig(own, scoped)
    if found:
        return value, True, "overlay"
    value, found = dig(values, path)
    return value, found, "dependency"


def render(value):
    """Format a scalar as a YAML default. Non-scalars have no sane form."""
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return repr(value)
    if isinstance(value, str):
        # json.dumps produces a double-quoted scalar with correct escaping,
        # which is also valid YAML -- and keeps `{{ .Release.Namespace }}`
        # templates intact and unambiguous.
        return json.dumps(value)
    return None


def prefix(path):
    return path if path.startswith("global.") else alias + "." + path


# Compound conditions would need per-operand rewriting. None of our charts use
# them; refuse loudly rather than emit a silently-wrong condition.
for line in src:
    m = COND_RE.match(line)
    if m and "&&" in m.group(2):
        die("dependency uses a compound show_if (&&), which this rewriter does "
            "not handle -- extend ci/chart/inherit-questions.sh")

result = []
n_vars = n_global = n_scoped = n_defaults = n_overlay = 0
# Set while inside a question block whose default we have already emitted, so an
# existing `default:` further down the block is dropped rather than duplicated.
suppress_default = False

for line in src:
    m = VAR_RE.match(line)
    if m:
        head, path, tail = m.groups()
        n_vars += 1
        new = prefix(path)
        if new.startswith("global."):
            n_global += 1
        else:
            n_scoped += 1
        result.append(head + new + tail)

        # Emit the dependency's effective value as this question's default. The
        # key indent matches the block's other keys: the column `variable:`
        # starts at (i.e. just past any "- " list marker).
        suppress_default = False
        value, found, origin = lookup(path, new)
        if found:
            rendered = render(value)
            if rendered is not None:
                indent = " " * (len(head) - len(head.lstrip()) + (2 if "-" in head else 0))
                result.append(indent + "default: " + rendered)
                n_defaults += 1
                if origin == "overlay":
                    n_overlay += 1
                suppress_default = True
        continue

    if suppress_default and DEF_RE.match(line):
        continue          # replaced by the values-derived default above

    m = COND_RE.match(line)
    if m:
        head, cond = m.groups()
        path, sep, rest = cond.partition("=")
        result.append(head + prefix(path) + sep + rest)
        continue

    result.append(line)

if n_vars == 0:
    die("dependency questions.yaml declares no variables -- refusing to write an empty form")
if n_global + n_scoped != n_vars:
    die("rewrote %d of %d variables -- unexpected line shape" % (n_global + n_scoped, n_vars))

with open(out_path, "w") as fh:
    fh.write("\n".join(result) + "\n")

print("  ok  questions.yaml inherited from %s" % os.path.basename(os.environ["SRC"]))
print("      %d variables: %d global.* kept, %d prefixed with '%s.'"
      % (n_vars, n_global, n_scoped, alias))
print("      %d defaults backfilled (%d from this chart's own overlay, %d from "
      "the dependency; %d kept their own)"
      % (n_defaults, n_overlay, n_defaults - n_overlay, n_vars - n_defaults))
PY

echo "      source: $(basename "$tgz")"
