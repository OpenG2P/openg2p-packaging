# iam-service changelog

_Published automatically._

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.58`](#v-0-0-0-develop-58) | 2026-07-14 | develop |

<a id="v-0-0-0-develop-58"></a>

## iam-service — Unreleased (0.0.0-develop.58, 2026-07-14)

_commit `5b67859` · baseline: release v1.2.1 · previous build 0.0.0-develop.55_
<!-- build:0.0.0-develop.58 revision:5b678592fa5cb36393ca887020f7a3c7e5662130 -->

### Summary

_All changes since release v1.2.1:_

- Remove JwtBearerAuth class and related tests from the codebase.
- Implement CSRF token protection for authenticated requests.
- Implement logout functionality and update refresh token TTL configuration.
- Persist refresh tokens in Redis and auto-refresh in middleware.
- Refactor(auth): update RefreshTokenMiddleware to validate tokens before refreshing.
- Refactor(auth): extract shared functionality into UserAuthMiddlewareBase and update AuthMiddleware and RefreshTokenMiddleware to extend it.
- Implement refresh token middleware and related helpers for token management.
- Add DataPolicyMiddleware and data policy role helper functions.
- Add Environment Variable to Toggle CSRF Middleware.
- Add cache expiration configuration for staff portal API.
- Fix staff portal app registration auth, CSRF, and seeded id sequences.
- Enhance DataLoader to sync staff access ID sequences and update imports.
- Improve unit test coverage for core IAM functionality.
- Add unit tests for IAM staff portal API components.
- Fix for migrate error. Pod was crashing while starting.
- New CI implemented.
- 0.0.0-develop.N versioning implemented.
- Refactor IAM core codebase for readability.
- Fix unit tests.
- Minor fix for error in the beginning, but a harmless error.
- README update.
- Pre-commit fixes.

### New in this build (since 0.0.0-develop.55)

- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Add unit tests for IAM staff portal API components ([`8670822`](https://github.com/OpenG2P/iam-service/commit/867082285f362b88550be7ba2a265621eb0b8a4d))
- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Improve unit test coverage for core IAM functionality ([`c762c7b`](https://github.com/OpenG2P/iam-service/commit/c762c7b741a5c9d19bbd30b6875daacbd5d88717))

### Since last release (v1.2.1)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented ([`8109437`](https://github.com/OpenG2P/iam-service/commit/810943725a2040fadbf4c18868471f205daa930c))
- 0.0.0-develop.N versioning implemented. ([`a1579ba`](https://github.com/OpenG2P/iam-service/commit/a1579ba229373a333ceb75797685e3a086d2b9d8))
- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Add unit tests for IAM staff portal API components ([`8670822`](https://github.com/OpenG2P/iam-service/commit/867082285f362b88550be7ba2a265621eb0b8a4d))
- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Improve unit test coverage for core IAM functionality ([`c762c7b`](https://github.com/OpenG2P/iam-service/commit/c762c7b741a5c9d19bbd30b6875daacbd5d88717))
- pre-commit fix ([`775c7ed`](https://github.com/OpenG2P/iam-service/commit/775c7edb62cd710401eeb6712724f20fee8d39db))
- [G2P-5270](https://openg2p.atlassian.net/browse/G2P-5270): Add DataPolicyMiddleware and data policy role helper functions ([`6c9e247`](https://github.com/OpenG2P/iam-service/commit/6c9e2472075d5d8c5c797a40300704b06a31487b))
- Minor fix for error in the beginning, but a harmless error. ([`7719752`](https://github.com/OpenG2P/iam-service/commit/77197526c7a8ab4d246870de86edd520a7482348))
- Fix for migrate error. Pod was crashing while starting. ([`2403c03`](https://github.com/OpenG2P/iam-service/commit/2403c030656201678c2eace310ec7f573b21c64e))
- README update ([`edf09c5`](https://github.com/OpenG2P/iam-service/commit/edf09c59b32924d165701d43adeb8123b49e9c51))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add Environment Variable to Toggle CSRF Middleware ([`50c346b`](https://github.com/OpenG2P/iam-service/commit/50c346be89125fde338cfdd4b23356db44f3cc48))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Enhance DataLoader to sync staff access ID sequences and update imports ([`8216a2f`](https://github.com/OpenG2P/iam-service/commit/8216a2f3504b8af575684e28c876e4f43c6b966a))
- [G2P-5199](https://openg2p.atlassian.net/browse/G2P-5199) Add cache expiration configuration for staff portal API ([`d6e6417`](https://github.com/OpenG2P/iam-service/commit/d6e6417bc87ba00a85681075c008e8b8003cf65f))
- [G2P-5199](https://openg2p.atlassian.net/browse/G2P-5199) Fix staff portal app registration auth, CSRF, and seeded id sequences. ([`7bb5f83`](https://github.com/OpenG2P/iam-service/commit/7bb5f83db7fd63553f073df06fca515ada9d8b29))
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
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Chart version updated in develop branch. ([`2bb64ad`](https://github.com/OpenG2P/iam-service/commit/2bb64ad68b2359adc1feec7bfb9239818574772a))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Pre-commit fixes. ([`4252a3a`](https://github.com/OpenG2P/iam-service/commit/4252a3a531ef88415b9513e3cca97191b275b0ec))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Chart version and image version corrected. ([`cb75f63`](https://github.com/OpenG2P/iam-service/commit/cb75f637edbf996f3089c5c2e45a867b7ec2c76d))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) WIP. ([`9b75bb2`](https://github.com/OpenG2P/iam-service/commit/9b75bb2836b6eac5ac34cdd53c97af6e0fb4afc5))

