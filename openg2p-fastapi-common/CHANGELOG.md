# openg2p-fastapi-common

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-fastapi-common](https://github.com/OpenG2P/openg2p-fastapi-common)

| Version | Date | Type | Notes |
| --- | --- | --- | --- |
| [`develop`](#v-branch-develop) | 2026-08-28 | branch |  |

# Branches (moving)

<a id="v-branch-develop"></a>

## openg2p-fastapi-common — `develop` branch (2026-08-28)

_moving branch · latest commit `57a7bb9` · baseline: v1.1.5_
<!-- build:develop revision:57a7bb9148dcc68f6d6f079e5f664777a96150dc ts:1787881502 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Repository migration to GitLab reflected in README updates and formatting fixes.
- Connection management: Enabled SQLAlchemy connection-pool pre-ping and recycling to prevent stale connections, addressing HTTP 500 errors in long-running pods.
- Security enhancements: Added middleware for security headers in API responses and implemented tests to verify their presence.
- Library management: Introduced changelog tracking for reusable images and removed the obsolete manual tag.yml file.
- Key management improvements: Added local crypto management to bypass Keymanager and implemented caching for partner management service keys.
- Code quality: Fixed ruff C408 issues in tests and applied pre-commit style fixes across the codebase.

### Recent commits (latest 5)

- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))

---

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
