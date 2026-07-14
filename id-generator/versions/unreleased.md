## id-generator — Unreleased (0.0.0-develop.41, 2026-07-14)

_commit `e5a012a` · baseline: release v1.0.0_
<!-- build:0.0.0-develop.41 revision:e5a012acc38a1eb2e4c3f672426564826f3dadd4 -->

### Summary

_All changes since release v1.0.0:_

- Major: Implemented a new Continuous Integration (CI) system, replacing the previous setup.
- Removed the old CI workflow files: `.github/workflows/docker-build.yml` and `.github/workflows/publish-helm.yml`.
- Added a new CI workflow file: `.github/workflows/build-publish.yml`.
- Overall, 52 lines of code were added while 224 lines were removed across the CI configuration files.

### Since last release (v1.0.0)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented. ([`e5a012a`](https://github.com/OpenG2P/id-generator/commit/e5a012acc38a1eb2e4c3f672426564826f3dadd4))
