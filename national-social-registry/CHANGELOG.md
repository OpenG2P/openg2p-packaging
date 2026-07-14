# national-social-registry changelog

_Published automatically._

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.149`](#v-0-0-0-develop-149) | 2026-07-14 | develop |

<a id="v-0-0-0-develop-149"></a>

## national-social-registry — Unreleased (0.0.0-develop.149, 2026-07-14)

_commit `567ee10` · baseline: release the start_
<!-- build:0.0.0-develop.149 revision:567ee1075289b151f865bf6073769eacd3657eee -->

### Summary

_All changes since release the start:_

- AWE removed from the project; Commons AWE is now used instead.
- Registry staff portal UI Docker moved to the registry platform as it is a common component.
- Memory limits removed from the registry to prevent OOM issues.
- Docker images now run as a non-root user for enhanced security.
- Production hardening implemented, including fixed resource limits and a bug fix for HPA.
- Added CSRF validation configuration for staff-portal-api requests to enhance security.
- Sync operational role IAM permissions for register metadata API access to ensure proper access control.
- Added Redis configuration for staff-portal-api authentication to improve security.
- Updated Helm chart configuration to include imageBucketName for better resource management.
- Enhanced db-seed Docker image and scripts for improved data loading functionality.
- New versioning system implemented; version is now bumped with every change.
- Updated SQL seed data and templates for DCI and CRVSVC integration.
- Improved error handling in G2PCrvsVCIndividualCreateEnricherService for better reliability.
- Added new JSON templates for DCI response handling and individual mapping.
- Refactored validation functions and moved them to a dedicated utils module for better organization.
- Removed legacy logging to streamline the codebase.
- Fixed several issues related to recent changes to improve overall stability.
- Updated dependencies and Docker components to the latest versions for improved performance and security.
- Added IAM public URL configuration for Staff Portal UI to facilitate better integration.
- Enhanced geo data loading functionality in db-seed for improved data accuracy.
- Cleanup of CI migration leftovers in the farmer, including repointing documentation links.
- Refactored seed data scripts and updated individual records for consistency and accuracy.
- Removed unused verification permissions from payload.json to simplify access control.
- Updated Dockerfile to point to the correct openg2p-data repository and improve clarity in configurations.
- Fixed psycopg2 error to enhance database interaction reliability.
- Added support for multiple registries in an environment to improve flexibility.
- Improved JSON handling in load_sample_data.py for better data insertion.
- Updated language data seeding by adding new fields and removing obsolete ones for better data management.
- Fixed translations and UI schema seeding to ensure correct display and functionality.
- Enhanced the NSR extension with new register metadata, UI tabs, and scoring definitions for improved user experience.

### Since last release (the start)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Tidy CI-migration leftovers in farmer: drop dead develop.txt specs, repoint Chart.yaml comment and celery README to build-publish.yml/Dockerfile ([`567ee10`](https://github.com/OpenG2P/national-social-registry/commit/567ee1075289b151f865bf6073769eacd3657eee))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Production hardening. Resource limits fixed. HPA bug fixed. ([`4e42304`](https://github.com/OpenG2P/national-social-registry/commit/4e423044f4e8a04925dc185dbb17c5663118e2d8))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Dockers run as non-root user. ([`91faa75`](https://github.com/OpenG2P/national-social-registry/commit/91faa75d62c3b0dfcbf73f20fc5678df6d354db1))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Referring to develop branch of registry-platform. ([`59a6fc4`](https://github.com/OpenG2P/national-social-registry/commit/59a6fc4bfda91771710b999d6824dd05e3c71198))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Sync operational role IAM permissions for register metadata API access ([`684a525`](https://github.com/OpenG2P/national-social-registry/commit/684a52515db0ac19d0c923aae242b466b1ddd374))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`28f41ca`](https://github.com/OpenG2P/national-social-registry/commit/28f41ca25e37d5248b05fb397c98b529b5acd7f1))
- Add README file for NSR extension package ([`af20d0e`](https://github.com/OpenG2P/national-social-registry/commit/af20d0e0b825fc3e7340407c71e68e754200fabb))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Add IAM public URL configuration for Staff Portal UI ([`b0353ff`](https://github.com/OpenG2P/national-social-registry/commit/b0353ff6357ff5be6c1d07b8634e288980845d55))
- [G2P-5226](https://openg2p.atlassian.net/browse/G2P-5226) Add Redis configuration for staff-portal-api authentication ([`e0e17dd`](https://github.com/OpenG2P/national-social-registry/commit/e0e17ddcb7eebb985ae9c398207063530d906426))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Update AWE approver user password and add first/last names for new users in keycloak-init ([`8172226`](https://github.com/OpenG2P/national-social-registry/commit/817222695bd46d44933fdd9dc5516c26885b35ae))
- G2P5221 Add CSP configuration for profile/document images from MinIO ([`170641c`](https://github.com/OpenG2P/national-social-registry/commit/170641c44566d6a9a4f6cdbaa367a8d433621192))
- G2P5221 Add AWE_CALLBACK_CALLER_SERVICE to db-seed and update SQL template ([`33261b9`](https://github.com/OpenG2P/national-social-registry/commit/33261b99fc4bf88d95ba35783ff0ef38ee5dd564))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Remove unused verification permissions from payload.json ([`8d71596`](https://github.com/OpenG2P/national-social-registry/commit/8d7159654ce87defcd8d4c664285e734149c14bf))
- [G2P-5260](https://openg2p.atlassian.net/browse/G2P-5260) AWE removed from here. Commons AWE used. ([`87fb3a7`](https://github.com/OpenG2P/national-social-registry/commit/87fb3a76050d5d7ef45f3e900b0928074201a6b1))
- Helm develop versioning scheme added ([`4101859`](https://github.com/OpenG2P/national-social-registry/commit/410185987850f2b318b128f40749172ee6d138ec))
- Add geo data loading functionality to db-seed ([`3efa999`](https://github.com/OpenG2P/national-social-registry/commit/3efa9992e48906c39dcbe149d78788ca8f5d8260))
- [G2P-5246](https://openg2p.atlassian.net/browse/G2P-5246) refactor(models): rename record_name methods to intake_record_name ([`1d919c4`](https://github.com/OpenG2P/national-social-registry/commit/1d919c425ddc1e4eee74a47ccb8d8d755f31947c))
- [G2P-5211](https://openg2p.atlassian.net/browse/G2P-5211) refactor(services): remove keys from search text - cleaned up search text keys in multiple service classes ([`0b7c8e5`](https://github.com/OpenG2P/national-social-registry/commit/0b7c8e5eba843f4738f23fbd0bf462693e6f17ea))
- [G2P-5220](https://openg2p.atlassian.net/browse/G2P-5220) feat(pre_approve): implement pre-approval logic for change requests ([`2e5985a`](https://github.com/OpenG2P/national-social-registry/commit/2e5985afcc05967ae6c20bfdbbb95731bfc68954))
- [G2P-5220](https://openg2p.atlassian.net/browse/G2P-5220) refactor(utils): move validation functions to utils module ([`e9fb1af`](https://github.com/OpenG2P/national-social-registry/commit/e9fb1af7b24808dddea876090f173935da594cd8))
- Fix psycopg2 error ([`823ddac`](https://github.com/OpenG2P/national-social-registry/commit/823ddac3b7950a6f477e9f8acbd90648286dfc6d))
- [G2P-5216](https://openg2p.atlassian.net/browse/G2P-5216) refactor(domain_validation_utils): improve validation functions ([`6cbacba`](https://github.com/OpenG2P/national-social-registry/commit/6cbacbad98d5e062ca2261bcc34f605b7a7bfdd2))
- fix repo url ([`74fca48`](https://github.com/OpenG2P/national-social-registry/commit/74fca4896e23fd18e7f9cdedb798567399036e18))
- AWE version frozen. ([`1d6920d`](https://github.com/OpenG2P/national-social-registry/commit/1d6920dd611b6078ab03fb94628726caf45c0018))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`3aa2dcb`](https://github.com/OpenG2P/national-social-registry/commit/3aa2dcb98220727d502603f915b3f9f8fdcfb915))
- [G2P-5202](https://openg2p.atlassian.net/browse/G2P-5202) Bump dependencies and update image tags to latest versions ([`c8df6b0`](https://github.com/OpenG2P/national-social-registry/commit/c8df6b0b84fe816f977dd04d226c403df79ec1e6))
- postgres-init version changed to frozen version ([`50d79b8`](https://github.com/OpenG2P/national-social-registry/commit/50d79b8d6744b5c6c081ec87b3bac83be6657c88))
- Refactor seed data scripts and update individual records. Enhanced geo hierarchy handling in load_sample_data.py. Updated household assets and housing data with new records and modified existing entries. Adjusted individual disabilities and livelihoods data for consistency and accuracy. Improved land records with updated access and size information. ([`54b2950`](https://github.com/OpenG2P/national-social-registry/commit/54b29502aa12fc132147c7be33fa9f68cd8314f3))
- [G2P-5187](https://openg2p.atlassian.net/browse/G2P-5187) New versioning system. ([`25381d5`](https://github.com/OpenG2P/national-social-registry/commit/25381d5bef26f685862423cf29fe265da41f9375))
- [G2P-5187](https://openg2p.atlassian.net/browse/G2P-5187) Version bumped up everytime there is a change. ([`2af5a0d`](https://github.com/OpenG2P/national-social-registry/commit/2af5a0d5bda60cebbce6cb83d2ec1c88d956fc72))
- [G2P-5186](https://openg2p.atlassian.net/browse/G2P-5186) Duplicate database entries removed. AWE call back modified. ([`8b469df`](https://github.com/OpenG2P/national-social-registry/commit/8b469df2136d399a9d6a3386f5bd728b75b3f3d7))
- Version bumped up 'cause develop version wasn't getting updated (suspected) ([`d03ab55`](https://github.com/OpenG2P/national-social-registry/commit/d03ab5570e42970e497f628facbdb1dfba31b18d))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) IAM traces uninstalled with uninstall script. ([`d1d4bfb`](https://github.com/OpenG2P/national-social-registry/commit/d1d4bfb9d16f862b1acd383f8b069c9435f3a204))
- add outgest_applicable to seed data ([`92573d5`](https://github.com/OpenG2P/national-social-registry/commit/92573d58efe11cd5b23aa69338a3d6cf07302362))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Calling IAM end piont to register. ([`835d419`](https://github.com/OpenG2P/national-social-registry/commit/835d419946fc3403fac69892b455720ffda303aa))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) hardcoding removed. ([`055339b`](https://github.com/OpenG2P/national-social-registry/commit/055339bcf98ab6528b32feeee4753e2c3b4da7ef))
- exclude sections backed by a CORE_TABLE register for seeding queue table ([`c89e8ec`](https://github.com/OpenG2P/national-social-registry/commit/c89e8ecf78fad36b3f6b2db1f8841e80aa3c94d2))
- test openg2p-data ([`f915f91`](https://github.com/OpenG2P/national-social-registry/commit/f915f911f1c55746d15beab1850e8fe9fe48a205))
- Update MinIO bucket name references in values.yaml to match imageBucketName for correct URL resolution in partner and staff portal APIs. ([`baf1e1a`](https://github.com/OpenG2P/national-social-registry/commit/baf1e1a98bc659ad7e641c45a0158b6776a4888c))
- refactor nsr data seeding ([`7a2a34d`](https://github.com/OpenG2P/national-social-registry/commit/7a2a34d96451e20d8c756076395a2e5d9937660f))
- [G2P-5142](https://openg2p.atlassian.net/browse/G2P-5142) update language data seeding: add new field and remove obsolete field ([`3cf5039`](https://github.com/OpenG2P/national-social-registry/commit/3cf5039c4b2b8586fc9fcd9256621337f1545029))
- Postgres-init version corrected. ([`f0cf9d8`](https://github.com/OpenG2P/national-social-registry/commit/f0cf9d84c4e463ebc605134690e3e1b89310a26a))
- Cleanup ([`bbacd7a`](https://github.com/OpenG2P/national-social-registry/commit/bbacd7a97c4e10b8d65c24c68ceeb20460f5f4da))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) Support for multiple registries in an env. ([`1ae7e6b`](https://github.com/OpenG2P/national-social-registry/commit/1ae7e6b44b435e5a035dbc2b26a7c0111e2826cb))
- Removed limits to resources in Redis as it getting killed with OOM error. ([`3d12f5a`](https://github.com/OpenG2P/national-social-registry/commit/3d12f5ab8ae5a623e0758ecd4e9b4b86b5ad5771))
- Doc moved to Gitbook ([`41b9e4b`](https://github.com/OpenG2P/national-social-registry/commit/41b9e4b2284a3d12c8b97adf5e7f4c6424298f13))
- [G2P-5126](https://openg2p.atlassian.net/browse/G2P-5126) Legacy logging removed. ([`ca59162`](https://github.com/OpenG2P/national-social-registry/commit/ca59162fe43055575b9e9400c7ddc9c8ffcc655b))
- Several issues related to recent changes fixed. ([`62b78b3`](https://github.com/OpenG2P/national-social-registry/commit/62b78b374b9933d80474bcbdc0779f4caa8b4e95))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) Hardcoding of keycloak client removed. Similar such changes done such that multiple registries may be installed in a single namespace. ([`0bb3539`](https://github.com/OpenG2P/national-social-registry/commit/0bb35394aaf05a29c7a7e38cb0477d0ee0984332))
- [G2P-4924](https://openg2p.atlassian.net/browse/G2P-4924) Seed AWE approval policies ([`f5b1a58`](https://github.com/OpenG2P/national-social-registry/commit/f5b1a5867c7c31ff0c9630822385905f0f3d08a5))
- [G2P-5101](https://openg2p.atlassian.net/browse/G2P-5101) - Update Helm chart configuration to include imageBucketName ([`38a14f3`](https://github.com/OpenG2P/national-social-registry/commit/38a14f3d72db437f8c4eb3d1d77f0044b822ebb1))
- Update Dockerfile to point to the correct openg2p-data repository and update Helm chart configuration for DB seed options. Added support for loading sample images and updated descriptions for clarity. ([`f4114c4`](https://github.com/OpenG2P/national-social-registry/commit/f4114c4fe7c41dc24fd018a62a4322a20266697d))
- update docker to use 2.0 ([`2f42683`](https://github.com/OpenG2P/national-social-registry/commit/2f4268314cf0d80615f3e22570bbe296ff326b68))
- Update Dockerfile to COPY seed-data/ from extension instead of relying on cloned openg2p-data subfolder ([`1a0a714`](https://github.com/OpenG2P/national-social-registry/commit/1a0a714f41d28ab2daa151b9fa669951a7620fbe))
- temp branch ([`dc71256`](https://github.com/OpenG2P/national-social-registry/commit/dc71256538a698e70a95a2497518d995338d473e))
- Refactor JSON handling in load_sample_data.py for improved data insertion ([`b28caee`](https://github.com/OpenG2P/national-social-registry/commit/b28caee56d5b1033e1ef67b862eb68f9d8fd98a9))
- Update Dockerfile ([`b74f14d`](https://github.com/OpenG2P/national-social-registry/commit/b74f14da249b2672f02a835e6eeab9d484ad9323))
- [G2P-5009](https://openg2p.atlassian.net/browse/G2P-5009) feat(services): implement domain validation utilities and refactor validation methods across services ([`c5486e8`](https://github.com/OpenG2P/national-social-registry/commit/c5486e82990a68c13afbb9b3244670d24d1d073d))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Registry uninstall script added. ([`778f782`](https://github.com/OpenG2P/national-social-registry/commit/778f782d6285a6a5414785f2c11606e6857ec6e5))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Memory limits removed as there are causing OOM issues. ([`cf157d3`](https://github.com/OpenG2P/national-social-registry/commit/cf157d37e179d57b7a61b4422f88262ccaf9dbfb))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Helm chart made self sufficient. All contents copied from openg2p-registry-gen2-deployment. ([`77965b9`](https://github.com/OpenG2P/national-social-registry/commit/77965b95754406d27f3997217acf0384b32c16fb))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Registry staff portal UI docker moved to registry platform as it is a common one. ([`c0532fc`](https://github.com/OpenG2P/national-social-registry/commit/c0532fca1dfc821844334cd19dd6990cf5f5c157))
-  [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Fix for UI docker build. ([`4a70e65`](https://github.com/OpenG2P/national-social-registry/commit/4a70e65180a2c6b4bacb407b956d1e9d3f9876ab))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Fix for UI docker build. ([`efc5c4e`](https://github.com/OpenG2P/national-social-registry/commit/efc5c4ef592f28e00b489b40e502ac6d1dadbd6f))
- [G2P-5010](https://openg2p.atlassian.net/browse/G2P-5010) Reading all libs from registry-platform repo. ([`0c85580`](https://github.com/OpenG2P/national-social-registry/commit/0c855804f2b2ffa566cf250ed7bd0bb517a87d99))
- Enhance db-seed Docker image and scripts for improved data loading ([`bc3787d`](https://github.com/OpenG2P/national-social-registry/commit/bc3787da9a0e715b0c72412838e05e083f455f9e))
- [G2P-4933](https://openg2p.atlassian.net/browse/G2P-4933) feat: enhance db-seed Docker image to support Jinja template uploads ([`b3f5f17`](https://github.com/OpenG2P/national-social-registry/commit/b3f5f171f96e2a10536ef04235d948278d6e7002))
- [G2P-4933](https://openg2p.atlassian.net/browse/G2P-4933) feat: update SQL seed data and templates for DCI and CRVSVC integration ([`16e3d45`](https://github.com/OpenG2P/national-social-registry/commit/16e3d45d0086b6ec5f67f6b63451332fe3f8fe4a))
- feat: update dci-workshop.txt to include NSR extension path ([`cfeb1c1`](https://github.com/OpenG2P/national-social-registry/commit/cfeb1c12bc3977103409a2ec4379fd9eede6f616))
- [G2P-4761](https://openg2p.atlassian.net/browse/G2P-4761) feat: update SQL seed data for households with corrected household head names and improved data consistency ([`61e082c`](https://github.com/OpenG2P/national-social-registry/commit/61e082c7257504e1eacce17d41ee7645ce0266a4))
- [G2P-4761](https://openg2p.atlassian.net/browse/G2P-4761) feat: update SQL seed data for households and individuals ([`952ecb0`](https://github.com/OpenG2P/national-social-registry/commit/952ecb0d070ba691f2f86c3a006367adc2d2170b))
- [G2P-4761](https://openg2p.atlassian.net/browse/G2P-4761) feat: update SQL seed for configurations and sample data ([`c13ac08`](https://github.com/OpenG2P/national-social-registry/commit/c13ac08cf12046e79da524c9ebe4c326da2a95ee))
- feat: improve error handling in G2PCrvsVCIndividualCreateEnricherService ([`26c262a`](https://github.com/OpenG2P/national-social-registry/commit/26c262aa5262abe12d9d4290059a011fbe300e45))
- feat: enhance JSON template for CRVS individual data processing ([`28445a7`](https://github.com/OpenG2P/national-social-registry/commit/28445a7b6c6d54c86465d755673f0c78c948061d))
- feat: normalize CRVS envelope and enhance G2PCrvsVCIndividualCreateEnricherService ([`f884e6a`](https://github.com/OpenG2P/national-social-registry/commit/f884e6a1da74c0159b8b60fb047a669aa5eae2d0))
- [G2P-4807](https://openg2p.atlassian.net/browse/G2P-4807) feat: add G2PCrvsVCIndividualCreateEnricherService and update templates ([`0f01bac`](https://github.com/OpenG2P/national-social-registry/commit/0f01bac246fb67cd8677ab18e83759b10a51ba1b))
- [G2P-4807](https://openg2p.atlassian.net/browse/G2P-4807) feat: enhance G2PRegisterDomainServiceIndividual with post-ingest and post-approve methods ([`321f5be`](https://github.com/OpenG2P/national-social-registry/commit/321f5bef0d57714d0570e5ed31c7a5e09b8af7f3))
- [G2P-4818](https://openg2p.atlassian.net/browse/G2P-4818) Partner API develop version. ([`72067de`](https://github.com/OpenG2P/national-social-registry/commit/72067de1c83985c838adccbe28fa38739e19077b))
- [G2P-4813](https://openg2p.atlassian.net/browse/G2P-4813) Rancher installation issues fixed. ([`da38524`](https://github.com/OpenG2P/national-social-registry/commit/da38524fedafec77096135d34dc0f8f424f24aee))
- refactor: update JSON template keys for individual mapping in DCI response ([`ce55e3c`](https://github.com/OpenG2P/national-social-registry/commit/ce55e3c269630714996fd84a5b1e044e7054f7af))
- [G2P-4807](https://openg2p.atlassian.net/browse/G2P-4807) fix(dci-workshop): update iam-service version to v1.1.0 ([`c03ecbc`](https://github.com/OpenG2P/national-social-registry/commit/c03ecbc3a4d8d9ed008aa02f9d597f723a76969f))
- build: update dependencies for dci-workshop configuration ([`f1caaba`](https://github.com/OpenG2P/national-social-registry/commit/f1caaba043d7610f5a259b075d2b6e7a0b76af1f))
- [G2P-4807](https://openg2p.atlassian.net/browse/G2P-4807) feat: add dci-workshop configuration files for partner and staff portal APIs ([`5b150ae`](https://github.com/OpenG2P/national-social-registry/commit/5b150ae265f9e578c5b75a912db7ff2caed5c1ac))
- [G2P-4807](https://openg2p.atlassian.net/browse/G2P-4807) feat: add DCI response templates and enrichers for individual mapping ([`4a8c3ff`](https://github.com/OpenG2P/national-social-registry/commit/4a8c3ffc4c55fafbbd7f9f69b88f07305529fdc7))
- feat: add husband status fields to household model and schema ([`47d2ee9`](https://github.com/OpenG2P/national-social-registry/commit/47d2ee93fc05a7050d5576babe58fd23e5225cac))
- feat: add new JSON templates for DCI response handling and individual mapping ([`4314171`](https://github.com/OpenG2P/national-social-registry/commit/43141717b44662f6657fbc59837d8feb9139b471))
- feat: enhance NSR extension with new register metadata, UI tabs, and scoring definitions ([`0926951`](https://github.com/OpenG2P/national-social-registry/commit/092695147e620fe51600ee3dfa91bf6147fb7b38))
- feat: add JSON templates for DCI commons response and individual to DCI mapping ([`554b196`](https://github.com/OpenG2P/national-social-registry/commit/554b196e3ca1b47a3871c5a6127aac0098f153bc))
- feat: add G2PScoreComputeServicePoverty for weighted-sum poverty score computation ([`6407b58`](https://github.com/OpenG2P/national-social-registry/commit/6407b58481fc1d1b6d6c96f4892f2d04b18b73dc))
- refactor: replace payment-related enums with program-related enums in household and individual program models and schemas ([`4acfa75`](https://github.com/OpenG2P/national-social-registry/commit/4acfa75b426e841e185f6c6d57c58af7bdc30f29))
- Hardcoding of release name removed. ([`70f0e89`](https://github.com/OpenG2P/national-social-registry/commit/70f0e89a4f3a956f33b4fe67ef0e44d9e6904420))
- build(dockerfile): update dependency versions across multiple Docker components to v1.1.0 ([`e9cf332`](https://github.com/OpenG2P/national-social-registry/commit/e9cf332c1d20e620ac765cc014be3ceb583a8cff))
- refactor: update national social registry  extension and attributes ([`2381b21`](https://github.com/OpenG2P/national-social-registry/commit/2381b213d8563a333158501bab1bce2e98604819))
- Version updated. ([`5de12bb`](https://github.com/OpenG2P/national-social-registry/commit/5de12bb1438dadcf22bd383101cb0c53c40e19e3))
- [G2P-4644](https://openg2p.atlassian.net/browse/G2P-4644) Versions updated ([`cfe9698`](https://github.com/OpenG2P/national-social-registry/commit/cfe969824d8a488415b23f1fba0e1e2d919cb9ed))
- [G2P-4644](https://openg2p.atlassian.net/browse/G2P-4644) Versions updated. ([`9d200dd`](https://github.com/OpenG2P/national-social-registry/commit/9d200ddec72d88df1e894c400a9a264ffc2854af))
- [G2P-4644](https://openg2p.atlassian.net/browse/G2P-4644) Audit manager integrated (testing). ([`cd9ffa1`](https://github.com/OpenG2P/national-social-registry/commit/cd9ffa1d2d266521fcdebc692385b3cbcc6dffac))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Path bug in parse script fixed ([`7237eb0`](https://github.com/OpenG2P/national-social-registry/commit/7237eb00583314ec4631fe1231af9ed76a885b5c))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) lib versions updated ([`a2c4295`](https://github.com/OpenG2P/national-social-registry/commit/a2c42959b93ea43a33c7e00d04832e3218fadf25))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Lib versions updated. ([`413ff89`](https://github.com/OpenG2P/national-social-registry/commit/413ff89fb627ff94367553d7b94b2eeac05878af))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Issues fixed in meta data. ([`35a27dd`](https://github.com/OpenG2P/national-social-registry/commit/35a27dd700a2258e826ed689d547ab6b1a156eea))
-  [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Renaming. ([`26827af`](https://github.com/OpenG2P/national-social-registry/commit/26827af2eae5d15aee3e7e7e64b126743981947e))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Variables updated. ([`fc2d797`](https://github.com/OpenG2P/national-social-registry/commit/fc2d79750b81ffa1eb96b71bb0325884ad1b4954))
-  [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Fixed sql bugs. ([`01c654d`](https://github.com/OpenG2P/national-social-registry/commit/01c654d6e6b81b884720cbddfd946c660c7d8b16))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Few more additions. ([`f420b09`](https://github.com/OpenG2P/national-social-registry/commit/f420b09b8712893651b57630d51e454879e09c61))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Plenty of changes to align to original NSR. ([`a0c8b0f`](https://github.com/OpenG2P/national-social-registry/commit/a0c8b0fa74c63a5145117a16a0cb76cc46209962))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Helm publish trigger updated. ([`6a651b1`](https://github.com/OpenG2P/national-social-registry/commit/6a651b185e841fdb35a3dc2f9294bdfef3a45fb2))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Workflow triggers improved ([`cabf73a`](https://github.com/OpenG2P/national-social-registry/commit/cabf73a985617372344387a4fcad96046ad6f192))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Helm chart added. ([`ac0e531`](https://github.com/OpenG2P/national-social-registry/commit/ac0e53156e29630ceb2452d2b310eca8abb9a640))
-  [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Renaming of folder. Addition of db seer docker. ([`de8b8d4`](https://github.com/OpenG2P/national-social-registry/commit/de8b8d44c1cc112df97c80fec89485accb8e101f))
-  [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Minor ([`5ab3b5e`](https://github.com/OpenG2P/national-social-registry/commit/5ab3b5e75b943a8c5fa97d786657ead4ec584834))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Docker build scripts added. ([`06b9196`](https://github.com/OpenG2P/national-social-registry/commit/06b9196b6caa2fb0c9e261f832af7ecc0288355d))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Cleanup. ([`4f2f157`](https://github.com/OpenG2P/national-social-registry/commit/4f2f15777ac4b11ca57e7187874b4b3668da2f35))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Renaming. ([`2240576`](https://github.com/OpenG2P/national-social-registry/commit/2240576c5740ef4d64dda461b65c3bc172cc2364))
- [G2P-4635](https://openg2p.atlassian.net/browse/G2P-4635) Initial verison. WIP. ([`ae94976`](https://github.com/OpenG2P/national-social-registry/commit/ae94976963aa1918f29471e495438adcd492d7e0))
- Initial commit ([`c2126d7`](https://github.com/OpenG2P/national-social-registry/commit/c2126d7e3adbd68af0bdbf579b67cb53cfd8ae49))

