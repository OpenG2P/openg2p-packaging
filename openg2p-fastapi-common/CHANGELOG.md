# openg2p-fastapi-common

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-fastapi-common](https://github.com/OpenG2P/openg2p-fastapi-common)

| Version | Date | Type |
| --- | --- | --- |
| [`develop`](#v-branch-develop) | 2026-07-19 | branch |

# Branches (moving)

<a id="v-branch-develop"></a>

## openg2p-fastapi-common — `develop` branch (2026-07-19)

_moving branch · latest commit `dd7de09` · baseline: v1.1.5_
<!-- build:develop revision:dd7de091b14b9080791d131ecd8151cd35b31fd7 ts:1784449666 -->

### Summary

_Changes on `develop` since v1.1.5:_

- Local crypto management added to bypass Keymanager, enhancing security and performance.
- Security headers middleware introduced in the API to improve response security.
- Caching of keys implemented as we transition to using the partner management service.
- Library changelog tracking added; obsolete manual tag.yml file removed.
- Tests for security headers in API responses have been added to ensure proper implementation.
- Fixed ruff C408 issue in test_partner_mgmt_key_store.py to improve code quality.
- Minor style fixes applied via pre-commit hooks.
- Dependency manifests updated in pyproject.toml to reflect changes in the project.

### Recent commits (latest 5)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`dd7de09`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dd7de091b14b9080791d131ecd8151cd35b31fd7))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Fix ruff C408 (dict() -> literal) in test_partner_mgmt_key_store.py ([`9ddccc0`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9ddccc00f502c49415c0220e72d17a4a8edc3c5a))
- Just to trigger workflows, no change in code ([`17cda3d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17cda3d3341420b50b50d2950b97db3c7a9885d3))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking; drop obsolete manual tag.yml ([`c129243`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/c129243dd26f802a8861563fe38d4c8d37544254))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Caching of keys added as we are using partner management service going forward. ([`8869814`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/886981402893b9011dc6a68ffdf2448fba1c85df))

---

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
