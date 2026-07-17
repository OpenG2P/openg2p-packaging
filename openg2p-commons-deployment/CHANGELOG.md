# openg2p-commons-deployment changelog

_Published automatically._

| Version | Date | Type |
| --- | --- | --- |
| [`2.1.0`](#v-2-1-0) | 2026-07-13 | release |
| [`0.0.0-develop.171`](#v-0-0-0-develop-171) | 2026-07-17 | develop |

# Releases

<a id="v-2-1-0"></a>

## openg2p-commons-deployment 2.1.0 — 2026-07-13

_commit `44278e8` · first release_

### Summary

- Updated master data and partner management versions.
- Added Consent Manager as an optional service.
- Improved automatic test execution and build workflows.
- Resolved various bugs and configuration issues across multiple services.

### Changes

- Master data version updated. ([`44278e8`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/44278e83c26f5ec8bd1139408605869dd5fe5009))
- Master Data version updated. ([`7328c8c`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7328c8cb68ea317ab117e8531853c469a753fe8f))
- PM, Master data updated. ([`a8537c6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a8537c68b96d30503135478723430bd8ea752d70))
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
- [G2P-4456](https://openg2p.atlassian.net/browse/G2P-4456) Bug related to minio port fixed. ([`7f5fdb5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7f5fdb56613098e543886c7067f2678f8b5b4e51))
- [G2P-4456](https://openg2p.atlassian.net/browse/G2P-4456) Major restructuing of Keycloak-init to make sure we don't have hardcoding, and clients related to each chart are created in their respective charts. Before this, all clients were being created in the base chart. ([`ea87204`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ea87204f3b83ea72bc329ddddb6217902f270587))
- [G2P-4688](https://openg2p.atlassian.net/browse/G2P-4688) Fix attempt for external postgres. ([`4fd43c1`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/4fd43c15b3cd9e9bf1bf4351fede7939ca5a2d61))
- [G2P-4572](https://openg2p.atlassian.net/browse/G2P-4572) Staff portal ui added to commons. ([`a6a7a07`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a6a7a079c0e55e529babca63b484509b969b0320))
- [G2P-4484](https://openg2p.atlassian.net/browse/G2P-4484) Few changes to configure for external Postgres. ([`74f8d1b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/74f8d1bd3d4e613a1e0a25233d4fbd0f5a9f7b70))
-  [G2P-4644](https://openg2p.atlassian.net/browse/G2P-4644) Audit manager added. ([`35f93f6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/35f93f6336095b2e7302b723c3e0f947857809fa))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Keycloak memory limit removed as it was crashing. ([`8865303`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/886530360087c75cc970a6787f66fa6ddcb457b8))
- [G2P-4644](https://openg2p.atlassian.net/browse/G2P-4644) Kafka production defaults added. ([`8dcc0d4`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/8dcc0d44291012083af170f5e619f4e424fb0773))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Resource constraints applied. ([`6597ee8`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6597ee8ffd3ab8acf50633a16429699c6c5e354c))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Logging saved search added as Default Log Dashboard. ([`17a6be9`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/17a6be98b102b18de598fc72c177a7a602968470))
- [G2P-4632](https://openg2p.atlassian.net/browse/G2P-4632) App Ids added. ([`13e60bd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/13e60bde40601d24741338c5f218ebfb044d098e))
- Minor update. ([`aae40f2`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/aae40f2c91cad844225e035145e385a649b35a6f))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Further fixes for automatic index pattern creation. ([`cdfe5e6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cdfe5e680288b24f13a0837670d2a278cb2695c5))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Fixed permission issues in opensearch dashboards. ([`2fedeb7`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2fedeb7fff66966d70dcd42b5367c930399d3f28))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) resources put back in Keycloak. ([`6ead39b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6ead39b960d0489f4dfabc5201bdec5a19f1b1a6))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Cache removed. ([`202dd5e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/202dd5ec86037ec47e439ddca52e0074e2732f92))
- Keyclaok cache disabled - as there are issues pods coming up. ([`3ab9d4e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/3ab9d4e40bd438c77161ed850e9f17cdc58e14eb))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Resources removed as things are not working. ([`ab08df9`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ab08df970ef24bcc44e26c91d330cb17b7372503))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Memories increased. ([`7513da7`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7513da770cda1b6d3e76f5330ba70bfea2cc999b))
-  [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Memory constraint removed from Keycloak - it is creating problems. ([`695def5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/695def5b47911cf9e0aebcf6f1fd8e45a6857d9f))
-  [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Keycloak memory increased as it was giving OOM. ([`37baddf`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/37baddf831231faf43e4cd7bc2d514513364e591))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Keycloak issue fixed due to Java append. ([`980b71b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/980b71b3395a4c7f68caccf854d122297d2ff367))
- [G2P-4616](https://openg2p.atlassian.net/browse/G2P-4616) Resource contraints added. ([`cc88917`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cc88917adb83b7b93daf31d8e341c1a5fd52e336))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Loging dashboard replaced by just saved search as that is more appropriate for logging than a dashboard. ([`09fdc9a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/09fdc9a116eb6c9137992031560f9b3aeaa6c7cf))
- [G2P-4613](https://openg2p.atlassian.net/browse/G2P-4613) Keycloak init version updated. ([`264876b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/264876b511a42c1eaa04f4472eeeb73ae4c66c0a))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Default logs dashboard added. ([`6900df5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6900df5dd2f2bf7ee28acd1d1a43454fea634b46))
-  [G2P-4610](https://openg2p.atlassian.net/browse/G2P-4610) First and last name added. Required to complete profile on Keycloak. ([`160df44`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/160df4477cad076b06bf08a2517230e5000b2079))
- [G2P-4610](https://openg2p.atlassian.net/browse/G2P-4610) Default admin user for staff realm created and assigned all roles. ([`757ae70`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/757ae70215ff5ee6569e45fd8dea4b8054caff93))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Reverted to develop version of master data chart. ([`a43457a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a43457a2f7f1d4265f3ab3e2b76b0ba6cb315923))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Log retention policy added. ([`2d85a85`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2d85a8582ad4d88541b01535eac8d9e78a87de2f))
- [G2P-4609](https://openg2p.atlassian.net/browse/G2P-4609) Logging enabled for a few services. ([`bf66bc6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/bf66bc66091c8a3e44a58872e6983f2a28f0693e))
-  [G2P-4468](https://openg2p.atlassian.net/browse/G2P-4468) Making sure dependencies are updated before installation. ([`c796998`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c796998e783e3df8f967e3754ed6f23ebd1bdcb4))
- Keycloak init version frozen. ([`c1cbe2d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c1cbe2dec967d826438393f7d9e863ca6198d464))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Master data version frozen. ([`9a7d66c`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9a7d66cf2d3cd7d23ccd29615dc55ac6cca4bd89))
-  [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Version of IAM updated ([`3d31994`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/3d31994140e9c6008456de9259c4459b8c6c875b))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Two separate virtual services were required for Minio - for API and console. Implemented. ([`7ebaebc`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7ebaebcff7001d0743e0270bec1fa46fadd18244))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) /api prefix added for MiniIO api access in virtual service. ([`b819a54`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/b819a54e4aa0a8641ca115a082e84727922a6795))
- [G2P-4477](https://openg2p.atlassian.net/browse/G2P-4477) Keycloak Docker always pulled fresh as it may change if we change themes. In production this needs to be reverted. ([`dfc1a47`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/dfc1a47f0fc220dad8f4ed3dbecc40638f1e2c8e))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Opensearsh dashboard start probe added for quick start up ([`e6ee899`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/e6ee89943920191c4ae469724ea5aa85099bf255))
- [G2P-4468](https://openg2p.atlassian.net/browse/G2P-4468) Bug in Redis url fixed ([`5bd8705`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/5bd8705621861ed886a900a0ceeeaf7597bfc4d5))
- [G2P-4468](https://openg2p.atlassian.net/browse/G2P-4468) Changes related to chages in IAM service deployment. ([`ba16f48`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ba16f48ff704589b1f03e1bbcc74447819a42cbd))
- [G2P-4477](https://openg2p.atlassian.net/browse/G2P-4477) Keycloak themes added. And Keycloak docker image updated. ([`2128ac7`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2128ac7845f252f09d9df0ef63d80b5188a5e06f))
- [G2P-4468](https://openg2p.atlassian.net/browse/G2P-4468) Keycloak client added ([`f630494`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/f6304945faf4cd33802708333229f5ff13fb3ce9))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) IAM docker changed ([`563728b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/563728b72324c854f7a9cb874c80447e7ca85019))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) IAM names corrected ([`862353c`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/862353cd6d459879f25d745949e036990d5c237b))
- [G2P-4453](https://openg2p.atlassian.net/browse/G2P-4453) Keycloak per environment. Any few bug fixes ([`6702ddc`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6702ddc52f0449b8538dfddcea5a41589c337e31))
- [G2P-4453](https://openg2p.atlassian.net/browse/G2P-4453) Keycloak per environment. ([`30fcc38`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/30fcc3879d4dafca2b7a4080ea817e204b506989))
- [G2P-4453](https://openg2p.atlassian.net/browse/G2P-4453) Keycloak per environment. WIP. ([`06bbda6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/06bbda669eb0bf212540ffbe868686f1d91a6490))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Duplicate specification of keycloak base url no longer required. ([`ce38587`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ce385877c6d33dcb9135b0b60bcaf75313ab0145))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) IAM service added. ([`10246b9`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/10246b9dbfef44ff769d197f629a132c99a7365c))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Cleanup. ([`0d53e47`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/0d53e47cc1e268650156180831d6433fc0fe81d0))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) MAJOR changes in Keycloak client creation. WIP. ([`86fd678`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/86fd678c3fffac9c6354ce7b6069986e6c94eadf))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Bugs related to Keycloak redirect url fixed ([`714d836`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/714d8360a9eabd9b9947f99c34e8b44a05e110e6))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Keycloak internal URL introduced as services are not able to connect keycloak with https as they are trying to verify the cert which is self signed in case of local deployment ([`d263a6a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/d263a6ac31db320c1b4484806ec227433651c2ed))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Fix attempt for Rancher running issue ([`23f894e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/23f894e49fd3f449b09988192656ef6f330e8675))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Fix attempt for Rancher running issue ([`8b45553`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/8b45553cf134322a9783d5b7c95edb21d07b4e77))
- Push trigger updated. ([`bc4c60d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/bc4c60d83a07196754c43a16d4dea1a1254cb251))
- 1.x branch removed as we don't want to modify it further. ([`0d8f497`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/0d8f497a0c7ed9d524a5980a59d239e1fa84112f))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) default names applied to fix installation issues ([`dd15767`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/dd157672da9bfe71d40c8b5d10b967a8459b7722))
- Push trigger enabled only for 1.x and 2.x ([`643f10d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/643f10dbe98290c768795b6fc7d1b13a6c694e68))
- [G2P-4390](https://openg2p.atlassian.net/browse/G2P-4390) Major restructuring. WIP. ([`fb63020`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/fb6302004c1fc46549a106a670d4bc2651e7c390))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Attempt to fix Rancher run issue ([`9c410bf`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9c410bfa102c89a9bc713ecc9131f3914ebda6ca))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) bug related to postgres-init fixed ([`a90ded3`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a90ded375a97509b9a5249f5570297b3c298e7f9))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Uninstall made 'cleaner'. ([`6e0bd01`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6e0bd0183c66a0c948ad0af400032a6106b11f42))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Minor doc ([`c103d69`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c103d69be31fafcdfa2ddccdfb6b4bec2d2fac59))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Chart version updated. ([`a3f0539`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a3f0539853c92364f61aa52b4e62c3237b5cb391))
-  [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) All resources deleted in uninstall irrespective of their keep/retain status ([`433e217`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/433e21740c57ae036bf51f5748babe01f1cb6016))
-  [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Keycloak init for creation of clients added. ([`6ac63e1`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/6ac63e1bb68f1ed47db0131186937de57c3374e4))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Plenty of sequencing issues. Got fixed. All pods come up after waiting for a while. ([`37c5366`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/37c5366b8a70e1b8f656d9d34c911b54c97b40f9))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Keycloak init for creation of clients added. Most services come up fine. But there are few failures with mock and esgignet. ([`ee74ecd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ee74ecd9a640438de4a168657c9782c5c937cafe))
-  [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Keycloak init for creation of clients added. ([`e99b202`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/e99b202f764f5be07cbc58c16e0f83f6c4c9684f))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Keycloak init for creation of clients added. ([`cb14d9e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cb14d9e00a211b544a51e7c7b84d5ab20ca66524))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Install/uninstall scripts added for convenience. ([`53530ab`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/53530ab5c451d8def64bb240222462664e23a5a8))
- [G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036) Clean up, improvements - hooks added. ([`0ed7a66`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/0ed7a664543d7aca605b2133b4e83a4c2101ae86))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Superset keycloak client secret added in questions.yaml as superset does not accept templates. ([`828e48b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/828e48b7843c56620e55f4181ace8eec41848a2c))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] questions.yaml issues fixed. pre-commit minor changes. ([`d9e519b`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/d9e519b0bc0546a86181c045a9037368404c6a3f))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Mock Identity init issue fixed. ([`86e57ce`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/86e57cef0ed4ece4eceb83ee73d025053aaae495))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Annotations added to master data postgres init. ([`10b8f0e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/10b8f0e62362c06c6a962aa085a0a40eec24f3e9))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Bug related to esignet upgrade fixed. ([`b99b65f`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/b99b65f8971567623b4b4b9f6e9f2bf24fa5de14))
- Update README.md ([`57b69de`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/57b69deb3e020269076725adb94f2b361cbdd3da))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Master data chart added. ([`06172b0`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/06172b040ba9c3fc9f6c945eb8599184f828b289))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] questions.yaml updated. ([`0734ae3`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/0734ae32f35828b3cbb4b4ee43167ad1809242e9))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Chart version updated. ([`3c4d988`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/3c4d9880d6fdc8320649738e573a9f0d8e3bddb0))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Pre-commit errors fixed. ([`fc8e1ef`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/fc8e1efc6340e5eadb6440fdf28a9a7ea29eb6ac))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] eSignet added. Redis auth added. All isntalls fine now. ([`8ff09df`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/8ff09dfbd6b9db2225e8bb3c7f8c42fe4e0a45b1))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] mock-identity-system enabled. Installs fine. ([`4cf2bb1`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/4cf2bb1fe7c621a819d38d9c078e799fccad35f5))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Superset installs fine. ([`712a85a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/712a85aa36690b0194ccdee72225fa8e18fe6937))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Superset bug fixed. WIP. ([`8d94fbc`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/8d94fbcdeeb2ca5d3d877d2b0cc9980ea62b101e))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Mock Identity System installs fine. ([`a4fa517`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a4fa517bda9c51bcd94ba004b6364591934b78b6))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Keygen enabled. ([`d2ac806`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/d2ac806bc0822f122418bd1bfb72fd603241a199))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Working version all the modules install fine. Keygen is disabled here. ([`8f4e99f`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/8f4e99f26d5961dc08424baebe61dcdbb7af6282))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Keymanager values updated. WIP. ([`01ab9f8`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/01ab9f8c642af58bca141839fb6180405fb40e9e))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Few more modules enabled. Install fine. ([`7e333be`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7e333be7dca470578af212f3573bef06b4fd0f89))
- [[G2P-4056](https://openg2p.atlassian.net/browse/G2P-4056)] Hardcoded secrets removed. ([`be834e7`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/be834e775e5e42c8344f56a1fdebb668857b44d2))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Enabled helm upgrade for ODK for first time installation. ([`3115495`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/31154958aad22e24aaef226521f8a55d54bbfe4b))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] ODK enabled. ([`917f651`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/917f651ac4e309f0753e1a43b06d99d801c45127))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] MinIO installs fine. ODK central made dependent on MinIO ([`b843991`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/b843991ee96aaba4275c45ab0facee8f0bd3088d))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Precommit bugs fixed. ([`cfdc3dd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cfdc3ddb7a52c3bc87c4ead8b12a5e79880d78d4))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Name bug fixed. ([`9a47496`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9a47496f7836e17aa4528f8e1d3e2955135fb4dd))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Postgres-init added. Cleanup. ([`24201b5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/24201b545499de9ad803b55dc0292a6063c6655d))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Few modules disabled for testing. Hardcoding of superset params. ([`0501131`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/050113149106e9c4c313f967f285f7a093aebc1d))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] questions.yaml updated in sync with values.yaml ([`4438a21`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/4438a21b0756442cd36524e88eb0c899f2734a6b))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Minor fixes. WIP. ([`9287e22`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/9287e22527fd2014baceb9f034be940170152c89))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Fixes. WIP. ([`613e22d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/613e22ddcb0ad6f46ff2f25d340d8c7273d61916))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Minor, few comments ([`a5ec66e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a5ec66eac298d5b93d61df9591c7fc61dd5132fe))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Single instance of Redis. WIP. ([`d72be59`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/d72be59a5f55f8f87cb855df66ef84d96b1dc001))
- [[G2P-3954](https://openg2p.atlassian.net/browse/G2P-3954)] Updated values.yaml file for ODK and Esignet JavaOpt changes. ([`ad4ec6f`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ad4ec6f9f1dd98d7785e6a3a5ae3301ec129977d))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Secret read in superset config. ([`f542770`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/f54277072a3a3454fc419008226edcaf56aca71c))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] WIP. ([`a1d65d5`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/a1d65d593c597074ba171c59aa3fb2cf5a6a522b))
-  [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] KafkaUI config updated for reaching from secret. ([`cf9dd23`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cf9dd23b4934a00b92691bd2a11aa4ef8041e9b2))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] WIP. ([`06d6aa9`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/06d6aa9effe098730702100800e6b1a5a3f32e46))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] WIP. ([`2c5d33a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2c5d33a889b6c2a72d82ef4857aee657af3ea4d4))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] WIP. ([`ca29880`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/ca2988026ff88a06228a4f309624b0e237eb222b))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Version updated. ([`c3fcb81`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c3fcb813a9d5b9383d90d2d2c955a1205c9a8059))
- Minor. ([`be1b86d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/be1b86d8c4bb51fb42f9468f053b225a0d631113))
- [[G2P-4036](https://openg2p.atlassian.net/browse/G2P-4036)] Chart added to Rancher catalogue. ([`98332eb`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/98332eb035aaac8a01d72051244bcd570f58327b))
- Minor edit. ([`62cd8aa`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/62cd8aa5cedd2b29d8a9b1b199c9e2a441ec6628))
- Minor edit. ([`02b29f6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/02b29f6503976cdb9241ba301408df77d78ef72b))
- Update README.md ([`1a3e07d`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/1a3e07db83392930d9d8b5ac35ba57bba1fc30ad))
- [[G2P-3267](https://openg2p.atlassian.net/browse/G2P-3267)] Updated values.yaml file to enable softhsm. ([`cc529bd`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/cc529bdca46a9b3d0136900c0c3ece4e53760f29))
- [[G2P-3267](https://openg2p.atlassian.net/browse/G2P-3267)] Updated dependencies verion for openg2p-commons. ([`386eb72`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/386eb72477fe9b3b3369d0aed4b5eb28d2e9c435))
- Fix end-of-file newline in questions.yaml ([`2094e52`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/2094e52e41c70f5c7542c06eba4e47f6039742a8))
- [[G2P-3267](https://openg2p.atlassian.net/browse/G2P-3267)] Updated dependencies verion for openg2p-commons. ([`5ac911a`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/5ac911a52110bd801821a0ff617057af2d961ad1))
- [[G2P-3267](https://openg2p.atlassian.net/browse/G2P-3267)] Updated dependencies verion for openg2p-commons. ([`aa5ce47`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/aa5ce476524142e9628ad59c7c08bd67ec1a914f))
- [[G2P-3267](https://openg2p.atlassian.net/browse/G2P-3267)] Added OpenG2P-commons Helm Charts in to openg2p-deployment-commons repo. ([`bf14317`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/bf14317de2261ad192ecdf1980711eeebd315002))
- Initial commit ([`04cc8c6`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/04cc8c6f16ae3132d62a9b80087c0cea81ce472d))

<a id="v-0-0-0-develop-171"></a>

## openg2p-commons-deployment — Unreleased (0.0.0-develop.171, 2026-07-17)

_commit `7c7dc4e` · baseline: release 2.1.0 · previous build 0.0.0-develop.170_
<!-- build:0.0.0-develop.171 revision:7c7dc4e948daf9de54034b41c703ed7d7719c448 -->

### Summary

_All changes since release 2.1.0:_

- PM and [G2P-5348](https://openg2p.atlassian.net/browse/G2P-5348) CM have been moved to Gitlab, with Helm charts now accessible from the Gitlab Helm repository.
- The DEFAULT_BRANCH is now passed to the changelog for better tracking of changes.

### New in this build (since 0.0.0-develop.170)

- PM moved to Gitlab. Charts referred from Gitlab Helm repo ([`7c7dc4e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7c7dc4e948daf9de54034b41c703ed7d7719c448))

### Since last release (2.1.0)

- PM moved to Gitlab. Charts referred from Gitlab Helm repo ([`7c7dc4e`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/7c7dc4e948daf9de54034b41c703ed7d7719c448))
- [G2P-5348](https://openg2p.atlassian.net/browse/G2P-5348) CM moved to Gitlab. New location of Helm charts now. ([`f5a12c1`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/f5a12c1029b149eeeb2f22a07e66e13a3a49cc38))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) commons: pass DEFAULT_BRANCH to changelog ([`c087528`](https://github.com/OpenG2P/openg2p-commons-deployment/commit/c08752886e9ab3fb12f193a04ba3a080efdf2a11))

