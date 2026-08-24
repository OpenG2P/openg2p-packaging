# openg2p-fastapi-common

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-fastapi-common](https://github.com/OpenG2P/openg2p-fastapi-common)

| Version | Date | Type |
| --- | --- | --- |
| [`develop`](#v-branch-develop) | 2026-08-24 | branch |

# Branches (moving)

<a id="v-branch-develop"></a>

## openg2p-fastapi-common — `develop` branch (2026-08-24)

_moving branch · latest commit `406933a` · baseline: v1.1.5_
<!-- build:develop revision:406933a4913430d9096c0aa4a59dc5f171b89b79 ts:1787558570 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Enhanced connection management: enabled SQLAlchemy connection pool pre-ping and recycling to prevent stale connections causing HTTP 500 errors in long-running pods.
- Security improvements: added middleware for security headers in API responses and implemented tests to verify their presence.
- Documentation updates: revised README for GitLab migration, fixed formatting, and updated repository links.
- Changelog management: introduced automated library changelog tracking and removed the obsolete manual tag.yml.
- Local enhancements: added local crypto management to bypass Keymanager and implemented caching for partner management service keys.
- Code quality: fixed ruff C408 issues in tests and applied pre-commit style fixes across the codebase.

### Recent commits (latest 5)

- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))
- Update README.md ([`1dd3991`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/1dd39910c6f1c8b7dcbeba46aa3d2a186e75b480))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) fastapi-common: enable connection-pool pre-ping and recycle — SQLAlchemy defaults (pre_ping=False, recycle=-1) let every service hand out stale pooled connections, surfacing as intermittent HTTP 500s (asyncpg ConnectionDoesNotExistError) on long-running pods such as the Consent Manager ([`b11fac3`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/b11fac39f8db6dc12581bf14d179c67ed5bce672))

---

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
