# OpenG2P versioning & publishing

One version per commit, shared by every Docker image and the Helm chart a repo
publishes. The version lives in **git** — branch names, tags, commit count — not
in a file, so nothing in the working tree ever goes stale.

## Policy

| ref | version | frozen | alias | chart |
|---|---|---|---|---|
| `develop` | `0.0.0-develop.<n>` | no | `develop` | published |
| `1.0` (release line) | `1.0.<next>-rc.<n>` | no | – | published |
| tag `1.0.0` (release) | `1.0.0` | **yes** | – | published |
| `g2p-5629` (anything else) | `0.0.0-g2p-5629.<n>` | no | – | not published |

`<n>` is `git rev-list --count HEAD`, the commit's ordinal. It is one-to-one
with the commit, which is why the SHA never needs to appear in the tag — the
commit is recorded in `org.opencontainers.image.revision` instead.

Every version is valid SemVer *and* a valid Docker tag. A bare `N.N.N` is, by
the SemVer spec, a stable release; anything with a `-suffix` sorts strictly
below it. So "N.N.N means frozen" is enforced by tooling, not by convention.

## Three rules that make it real

**A frozen version is published exactly once.** Both the image and the chart
publish steps check for an existing artifact and fail rather than overwrite.
Without this, `0.0.0-develop.48` is just `develop` with extra syllables.

**A release is a retag, not a rebuild.** Tagging `1.0.0` finds the RC that the
release line already built at that commit and does
`docker buildx imagetools create` — same manifest, same digest, new name. You
ship the exact bits you tested. A rebuild would pick up new base-image patches
and new transitive pip resolution, producing an image nobody ever ran.

A corollary: **you can only tag a commit CI already built.** Tagging an
arbitrary commit fails with a clear error, which is the behaviour you want.

**Build inputs are pinned to SHAs.** `pin-git-refs` resolves a branch like
`1.1` to a commit before it becomes a build-arg, and records it as
`org.openg2p.pin.<arg>`. Otherwise two builds of the same commit differ and
"same version, same code" is false.

## Where a version came from

```bash
docker buildx imagetools inspect openg2p/iam-staff-portal-api:0.0.0-develop.48 \
  --format '{{ json .Image.Config.Labels }}'
```

Returns the source repo, the exact commit, and the resolved SHA of every
external ref compiled in. No layers pulled.

## Using it

Callers stay ~10 lines and contain no versioning logic — see
[`samples/caller-stub.yml`](samples/caller-stub.yml) — the canonical template,
with the identical boilerplate (including the `workflow_dispatch` inputs) marked
off from the per-repo declarations. Pin to `@v1`.

Because a reusable workflow's ref resolves independently of the caller's ref, a
two-year-old release branch calling `@v1` picks up today's `v1`. **The `@ref`
you pin to is the rollout control**: change the policy here, move the `v1` tag,
and every repo and every branch follows without a single PR.

Do not pin callers to `@main` — one bad commit would break every repo at once.
Promote deliberately: `v1.4.0`, test, then move `v1`.

## Wrapper charts (Rancher questions)

A **wrapper chart** owns no templates — it just pins another chart as a
dependency and supplies a values overlay (e.g. a product variant branding a
shared platform chart). Rancher reads `questions.yaml` only from the **root** of
the chart being installed and ignores subchart questions, so a wrapper shows an
empty configuration form.

Set `chart-inherit-questions` and the `chart` job regenerates `questions.yaml`
at package time from the pinned dependency, prefixing every non-`global.`
variable with the subchart key:

```yaml
chart-inherit-questions: '{"dependency":"platform-chart","alias":"platform"}'
```

`- variable: api.image.tag` becomes `- variable: platform.api.image.tag`, while
`global.*` (which Helm propagates to subcharts) is left alone. The rewrite is
[`chart/inherit-questions.sh`](chart/inherit-questions.sh); it refuses to write a
form it cannot rewrite faithfully rather than emit a subtly wrong one.

Do **not** commit a `questions.yaml` in a wrapper chart — it is generated, and a
committed copy would rot against the pinned dependency. Leave the input empty for
normal charts; the step is then a no-op.

## Changing the policy

`version/derive-version.sh` is the whole policy. It has tests:

```bash
./ci/version/test-derive-version.sh
```

The tests build a throwaway repo and walk it through a develop → release-line →
release lifecycle. Add a case before you change a rule.

## Known sharp edges

`helm repo index --merge` **appends** rather than replaces, which is how
`openg2p-helm/index.yaml` ended up with two `0.0.0-develop` entries for the same
chart pointing at different digests. The publish step regenerates the index from
scratch instead. Fix the existing duplicates before adopting this.

Docker Hub gates immutable tags behind a paid plan. The workflow's
check-then-fail guard is a good substitute but it is not atomic: two concurrent
runs can both pass the check. Release publishes are rare enough that this is
acceptable; if it ever bites, move charts and images to GHCR, which enforces
immutability server-side.
