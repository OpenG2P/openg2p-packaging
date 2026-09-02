## openg2p-fastapi-common — `develop` branch (2026-09-02)

_moving branch · latest commit `5a855e2` · baseline: v1.1.5_
<!-- build:develop revision:5a855e201c56c54998de2c92a06bb10f1db89ad0 ts:1788325413 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Enhanced database connection management with async sessionmaker and connection pool settings, including pre-ping and recycling to prevent stale connections causing HTTP 500 errors.
- Security improvements: Added middleware for security headers in API responses and implemented tests to verify their presence.
- Repository migration: Updated README files to reflect the transition from GitHub to GitLab, including formatting fixes and repository link updates.
- Dependency updates: Modified dependency manifests in `pyproject.toml` and added changelog tracking for library updates.
- Testing enhancements: Introduced new tests for database connection management and partner management key store, alongside fixes for existing test code.

### Recent commits (latest 5)

- [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmaker and pool settings ([`17057b7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17057b7ec69f02bc982813886749d61a4f94d620))
- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
