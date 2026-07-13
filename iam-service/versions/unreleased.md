## iam-service — Unreleased (0.0.0-develop.55, 2026-07-13)

_commit `8109437` · baseline: release the start_
<!-- build:0.0.0-develop.55 revision:810943725a2040fadbf4c18868471f205daa930c -->

### Summary

_All changes since release the start:_

- Improved security with CSRF protection and better token management.
- Enhanced data policy controls for role-based access.
- Fixed issues with application startup and authentication.
- Updated dependencies and internal configurations for stability.

### Since last release (the start)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented ([`8109437`](https://github.com/OpenG2P/iam-service/commit/810943725a2040fadbf4c18868471f205daa930c))
- 0.0.0-develop.N versioning implemented. ([`a1579ba`](https://github.com/OpenG2P/iam-service/commit/a1579ba229373a333ceb75797685e3a086d2b9d8))
- pre-commit fix ([`775c7ed`](https://github.com/OpenG2P/iam-service/commit/775c7edb62cd710401eeb6712724f20fee8d39db))
- [G2P-5270](https://openg2p.atlassian.net/browse/G2P-5270): Add DataPolicyMiddleware and data policy role helper functions ([`6c9e247`](https://github.com/OpenG2P/iam-service/commit/6c9e2472075d5d8c5c797a40300704b06a31487b))
- Minor fix for error in the beginning, but a harmless error. ([`7719752`](https://github.com/OpenG2P/iam-service/commit/77197526c7a8ab4d246870de86edd520a7482348))
- Fix for migrate error. Pod was crashing while starting. ([`2403c03`](https://github.com/OpenG2P/iam-service/commit/2403c030656201678c2eace310ec7f573b21c64e))
- README update ([`edf09c5`](https://github.com/OpenG2P/iam-service/commit/edf09c59b32924d165701d43adeb8123b49e9c51))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add Environment Variable to Toggle CSRF Middleware ([`50c346b`](https://github.com/OpenG2P/iam-service/commit/50c346be89125fde338cfdd4b23356db44f3cc48))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Enhance DataLoader to sync staff access ID sequences and update imports ([`8216a2f`](https://github.com/OpenG2P/iam-service/commit/8216a2f3504b8af575684e28c876e4f43c6b966a))
- [G2P-5199](https://openg2p.atlassian.net/browse/G2P-5199) Add cache expiration configuration for staff portal API ([`d6e6417`](https://github.com/OpenG2P/iam-service/commit/d6e6417bc87ba00a85681075c008e8b8003cf65f))
- [G2P-5199](https://openg2p.atlassian.net/browse/G2P-5199) Fix staff portal app registration auth, CSRF, and seeded id sequences. ([`7bb5f83`](https://github.com/OpenG2P/iam-service/commit/7bb5f83db7fd63553f073df06fca515ada9d8b29))
- Bump version to 1.2.1 ([`3ddf0fa`](https://github.com/OpenG2P/iam-service/commit/3ddf0faeb4c29df3c9f1a0d32589779ee6587aa4))
- [G2P-5183](https://openg2p.atlassian.net/browse/G2P-5183) Implement CSRF token protection for authenticated requests ([`c6147b2`](https://github.com/OpenG2P/iam-service/commit/c6147b2fb7a880e7ab892391708c9bf46fc72862))
- Fix Unit Tests ([`d37e285`](https://github.com/OpenG2P/iam-service/commit/d37e285abc4c1692c1fc931fcfc18fe5916c257a))
- [G2P-5154](https://openg2p.atlassian.net/browse/G2P-5154) Implement logout functionality and update refresh token TTL configuration ([`2b7eec7`](https://github.com/OpenG2P/iam-service/commit/2b7eec73d726ec455bf8bc6f9f71b097b1a96735))
- Remove JwtBearerAuth class and related tests from the codebase ([`607c490`](https://github.com/OpenG2P/iam-service/commit/607c490c82a68150dbcd9401d14441c940aacc1f))
- Refactor IAM core codebase for readability ([`3419bdb`](https://github.com/OpenG2P/iam-service/commit/3419bdbbdc10769fcfda90e97bd8a4d945c82c2c))
- Fix unit tests ([`86fb183`](https://github.com/OpenG2P/iam-service/commit/86fb1838863aaa8feef2383951034a6134dbd204))
- Fix pre-commit ([`89ecbda`](https://github.com/OpenG2P/iam-service/commit/89ecbda9591e007277e1230d4bc21301f3d2f618))
- [G2P-5161](https://openg2p.atlassian.net/browse/G2P-5161) Refactor(auth): update RefreshTokenMiddleware to validate tokens before refreshing ([`e7e0f19`](https://github.com/OpenG2P/iam-service/commit/e7e0f1912bd112b182419fcf8ef6a3a5901d1097))
- [G2P-5161](https://openg2p.atlassian.net/browse/G2P-5161) Refactor(auth): extract shared functionality into UserAuthMiddlewareBase and update AuthMiddleware and RefreshTokenMiddleware to extend it ([`f54e469`](https://github.com/OpenG2P/iam-service/commit/f54e469aed2c2fcfc43f08b5e6c02ec98a246b52))
- [G2P-5161](https://openg2p.atlassian.net/browse/G2P-5161) Implement refresh token middleware and related helpers for token management ([`d810073`](https://github.com/OpenG2P/iam-service/commit/d81007356c0667b0eb2bf3fdff1b95c60d47f557))
- [G2P-5161](https://openg2p.atlassian.net/browse/G2P-5161) Persist refresh tokens in Redis and auto-refresh in middleware ([`78cc3e8`](https://github.com/OpenG2P/iam-service/commit/78cc3e804c4b0f62808546642e0c4345bbe71ec5))
- Fix(auth): resolve nested FastAPI routes in AuthMiddleware for 0.137+ ([`435af54`](https://github.com/OpenG2P/iam-service/commit/435af546d5e63d1142001afcf021cdacef6acc2d))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Chart version updated in develop branch. ([`2bb64ad`](https://github.com/OpenG2P/iam-service/commit/2bb64ad68b2359adc1feec7bfb9239818574772a))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Pre-commit fixes. ([`4252a3a`](https://github.com/OpenG2P/iam-service/commit/4252a3a531ef88415b9513e3cca97191b275b0ec))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Chart version and image version corrected. ([`cb75f63`](https://github.com/OpenG2P/iam-service/commit/cb75f637edbf996f3089c5c2e45a867b7ec2c76d))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) WIP. ([`9b75bb2`](https://github.com/OpenG2P/iam-service/commit/9b75bb2836b6eac5ac34cdd53c97af6e0fb4afc5))
- Bump version for 1.2 ([`9be61c4`](https://github.com/OpenG2P/iam-service/commit/9be61c43363846fd93fd4cb271001b6a937b67e6))
- Bump version to 1.2.0-develop ([`dd3eb2a`](https://github.com/OpenG2P/iam-service/commit/dd3eb2ac700d53db20f2b055d31d56e4e4f91358))
- [G2P-5129](https://openg2p.atlassian.net/browse/G2P-5129): Updated OidcClient to utilize the `auth_verify_ssl` configuration parameter for SSL verification during token fetching. ([`10fd96d`](https://github.com/OpenG2P/iam-service/commit/10fd96d1f7598d868c8693356932627f62d62720))
- [G2P-5129](https://openg2p.atlassian.net/browse/G2P-5129): Add IAM_STAFF_AUTH_VERIFY_SSL parameter to values.yaml ([`3bc1c5a`](https://github.com/OpenG2P/iam-service/commit/3bc1c5a8a9f420c702a27ebbb884794ddaa5b95a))
- [G2P-5130](https://openg2p.atlassian.net/browse/G2P-5130) Superset added to staff portal ui. ([`81454c7`](https://github.com/OpenG2P/iam-service/commit/81454c751d913b150107e33c0f28535289df9421))
- [G2P-5129](https://openg2p.atlassian.net/browse/G2P-5129): Add env parameter to control SSL verification for OIDC requests ([`2bc6892`](https://github.com/OpenG2P/iam-service/commit/2bc6892710c1863c200ea8e0b4fbf6d55ef80819))
- Fix pre-commit: black/ruff-format conflict + __init__.py F401 ([`b0115a1`](https://github.com/OpenG2P/iam-service/commit/b0115a1c9b553e310b6220752bbef6c53653d2c0))
- [G2P-5128](https://openg2p.atlassian.net/browse/G2P-5128) IAM consolidation ([`ba37320`](https://github.com/OpenG2P/iam-service/commit/ba37320984099d701026e4034a3d818c14a91f15))
- Create LICENSE ([`76abccf`](https://github.com/OpenG2P/iam-service/commit/76abccf4fab143e8f09699aa45748ccce152565c))
