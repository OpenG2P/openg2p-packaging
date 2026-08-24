# openg2p-fastapi-common

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-fastapi-common](https://github.com/OpenG2P/openg2p-fastapi-common)

| Version | Date | Type |
| --- | --- | --- |
| [`develop`](#v-branch-develop) | 2026-08-24 | branch |

# Branches (moving)

<a id="v-branch-develop"></a>

## openg2p-fastapi-common — `develop` branch (2026-08-24)

_moving branch · latest commit `8df6fe7` · baseline: v1.1.5_
<!-- build:develop revision:8df6fe726af4eef7ec281d9890e45dc31ef10509 ts:1787558430 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Connection pooling enhancements: enabled pre-ping and recycling in SQLAlchemy to prevent stale connections, addressing HTTP 500 errors in long-running pods.
- Security improvements: added middleware for security headers in API responses and implemented tests to verify their presence.
- Library management updates: introduced automated changelog tracking and removed the obsolete manual tag.yml file.
- Local crypto management feature added to bypass the Keymanager, enhancing key handling capabilities.
- Key caching implemented for improved performance with the partner management service.
- Code quality enhancements: fixed ruff C408 issues and applied pre-commit style fixes.
- Documentation updates: revised README.md for clarity and project information.

### Recent commits (latest 5)

- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))
- Update README.md ([`1dd3991`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/1dd39910c6f1c8b7dcbeba46aa3d2a186e75b480))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) fastapi-common: enable connection-pool pre-ping and recycle — SQLAlchemy defaults (pre_ping=False, recycle=-1) let every service hand out stale pooled connections, surfacing as intermittent HTTP 500s (asyncpg ConnectionDoesNotExistError) on long-running pods such as the Consent Manager ([`b11fac3`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/b11fac39f8db6dc12581bf14d179c67ed5bce672))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`dd7de09`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dd7de091b14b9080791d131ecd8151cd35b31fd7))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Fix ruff C408 (dict() -> literal) in test_partner_mgmt_key_store.py ([`9ddccc0`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9ddccc00f502c49415c0220e72d17a4a8edc3c5a))

---

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
