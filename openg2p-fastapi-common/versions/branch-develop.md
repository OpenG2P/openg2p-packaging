## openg2p-fastapi-common — `develop` branch (2026-07-24)

_moving branch · latest commit `b11fac3` · baseline: v1.1.5_
<!-- build:develop revision:b11fac39f8db6dc12581bf14d179c67ed5bce672 ts:1784860074 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Connection pooling enhancements: enabled pre-ping and recycling in SQLAlchemy to prevent stale connections causing intermittent HTTP 500 errors in long-running pods.
- Security improvements: added middleware for security headers in API responses and implemented tests to verify their presence.
- Library management updates: introduced automatic changelog tracking and removed the obsolete manual tag.yml.
- Key management enhancements: added local crypto management to bypass the Keymanager and implemented caching for partner management service keys.
- Code quality: fixed ruff C408 issues in tests and applied pre-commit style fixes.

### Recent commits (latest 5)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) fastapi-common: enable connection-pool pre-ping and recycle — SQLAlchemy defaults (pre_ping=False, recycle=-1) let every service hand out stale pooled connections, surfacing as intermittent HTTP 500s (asyncpg ConnectionDoesNotExistError) on long-running pods such as the Consent Manager ([`b11fac3`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/b11fac39f8db6dc12581bf14d179c67ed5bce672))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`dd7de09`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dd7de091b14b9080791d131ecd8151cd35b31fd7))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Fix ruff C408 (dict() -> literal) in test_partner_mgmt_key_store.py ([`9ddccc0`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9ddccc00f502c49415c0220e72d17a4a8edc3c5a))
- Just to trigger workflows, no change in code ([`17cda3d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17cda3d3341420b50b50d2950b97db3c7a9885d3))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking; drop obsolete manual tag.yml ([`c129243`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/c129243dd26f802a8861563fe38d4c8d37544254))
