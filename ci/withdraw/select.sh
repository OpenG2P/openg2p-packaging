#!/usr/bin/env bash
#
# Decide WHICH versions a withdrawal run may delete. This is the safety gate for the
# whole feature: everything downstream deletes exactly what this prints, so the rules
# live here (once, shared by both forges) rather than in two workflow files.
#
# Rules, in order:
#   1. Only `0.0.0-develop.N` is ever eligible. A release `N.N.N` and a release
#      candidate `N.N.N-rc.M` are REFUSED -- releases are permanent, and RCs are
#      en route to one, so both stay.
#   2. The NEWEST published develop build is never withdrawn: the moving `develop`
#      alias points at that content, so deleting it would break every consumer
#      tracking `:develop`.
#   3. Whatever survives 1-2 must be non-empty, else exit 2 (nothing to do).
#
#   stdin : the published versions, one per line (any order, any kind)
#   env   : MODE=single|range|keep
#           VERSION    (single) the one version to withdraw
#           FROM, TO   (range)  inclusive N bounds, e.g. FROM=100 TO=200
#           KEEP_LAST  (keep)   how many newest develop builds to KEEP
#   stdout: the versions to withdraw, newest first
#
#   printf '%s\n' 0.0.0-develop.{1..30} | MODE=keep KEEP_LAST=10 ./select.sh

set -euo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }
DEV_RE='^0\.0\.0-develop\.[0-9]+$'

MODE="${MODE:-}"
[ -n "$MODE" ] || die "MODE is required (single|range|keep)"

# All published develop builds, newest first. Everything else is dropped here and can
# therefore never be selected, whatever the caller asks for.
published=$(grep -E "$DEV_RE" || true)
[ -n "$published" ] || die "no 0.0.0-develop.N versions are published; nothing to withdraw"
sorted=$(printf '%s\n' "$published" | sort -t. -k4,4rn)
newest=$(printf '%s\n' "$sorted" | head -1)

case "$MODE" in
  single)
    [ -n "${VERSION:-}" ] || die "MODE=single needs VERSION"
    printf '%s' "$VERSION" | grep -qE "$DEV_RE" \
      || die "refusing '$VERSION': only develop builds (0.0.0-develop.N) can be withdrawn.
Releases (N.N.N) are permanent and release candidates (N.N.N-rc.M) are en route to one."
    printf '%s\n' "$sorted" | grep -qx "$VERSION" \
      || die "'$VERSION' is not published (already withdrawn, or never built)"
    selected="$VERSION"
    ;;
  range)
    [ -n "${FROM:-}" ] && [ -n "${TO:-}" ] || die "MODE=range needs FROM and TO"
    # Accept either the bare build number (205) or the full version string
    # (0.0.0-develop.205) -- the catalogue shows the latter, so that is what people
    # naturally paste in.
    bound() {
      case "$1" in
        *[!0-9]*)
          printf '%s' "$1" | grep -qE "$DEV_RE" \
            || die "'$1' is not a build number or a develop version.
Give either the number (e.g. 205) or the full version (e.g. 0.0.0-develop.205)."
          printf '%s' "${1##*.}" ;;
        *) printf '%s' "$1" ;;
      esac
    }
    FROM=$(bound "$FROM"); TO=$(bound "$TO")
    [ "$FROM" -le "$TO" ] || die "FROM ($FROM) is greater than TO ($TO)"
    selected=$(printf '%s\n' "$sorted" | awk -F. -v a="$FROM" -v b="$TO" '$4>=a && $4<=b')
    ;;
  keep)
    [ -n "${KEEP_LAST:-}" ] || die "MODE=keep needs KEEP_LAST"
    case "$KEEP_LAST" in ''|*[!0-9]*) die "KEEP_LAST must be a plain number" ;; esac
    [ "$KEEP_LAST" -ge 1 ] || die "KEEP_LAST must be at least 1"
    selected=$(printf '%s\n' "$sorted" | awk -v k="$KEEP_LAST" 'NR>k')
    ;;
  *) die "unknown MODE '$MODE' (single|range|keep)" ;;
esac

# Rule 2 -- applied AFTER selection so it also catches an explicit single request.
selected=$(printf '%s\n' "$selected" | sed '/^$/d' | grep -vx "$newest" || true)

if [ -z "$selected" ]; then
  echo "nothing to withdraw (the newest build ${newest} is always kept)" >&2
  exit 2
fi
printf '%s\n' "$selected"
