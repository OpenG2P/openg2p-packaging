# openg2p-staff-portal-ui

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-staff-portal-ui](https://github.com/OpenG2P/openg2p-staff-portal-ui)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.58`](#v-0-0-0-develop-58) | 2026-08-06 | develop |
| [`0.0.0-develop.56`](#v-0-0-0-develop-56) | 2026-08-04 | develop |

# Develop builds

<a id="v-0-0-0-develop-58"></a>

## openg2p-staff-portal-ui — develop 0.0.0-develop.58 (2026-08-06)

_commit `f96c27d` · changes since 0.0.0-develop.56_
<!-- build:0.0.0-develop.58 revision:f96c27d9d6e986a8be1799818e1f0125cfea2cda ts:1786012889 -->

### Changes since 0.0.0-develop.56

- [G2P-5484](https://openg2p.atlassian.net/browse/G2P-5484) Refactor icon handling: add IconDisplay component, and utility functions for base64 icons ([`7fb5d39`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/7fb5d390a42f6fd4d93272186d8d00af3e6f6ede))

<a id="v-0-0-0-develop-56"></a>

## openg2p-staff-portal-ui — develop 0.0.0-develop.56 (2026-08-04)

_commit `c5e87ba` · changes since v1.1.0_
<!-- build:0.0.0-develop.56 revision:c5e87ba0d78d233c4a29d22c541d9370abda83e1 ts:1785819043 -->

### Summary

- **Major:** New CI system implemented to enhance build and deployment processes.
- Security improvements: added client-side CSRF token handling and updated authentication cookie management with configurable cookie domain.
- Refactoring: streamlined authentication handling and response processing in API routes, along with logout handling adjustments.
- Environment configuration updates: refined environment variables for better management.

### Changes since v1.1.0

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented. ([`beb29e2`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/beb29e20dfe49d9da1642d63f1608f12746412dd))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add cookieDomain to environment configuration and update auth cookie handling ([`ede5968`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/ede59681012c75d719da766009e6be57ca8595e4))
- [G2P-5183](https://openg2p.atlassian.net/browse/G2P-5183) Add client-side CSRF token handling ([`bd8eba6`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/bd8eba68efd189709e26b6a3bd50d4eec61e3738))
- [G2P-5154](https://openg2p.atlassian.net/browse/G2P-5154) Update environment variables, and refactor logout handling ([`9fcf42d`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/9fcf42d19de685e20b73ab7fa3bc2cee47add333))
- [G2P-5153](https://openg2p.atlassian.net/browse/G2P-5153) Refactor authentication handling and response processing in API routes ([`20bfcd9`](https://github.com/OpenG2P/openg2p-staff-portal-ui/commit/20bfcd9ce14522008ab55534fcc7e453cd5507bc))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 20 develop builds** and the **latest 10 release
> candidates** per release line. Older develop builds and release candidates
> are pruned as they are superseded, and a release's candidates are removed
> once it ships. Those versions still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
