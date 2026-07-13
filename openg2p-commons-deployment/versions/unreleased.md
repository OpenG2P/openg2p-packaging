## openg2p-commons-deployment — Unreleased (0.0.0-develop.165, 2026-07-13)

_commit `39580bd` · baseline: release v2.0.1_
<!-- build:0.0.0-develop.165 revision:39580bd6fe94d9ec38f87881e7d139296f792aac -->

### Summary

_All changes since release v2.0.1:_

- Added optional Consent Manager service.
- Integrated Partner Management service.
- Improved build and publishing workflows.
- Resolved various issues and updated component versions.

### Since last release (v2.0.1)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) add bespoke build/publish workflow for commons packaging charts; drop old push_trigger ([`39580bd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/39580bd6fe94d9ec38f87881e7d139296f792aac))
- Versions updated. ([`3749358`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/3749358efd7fbec38c56844983b19051c520e70a))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Add Consent Manager as an optional commons-services subchart (OFF by default, deployed as commons-services-cm-*, surfaced in questions.yaml), mirroring the Partner Management integration. ([`fdb20b1`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/fdb20b1c05311ac0fbabe738072bd5492f1074e8))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Changes for automatic tests running from bridge. ([`5414c00`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/5414c00ce2c45bad955369d383b90c41e36f7bf4))
- PM version updated. ([`38de50b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/38de50b5664d3a5e581a0c94cd448bd262bd9dec))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Partner Management integrated. ([`cd78e01`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cd78e010cdc6fbfc5a16c8ab97bd5852c9b7abb2))
- Softhsm had to be enabled again as esignet and mock id requires them. Develop versioning improved. ([`c5dabe5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c5dabe5e4d4f6ca2fdf40fdb6fceb53fc291fe4c))
- Softhsm chart disabled as we are using .p12 ([`03211c7`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/03211c7c81bb98ece9d8face5a9bcb9912396200))
- [G2P-5260](https://openg2p.atlassian.net/browse/G2P-5260) AWE installed as part of commons. ([`e762f72`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/e762f7240b8ba26b24b34ec8765477defa9d32ba))
- [G2P-5127](https://openg2p.atlassian.net/browse/G2P-5127)  Reverted previous changes as it was  causing issues. ([`46d75dd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/46d75ddce0d25fae9bdbefdeee6b7c3e2e6c9af0))
- [G2P-5127](https://openg2p.atlassian.net/browse/G2P-5127) The fix had called hook issues in commons. The hooks overriden in commons base chart. ([`5ff84d8`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/5ff84d821e55ef5f24de78c748e2fd8a2367b206))
- Fix related to Keycloak-init. ([`9ea1829`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9ea1829c4c09572aafa8cf119f6cadac4bca5f27))
- Keycloak init chart version corrected. ([`1d8c473`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/1d8c47383ba74092c911b81f2fb717b0911c5605))
- [G2P-5139](https://openg2p.atlassian.net/browse/G2P-5139) Reporting removed. ([`f3c6fcc`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/f3c6fccab7989e6ad1af996d59c43f39ccf1623c))
- IAM image version change do develop as it contains latest. ([`82b291c`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/82b291cd4aec74cbf843d8271d455ab97fc3daf1))
- Minor pre-commit ([`997e39e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/997e39ed59e3b18eb0a3599a6d888752edc590be))
- Keycloak init version corrected. ([`5c0c041`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/5c0c04102e3fdaeed6943f4bba0300c3a8c638c5))
- [G2P-5130](https://openg2p.atlassian.net/browse/G2P-5130) IAM version updated. ([`a65585c`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a65585c9b86ea48c9eaff40131f3a6f7a476641a))
- [G2P-5130](https://openg2p.atlassian.net/browse/G2P-5130) Supeset added to IAM service. ([`9fdb870`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9fdb870a78ee8eb3312924818b555249e6f8e41b))
- [G2P-5073](https://openg2p.atlassian.net/browse/G2P-5073) Fixes related to race conditions etc. ([`b05ca43`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/b05ca43b2c6f0f7b85941e9ad846d00cf6eaf03c))
- [G2P-5072](https://openg2p.atlassian.net/browse/G2P-5072) Removed all limits. ([`9a60c90`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9a60c9032ea765e7caead50360824990fdd06dd7))
- [G2P-5065](https://openg2p.atlassian.net/browse/G2P-5065) Reference debezium removed. ([`f180d52`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/f180d525f0c130a777c21d4af35e136dbe550f9d))
- [G2P-5065](https://openg2p.atlassian.net/browse/G2P-5065) WIP. ([`ee03994`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ee039947cf29d4b4a8b24d41c981083321a18b18))
- Chart release names fixed as several services depend on these names and we don't expect to install commons more than once in the same environment. ([`be756ea`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/be756ea5735c3854885ebe7e44fbc56684c9b508))
- [G2P-4789](https://openg2p.atlassian.net/browse/G2P-4789) New postgres-init helm chart used to fix the lengthy job name problem. ([`6b826ab`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6b826abef795ac0ee3d8bfb1e827ce32836297f2))
- pre-commit errors fixed. ([`b840924`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/b840924e797527116563ef5d63e5bfc0a99c1ebe))
- develop branch added for automatic publish. ([`9f74957`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9f74957af114cbf9da99c4883675d3f9d9f90d2d))
- Version numbers corrected. ([`2142dda`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2142ddaf67cebc949a6a267e27178ba1d4cd73a5))
- [G2P-4817](https://openg2p.atlassian.net/browse/G2P-4817) Redirect URL fixed. ([`4a8d6dc`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/4a8d6dc0f285bf1adc35d2e0434f2d27747ed165))
- Mail version updated. ([`988bdf9`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/988bdf9f4ca70eb4ec10bde82529240e9c2e57d1))
- [G2P-4793](https://openg2p.atlassian.net/browse/G2P-4793) Prefix removed. ([`edbcee2`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/edbcee2a9a45fd2ee48c658432496c439cf64e8b))
- 1.x branch removed as we don't want to modify it further. ([`0d8f497`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/0d8f497a0c7ed9d524a5980a59d239e1fa84112f))
- Push trigger enabled only for 1.x and 2.x ([`643f10d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/643f10dbe98290c768795b6fc7d1b13a6c694e68))
