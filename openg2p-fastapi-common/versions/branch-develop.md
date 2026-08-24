## openg2p-fastapi-common — `develop` branch (2026-08-24)

_moving branch · latest commit `ef554af` · baseline: v1.1.5_
<!-- build:develop revision:ef554afb6616d7764d65605e71eb069c1075f7c9 ts:1787558447 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Connection pooling enhancements: enabled pre-ping and recycling in SQLAlchemy to prevent stale connections, addressing HTTP 500 errors in long-running pods.
- Security improvements: added middleware for security headers in API responses and implemented tests to verify their presence.
- Library management: introduced automatic changelog tracking and removed the obsolete manual tag.yml file.
- Key management updates: added local crypto management to bypass the Keymanager and implemented caching for partner management service keys.
- Code quality: fixed formatting issues in README and project name, updated documentation, and resolved ruff C408 warnings in tests.
- CI enhancements: added new changelog workflow and made minor adjustments to existing CI configurations.

### Recent commits (latest 5)

- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))
- Update README.md ([`1dd3991`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/1dd39910c6f1c8b7dcbeba46aa3d2a186e75b480))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) fastapi-common: enable connection-pool pre-ping and recycle — SQLAlchemy defaults (pre_ping=False, recycle=-1) let every service hand out stale pooled connections, surfacing as intermittent HTTP 500s (asyncpg ConnectionDoesNotExistError) on long-running pods such as the Consent Manager ([`b11fac3`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/b11fac39f8db6dc12581bf14d179c67ed5bce672))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`dd7de09`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dd7de091b14b9080791d131ecd8151cd35b31fd7))
