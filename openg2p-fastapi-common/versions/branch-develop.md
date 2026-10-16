## openg2p-fastapi-common — `develop` branch (2026-10-16)

_moving branch · latest commit `164f07f` · baseline: v1.1.5_
<!-- build:develop revision:164f07f7e7f38944b60cb1528d2582d025b830b5 ts:1792127779 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Database connection management overhaul with async sessionmaker and pool settings, including enhanced asyncpg support with PgBouncer and connection-pool pre-ping to prevent stale connections.
- Key management refactor: introduced a process-wide key cache for crypto helpers and added local crypto management to bypass the Keymanager.
- Security enhancements: added middleware for security headers in API responses and implemented tests for these headers.
- CI improvements: migrated repository workflows from GitHub to GitLab, including the addition of a changelog workflow and removal of obsolete tag workflow.
- Testing enhancements: improved init_db tests for PostgreSQL connection arguments and added new tests for database pooling and partner management key store.

### Recent commits (latest 5)

- [G2P-5811](https://openg2p.atlassian.net/browse/G2P-5811) Refactor key management in crypto helpers to share a process-wide key cache ([`ab0ea5d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ab0ea5dc334e7eb3d3c240c47b8ebbc16f937ddf))
- Enhance init_db test to verify additional connection arguments for PostgreSQL ([`9859382`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/98593820b17b63220c08bfd071e5171e8c60e63b))
- Enhance database connection settings for asyncpg with PgBouncer support ([`6753b84`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6753b846e9c9f853b8526700453a20c492ee6507))
- [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmaker and pool settings ([`17057b7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17057b7ec69f02bc982813886749d61a4f94d620))
- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
