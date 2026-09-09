## openg2p-fastapi-common — `develop` branch (2026-09-09)

_moving branch · latest commit `9cf4513` · baseline: v1.1.5_
<!-- build:develop revision:9cf451311e0df2e4efed93531788120a5eeec60d ts:1788927657 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Database enhancements: improved connection management with asyncpg and PgBouncer support, added connection-pool pre-ping and recycling to prevent stale connections, and enhanced init_db tests for PostgreSQL connection arguments.
- Security improvements: added middleware for security headers in API responses and implemented tests to verify these headers.
- Repository migration: updated README files to reflect the transition from GitHub to GitLab, including formatting and link corrections.
- Dependency updates: modified dependency manifests in `pyproject.toml` and removed obsolete CI workflow file `tag.yml`.
- Testing enhancements: added new tests for database connection pooling and partner management key store, along with fixes for existing tests.

### Recent commits (latest 5)

- Enhance init_db test to verify additional connection arguments for PostgreSQL ([`9859382`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/98593820b17b63220c08bfd071e5171e8c60e63b))
- Enhance database connection settings for asyncpg with PgBouncer support ([`6753b84`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6753b846e9c9f853b8526700453a20c492ee6507))
- [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmaker and pool settings ([`17057b7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17057b7ec69f02bc982813886749d61a4f94d620))
- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
