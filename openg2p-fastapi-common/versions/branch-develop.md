## openg2p-fastapi-common — `develop` branch (2026-11-17)

_moving branch · latest commit `dda1be2` · baseline: 1.2.2_
<!-- build:develop revision:dda1be2f39bea87be74c4ba79f8d0aeabb948c5f ts:1794918834 -->

### Summary

_Changes on `develop` since 1.2.2:_

- **Major:** Removed Novu notification implementation and all related configurations, streamlining the notification system.
- Key management enhancement: Implemented a process-wide key cache for Partner Management in CryptoHelpers, improving efficiency in cryptographic operations.
- Database improvements: Enhanced database connection settings for asyncpg with PgBouncer support and updated init_db tests to verify additional PostgreSQL connection arguments.
- CI updates: Added a warm cache step to the CI pipeline to optimize build performance.

### Recent commits (latest 5)

- ci: warm cache ([`dda1be2`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dda1be2f39bea87be74c4ba79f8d0aeabb948c5f))
- Remove Novu notification implementation and related configurations ([`a947250`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/a9472505057dd275bc541f67277b105b64419034))
- Implement process-wide key cache for Partner Management in CryptoHelpers ([`6ca9e5c`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6ca9e5cd6875a4bdf584e3570eec8108df6164eb))
- [G2P-5811](https://openg2p.atlassian.net/browse/G2P-5811) Refactor key management in crypto helpers to share a process-wide key cache ([`ab0ea5d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ab0ea5dc334e7eb3d3c240c47b8ebbc16f937ddf))
- Pin sqlalchemy version to 2.0.20 ([`e306fe9`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/e306fe98cb07ff7b2f0f0f1f6f9c35d3e14bdf5d))
