# pbms

_Published automatically._

**Repository:** [github.com/OpenG2P/pbms](https://github.com/OpenG2P/pbms)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.7`](#v-0-0-0-develop-7) | 2026-07-20 | develop |

# Develop builds

<a id="v-0-0-0-develop-7"></a>

## pbms — develop 0.0.0-develop.7 (2026-07-20)

_commit `0e54e65` · baseline: release the start_
<!-- build:0.0.0-develop.7 revision:0e54e65238d79f8d1fbd7bf0bd8c43b381874188 ts:1784511063 -->

### Summary

_All changes since release the start:_

- **Major:** Transition to a central build-publish CI system, consolidating multiple Docker images and Helm charts while removing legacy workflows.
- Dependency updates: versions of various components and the Postgres-init chart have been updated to ensure compatibility and performance.
- Codebase consolidation efforts are ongoing, aimed at streamlining the project structure and improving maintainability.
- Documentation enhancement: a new README.md file has been created to provide better guidance and information for developers.

### Since last release (the start)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Drop odoo-commons pin on the core image (Dockerfile clones by ref name, not SHA) ([`0e54e65`](https://github.com/OpenG2P/pbms/commit/0e54e65238d79f8d1fbd7bf0bd8c43b381874188))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Adopt central build-publish CI (5 images + openg2p-pbms chart + changelog); remove old docker/helm workflows. Pull g2p-bridge models from GitLab develop (was the GitHub mirror) ([`5248e61`](https://github.com/OpenG2P/pbms/commit/5248e61241476d0d93bdc50de48d86b30677082c))
- [G2P-3614](https://openg2p.atlassian.net/browse/G2P-3614) versions updated. ([`565993f`](https://github.com/OpenG2P/pbms/commit/565993fd5e86ed5a9f2754ac86127354d50c98fd))
- [G2P-3614](https://openg2p.atlassian.net/browse/G2P-3614) Postgres-init chart version updated. ([`82c20f6`](https://github.com/OpenG2P/pbms/commit/82c20f68361ef60e305b2b58ef7cd56b3ef9fedd))
- [G2P-3614](https://openg2p.atlassian.net/browse/G2P-3614) Consolidation. WIP. ([`36b2fee`](https://github.com/OpenG2P/pbms/commit/36b2feeef878f2d33b1a7e8c1fbae3abf145671f))
- [G2P-3614](https://openg2p.atlassian.net/browse/G2P-3614) Consolidation. WIP. ([`7fe8455`](https://github.com/OpenG2P/pbms/commit/7fe8455c55dc4cccf46eafd9c4d09c06569ca9be))
- Create README.md ([`29cd29e`](https://github.com/OpenG2P/pbms/commit/29cd29e674f88b583e73cdf9742d95306de31f5e))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 3 develop builds** and the **latest 3 release
> candidates** per release line. Older develop builds and release candidates
> are pruned as they are superseded, and a release's candidates are removed
> once it ships. Those versions still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
