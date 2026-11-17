## openg2p-fastapi-common — `develop` branch (2026-11-17)

_moving branch · latest commit `9445ac6` · baseline: 1.2.2_
<!-- build:develop revision:9445ac64f82e0e26716d7fefc6fd0703c7de2be2 ts:1794919021 -->

### Summary

_Changes on `develop` since 1.2.2:_

- **Major:** Removed Novu notification implementation and all related configurations, streamlining the notification system.
- Key management enhancement: Implemented a process-wide key cache for Partner Management in CryptoHelpers, improving efficiency in key handling.
- Database improvements: Enhanced connection settings for asyncpg with PgBouncer support and updated init_db tests to verify additional PostgreSQL connection arguments.
- CI/CD updates: Cleaned up CI configurations and added a warm cache mechanism to optimize build performance.

### Recent commits (latest 5)

- ci: cleanup ([`9445ac6`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9445ac64f82e0e26716d7fefc6fd0703c7de2be2))
- ci: warm cache ([`dda1be2`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dda1be2f39bea87be74c4ba79f8d0aeabb948c5f))
- Remove Novu notification implementation and related configurations ([`a947250`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/a9472505057dd275bc541f67277b105b64419034))
- Implement process-wide key cache for Partner Management in CryptoHelpers ([`6ca9e5c`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6ca9e5cd6875a4bdf584e3570eec8108df6164eb))
- [G2P-5811](https://openg2p.atlassian.net/browse/G2P-5811) Refactor key management in crypto helpers to share a process-wide key cache ([`ab0ea5d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ab0ea5dc334e7eb3d3c240c47b8ebbc16f937ddf))
