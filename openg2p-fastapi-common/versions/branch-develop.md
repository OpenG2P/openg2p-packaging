## openg2p-fastapi-common — `develop` branch (2026-08-24)

_moving branch · latest commit `491b36b` · baseline: v1.1.5_
<!-- build:develop revision:491b36b0e9fed5065ae20455f8dc27ffbd76a7f7 ts:1787558684 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Repository migration to GitLab reflected in README updates and formatting fixes.
- Connection handling: Enabled SQLAlchemy connection pool pre-ping and recycling to prevent stale connections causing HTTP 500 errors in long-running pods.
- Security enhancements: Added middleware for security headers in API responses and implemented tests to verify their presence.
- Library management: Introduced changelog tracking for reusable images and chart jobs, while removing the obsolete manual tag.yml.
- Local crypto management added to bypass the Keymanager, alongside caching for partner management service keys.
- Code quality: Fixed ruff C408 issues and applied pre-commit style fixes across the codebase.

### Recent commits (latest 5)

- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))
- Update README.md ([`1dd3991`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/1dd39910c6f1c8b7dcbeba46aa3d2a186e75b480))
