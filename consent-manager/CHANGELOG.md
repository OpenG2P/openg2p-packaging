# consent-manager changelog

_Published automatically._

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.44`](#v-0-0-0-develop-44) | 2026-07-15 | develop |

<a id="v-0-0-0-develop-44"></a>

## consent-manager — Unreleased (0.0.0-develop.44, 2026-07-15)

_commit `88041e0` · baseline: release the start · previous build 0.0.0-develop.42 · artifacts: `registry.gitlab.com/openg2p`_
<!-- build:0.0.0-develop.44 revision:88041e0bb0e001338e2ccdded9eb334108c614d3 -->

### Summary

_All changes since release the start:_

- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Major changes related to new Partner Management integration, including proper integration with PM and AWE.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) JWS support added to enhance security and authentication capabilities.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Public keys are now stored in the database, with an additional option to query well-known keys.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) AWE is deactivated by default; it can be enabled if required, with sanity tests passing only when it is deactivated.
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Consent-manager images and Helm chart are now published exclusively to GitHub Container Registry (GHCR), dropping support for GitLab.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Deployment will fail if the sanity test fails, ensuring higher reliability.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fixed race condition issues and multiple pod creation problems to improve stability.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Helm chart publish issues have been resolved, ensuring successful deployments.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) FastAPI 'develop' version is now in use for better development practices.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) End-to-end tests are enabled by default to ensure comprehensive testing.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sanity test job run added to improve testing coverage.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Support for multiple modules using the same consent manager has been implemented.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Confusing options have been removed to streamline configuration.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fixed issues related to .p12 file handling and key storage.
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Minor fixes and cleanup to enhance overall code quality.

### New in this build (since 0.0.0-develop.42)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in caller to satisfy reusable workflow (fix startup failure) ([`88041e0`](https://github.com/OpenG2P/consent-manager/commit/88041e0bb0e001338e2ccdded9eb334108c614d3))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Publish consent-manager images and chart to GitLab; drop GHCR ([`b38f1e7`](https://github.com/OpenG2P/consent-manager/commit/b38f1e7e9691d25f6e50ebcdd6d882412dcb0a3c))

### Since last release (the start)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in caller to satisfy reusable workflow (fix startup failure) ([`88041e0`](https://github.com/OpenG2P/consent-manager/commit/88041e0bb0e001338e2ccdded9eb334108c614d3))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Publish consent-manager images and chart to GitLab; drop GHCR ([`b38f1e7`](https://github.com/OpenG2P/consent-manager/commit/b38f1e7e9691d25f6e50ebcdd6d882412dcb0a3c))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) consent-manager: publish images + chart to GHCR (chart under charts/ to avoid image name clash) ([`b736910`](https://github.com/OpenG2P/consent-manager/commit/b73691010948b6fb58607aef4825f28b4f23ae3b))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Publish images + chart to GHCR only (OCI), values to ghcr.io ([`6f7508a`](https://github.com/OpenG2P/consent-manager/commit/6f7508aa35737986fec55598e0a692384da7bf63))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) clarify changelog workflow_dispatch input descriptions ([`326edee`](https://github.com/OpenG2P/consent-manager/commit/326edeebd7ca9b5284da5991f14b571046442ce6))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) forward changelog dispatch inputs to central workflow ([`75b649f`](https://github.com/OpenG2P/consent-manager/commit/75b649f3ceafb79f250ea20d8464e94323d56d63))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Fix in publish. ([`9ff69b6`](https://github.com/OpenG2P/consent-manager/commit/9ff69b6b74defc2d7f51095bd9504db1f108f95b))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) ci: replace docker-build + helm-publish with central build-publish workflow ([`0a508a6`](https://github.com/OpenG2P/consent-manager/commit/0a508a6e8ecbbb33d5b1d6ad898c28e409c051b1))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`4a1970a`](https://github.com/OpenG2P/consent-manager/commit/4a1970a73dd468c6302472ed948dda894fe5bf45))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) PM Url corrected. ([`a6265f7`](https://github.com/OpenG2P/consent-manager/commit/a6265f7b7d1872d34add1d25246d19c40d05ba35))
-  [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) PM Url corrected. ([`9ffcf64`](https://github.com/OpenG2P/consent-manager/commit/9ffcf645f5d78caa6569652f028d3f3d6ed8fbb7))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) JWS support added. ([`b234266`](https://github.com/OpenG2P/consent-manager/commit/b2342667d70a922401a0fac8bc77f1a6367bf2e0))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) UI Docker built. ([`4e6cb62`](https://github.com/OpenG2P/consent-manager/commit/4e6cb62e10e5eaff611ef4975620d51b6deebe4b))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) AWE deactivated by default. Use it if required. Sanity test will pass only if it is deactivated. ([`1be662c`](https://github.com/OpenG2P/consent-manager/commit/1be662c03e9110f60e7399b943951e2421a8feb8))
-  [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) PM client name corrected. ([`32be265`](https://github.com/OpenG2P/consent-manager/commit/32be265106e622724f2a6e93cce98f698eb331df))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Rejig based on staff, partner apis ([`9844b65`](https://github.com/OpenG2P/consent-manager/commit/9844b65751c50305939fa98dad1e41659cbb7e85))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Proper integration with PM and AWE. ([`09dc8b4`](https://github.com/OpenG2P/consent-manager/commit/09dc8b4129b3915a2c3c6ef5fa5602ae8db6b0b2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Proper integration with PM and AWE. WIP ([`def0cbf`](https://github.com/OpenG2P/consent-manager/commit/def0cbf4a5dfc19949c33633485e792f3d8990a8))
-  [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Proper integration with PM and AWE. WIP ([`30b443c`](https://github.com/OpenG2P/consent-manager/commit/30b443c35f55d0944ed93d6fa6baf2bf86958c5b))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fix for sanity auth issue ([`a04fd55`](https://github.com/OpenG2P/consent-manager/commit/a04fd55d497a217645e2f6705ff7eac436d6eb6c))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fix for sanity auth issue ([`27eca21`](https://github.com/OpenG2P/consent-manager/commit/27eca211b9a6b7582ebd53e232228cb266b756f1))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sanity test job run added. ([`73e11ea`](https://github.com/OpenG2P/consent-manager/commit/73e11ea0d93a5dc164ff686fd6056af8018e9f37))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Major changes -- modifications related to new Partner Management ([`2455380`](https://github.com/OpenG2P/consent-manager/commit/2455380690738eb847d515a9e3c4e559b846e156))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Race condition fix ([`6f3d0f8`](https://github.com/OpenG2P/consent-manager/commit/6f3d0f8f2ae61fb5ed4d1c5c11c95122fa68c244))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Cron job bug fixed ([`1f73a66`](https://github.com/OpenG2P/consent-manager/commit/1f73a66b19ec3a641325a9dbcf67043ffc101e17))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fix for previous change ([`e5517bb`](https://github.com/OpenG2P/consent-manager/commit/e5517bb9a2765652bca575e72d290a422c663d67))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Fastapi 'develop' version used. ([`dcd84fe`](https://github.com/OpenG2P/consent-manager/commit/dcd84fe4966494a3f3fc0b05beae484a9c0d22a2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) TODO added for APIs to be done later. ([`500dc6a`](https://github.com/OpenG2P/consent-manager/commit/500dc6a9816504977763e0c3302ddeb37c906677))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) e2e test enabled by default ([`f973d14`](https://github.com/OpenG2P/consent-manager/commit/f973d14078b4b940f6ccdf5f4b572ea48fa9cb70))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Deployment fails if sanity test fail. ([`c1427de`](https://github.com/OpenG2P/consent-manager/commit/c1427def990b7be8e35f581721919355eb61b05d))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Confusing options removed. ([`8726d5b`](https://github.com/OpenG2P/consent-manager/commit/8726d5b809a80b2cc85dcdc0ee4afd85c50b2754))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Ensured sanity test works with external p12 key as well and not just with demo key. ([`0c98672`](https://github.com/OpenG2P/consent-manager/commit/0c9867200b0b63509f97f2978a11a2ba6f2a61a4))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Issue related to multiple pods being created fixed. ([`9c17c43`](https://github.com/OpenG2P/consent-manager/commit/9c17c43656d4772e52d2ea6d1e05fedecb3a40dd))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Public keys stored in DB. and another option to query well known added. ([`c8c1d2c`](https://github.com/OpenG2P/consent-manager/commit/c8c1d2c6054a5f5536321037feb97e59a0e9eeb4))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sorted out .p12 file issues - the way keys are stored and installed. ([`c5c5f22`](https://github.com/OpenG2P/consent-manager/commit/c5c5f22a0179db982def3d82d8f3234fe21e75a5))
- Cleanup ([`9f0afb9`](https://github.com/OpenG2P/consent-manager/commit/9f0afb9926c68d679d981996bcea42ad31d0c6b2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Helm chart publish issue fixed. ([`81350da`](https://github.com/OpenG2P/consent-manager/commit/81350da7202ff8e8643c924f988feaf413c2133a))
- publish consent-manager helm chart OpenG2P/consent-manager@0a344ad029cf7b1782dba92a2901958bf68840e0 ([`ee5fa21`](https://github.com/OpenG2P/consent-manager/commit/ee5fa21597673992831990f734826a56b505eecd))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Support for multiple modules using the same CM. ([`0a344ad`](https://github.com/OpenG2P/consent-manager/commit/0a344ad029cf7b1782dba92a2901958bf68840e0))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Minor. ([`9e2bdbd`](https://github.com/OpenG2P/consent-manager/commit/9e2bdbdca1cf59299ab03d8ff7ddca9e9c570c67))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Helm, docker, auth added. ([`fd3cc33`](https://github.com/OpenG2P/consent-manager/commit/fd3cc33d81541c726fc354c848aef40bd2afc399))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) WIP. ([`8ddad02`](https://github.com/OpenG2P/consent-manager/commit/8ddad0276f1880ae7362ffb4efb3e185bd25cdc3))
- Create README.md ([`85a52fe`](https://github.com/OpenG2P/consent-manager/commit/85a52fe6c04a66d43a5985c1930ca206574a4240))

