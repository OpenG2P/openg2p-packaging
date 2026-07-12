# Changelog

Human change notes, captured at PR time, rolled up per version, published as
**markdown** to the packaging `gh-pages` branch. Gitbook points at the rendered
page; nothing is ever committed back to a source repo's build branch (which
would bump the commit-count version and loop).

## Flow

```
changes/*.md   →   assemble (git range)   →   summarize (OpenRouter, best-effort)   →   render
(one per PR,        notes since the last        2-5 user-facing bullets                  gh-pages:
 human sentence)    frozen release              (skippable / regenerable)                <repo>/CHANGELOG.md
```

All of it runs inside `build-publish.yml`'s `changelog` job, keyed to the same
version the images and chart get.

## Where it lands

```
gh-pages (openg2p-packaging)
  <repo>/
    CHANGELOG.md            ← Gitbook target; Unreleased first, releases newest-first
    versions/
      1.0.1.md              ← one page per frozen release
      unreleased.md         ← rolling; regenerated wholesale, never grows
```

URL: `https://openg2p.github.io/openg2p-packaging/<repo>/CHANGELOG.md`

## When it runs

| channel | changelog |
|---|---|
| `develop` | updates the rolling **Unreleased** section |
| release tag `N.N.N` | writes a frozen **version page**, clears Unreleased |
| RC (`N.N`), feature | skipped (the release tag captures the whole range) |

A version with no new notes in its range publishes nothing.

## AI is never load-bearing

`summarize.sh` is best-effort. If OpenRouter (or the key) is unavailable, the
job logs `::warning::` with the reason, and the changelog **still publishes**
with the human notes; the Summary section says it's pending. Two knobs:

- `changelog_skip_ai: true` — human notes only, clean success, no API call.
- `changelog_regenerate: <version>` — re-summarise an already-published page,
  reading its human notes back and rewriting **only** the Summary. Human notes
  are immutable after release.

## Config & secret

- Model + fallbacks + `max_tokens`: `ci/changelog/config.yml` (non-secret).
- `OPENROUTER_API_KEY`: an org-level Actions secret. **Never** commit it — these
  repos and gh-pages are public. If it's unset, the job behaves as `skip_ai`.

## Tests

```bash
./ci/changelog/test-changelog.sh   # range + assembly + render, no network
```
