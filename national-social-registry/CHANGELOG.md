# national-social-registry

_Published automatically._

**Repository:** [github.com/OpenG2P/national-social-registry](https://github.com/OpenG2P/national-social-registry)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.213`](#v-0-0-0-develop-213) | 2026-08-03 | develop |
| [`0.0.0-develop.211`](#v-0-0-0-develop-211) | 2026-08-03 | develop |
| [`0.0.0-develop.209`](#v-0-0-0-develop-209) | 2026-08-03 | develop |
| [`0.0.0-develop.207`](#v-0-0-0-develop-207) | 2026-08-02 | develop |
| [`0.0.0-develop.205`](#v-0-0-0-develop-205) | 2026-08-02 | develop |
| [`0.0.0-develop.203`](#v-0-0-0-develop-203) | 2026-08-01 | develop |
| [`0.0.0-develop.194`](#v-0-0-0-develop-194) | 2026-07-30 | develop |
| [`0.0.0-develop.191`](#v-0-0-0-develop-191) | 2026-07-30 | develop |
| [`0.0.0-develop.189`](#v-0-0-0-develop-189) | 2026-07-30 | develop |
| [`0.0.0-develop.188`](#v-0-0-0-develop-188) | 2026-07-29 | develop |
| [`1.0.1`](#v-1-0-1) | 2026-07-25 | release |
| [`1.0.0`](#v-1-0-0) | 2026-07-25 | release |

# Releases

<a id="v-1-0-1"></a>

## national-social-registry 1.0.1 — 2026-07-25

<!-- build:1.0.1 revision:32bc8b9bd5f21ef13041c1400dda87be2072f0e2 ts:1784945171 -->

_commit `32bc8b9` · changes since release 1.0.0_

### Release notes

Intermediate stable version; Just update of RP version; compatible with openg2p-commons 0.0.0-develop.182

### Summary

- Version update: bumped RP version to the latest release.

### Changes

- Bumped up RP version. ([`32bc8b9`](https://github.com/OpenG2P/national-social-registry/commit/32bc8b9bd5f21ef13041c1400dda87be2072f0e2))

<a id="v-1-0-0"></a>

## national-social-registry 1.0.0 — 2026-07-25

<!-- build:1.0.0 revision:ddfda05a04784413bccfefeb7a635d86ebb709bc ts:1784886289 -->

_commit `ddfda05` · first release_

### Summary

- **Major:** Refactored NSR as a thin extension, replacing the self-sufficient chart with an openg2p-nsr wrapper, and updated Dockerfiles to use platform images while dropping unnecessary machinery.
- Tooling enhancements: Introduced `bump-rp-version.sh` for atomic updates of the openg2p-registry pin across Dockerfiles and Helm charts, along with a CI lockstep guard to ensure consistency.
- Database updates: Adjusted NSR db-seed scripts for the v1.1.0 document refactor, including renaming fields and restoring loaders to prevent crashes against the schema.
- Security improvements: Added CSRF validation for staff-portal-api requests and configured IAM permissions for register metadata API access.
- CI/CD updates: Improved Helm chart configurations, including versioning schemes and dependency updates, while enhancing the Docker build process for better data loading and error handling.
- Feature additions: Implemented pre-approval logic for change requests, enhanced DCI response handling, and added new scoring definitions for poverty metrics.
- Cleanup and refactoring: Removed hardcoded values, legacy logging, and unused permissions, while improving validation functions and JSON handling across various services.

### Changes

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Tooling: add scripts/bump-rp-version.sh (with -n dry-run and -h help) to move the openg2p-registry pin — Dockerfiles + chart dependency together — to the latest version published in BOTH the Helm index and Docker Hub, plus a CI lockstep guard (test/test_rp_pin_lockstep.py + checks.yml) that fails the build if the pins ever split ([`ddfda05`](https://github.com/OpenG2P/national-social-registry/commit/ddfda05a04784413bccfefeb7a635d86ebb709bc))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Tooling: add scripts/bump-rp-version.sh to move the openg2p-registry pin (Dockerfiles + chart dependency) atomically to the latest version published in both the Helm index and Docker Hub, plus a CI lockstep guard (test/test_rp_pin_lockstep.py + checks.yml) that fails the build if the pins ever split ([`e099711`](https://github.com/OpenG2P/national-social-registry/commit/e09971118daa5813188065667008de78fb5924d0))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Bump openg2p-registry pin to 0.0.0-develop.295 in all Dockerfiles and the chart dependency (kept in lockstep) ([`7294267`](https://github.com/OpenG2P/national-social-registry/commit/72942673f747074b7ad42670887e40a6f25d2561))
- Bumped up registry platform version. ([`fadeb93`](https://github.com/OpenG2P/national-social-registry/commit/fadeb930499679d144cacc7980cf3e250508602e))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: retry a DCI search only when a dependency returns 5xx (e.g. Consent Manager stale-connection 500) — a genuine policy denial is never retried, so fail-closed behaviour is still asserted ([`4138fb2`](https://github.com/OpenG2P/national-social-registry/commit/4138fb2df13747d7b58fdbfc7edd1d859461a118))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) NSR sanity: keep the inherited fixture symbol names (FARMER_*) and change only their values — sanity/dci.py is inherited and imports FARMER_FOUNDATIONAL_ID, so the rename broke all five e2e tests with AttributeError ([`f965ed5`](https://github.com/OpenG2P/national-social-registry/commit/f965ed504145b390c817cc8e64ed668b203da438))
- Registry platform version updated. ([`e3e331a`](https://github.com/OpenG2P/national-social-registry/commit/e3e331a9ec68e4e37d63e4657e3bf7f60926b3a9))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) NSR db-seed: update the restored loaders for the v1.1.0 document refactor — record_image_storage_id was renamed to record_image_document_id, which made load_sample_data.py fail on g2p_register_individuals and g2p_register_households; verified against the live schema and by running both loaders in-cluster ([`a5634a1`](https://github.com/OpenG2P/national-social-registry/commit/a5634a16993f77cc3411bbf0f0ac65b669fccf73))
- [G2P-5380](https://openg2p.atlassian.net/browse/G2P-5380) refactor(sql): update SQL insert statements for templates ([`ebfab89`](https://github.com/OpenG2P/national-social-registry/commit/ebfab8973ec7fa997925a7914728ed84a5ad6e06))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) NSR db-seed fix: restore NSR's own load_sample_data.py and upload_images.py — the platform base image's copies are farmer-shaped (g2p_register_farmers, farmers.json) and crash-loop against NSR's Individual/Household schema; copy them over the inherited ones in the thin Dockerfile ([`d086d55`](https://github.com/OpenG2P/national-social-registry/commit/d086d55cf164849e2ee2ca92df69c0f90f0b43b7))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) NSR sanity: add the NSR field-specific test set (Set 2) and openg2p-nsr-sanity-tests image FROM the platform sanity image, wire it into CI and the chart, and align the RP_VERSION pins with the chart dependency at 0.0.0-develop.288 ([`d0d7d4c`](https://github.com/OpenG2P/national-social-registry/commit/d0d7d4c7b72e0bbf7eea1e6c001de2c50aad36ee))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) NSR as thin extension: replace the self-sufficient chart with an openg2p-nsr wrapper (openg2p-registry dep pinned 0.0.0-develop.288 + inherited Rancher questions), make dockers thin FROM the platform images with Option C, drop the inherited db-seed/celery machinery, and reuse the platform sanity image unchanged (NSR fields match the reference registry) ([`614b938`](https://github.com/OpenG2P/national-social-registry/commit/614b9383f3c7086b4d61e77d20f5ec32eaa1d90e))
- [G2P-5380](https://openg2p.atlassian.net/browse/G2P-5380) feat(sql): add contributing attributes and definitions for poverty score ([`6a0d14b`](https://github.com/OpenG2P/national-social-registry/commit/6a0d14b4504f68f035d53f827fe4d18c26c9c18d))
- [G2P-5348](https://openg2p.atlassian.net/browse/G2P-5348) id-generator moved to Gitlab. Changed the reference in Chart.yaml ([`a946c73`](https://github.com/OpenG2P/national-social-registry/commit/a946c73a4ef76fdf9bbafbd11cef0cd69fb93ca6))
- [G2P-5333](https://openg2p.atlassian.net/browse/G2P-5333) Update permission-to-role mappings ([`6625efa`](https://github.com/OpenG2P/national-social-registry/commit/6625efad9620e1ddcaf8855b417591c8f8f2a001))
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
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207): update SQL insert statements for g2p_register_sections ([`fd6bf84`](https://github.com/OpenG2P/national-social-registry/commit/fd6bf8450f11976ef4178499fda193a1c87cdb1b))
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

# Develop builds

<a id="v-0-0-0-develop-213"></a>

## national-social-registry — develop 0.0.0-develop.213 (2026-08-03)

_commit `378189f` · changes since 0.0.0-develop.211_
<!-- build:0.0.0-develop.213 revision:378189f8952e11e039624ce7b197c2ea823ea173 ts:1785763422 -->

### Summary

- Dashboard import functionality: Resolved issues with unattended dashboard imports by sourcing the Superset bootstrap script in the import Job, ensuring proper authentication handling and preventing failures during the import process.
- Configuration management: Improved the handling of Superset's configuration by correctly mounting the necessary files, allowing for successful execution of the import Job without encountering missing dependencies. 
- Error handling: Implemented checks for database connection issues post-import, enhancing the robustness of the import process and providing clearer feedback on failures.

### Changes since 0.0.0-develop.211

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Make the dashboard import work unattended. It never ran: the Job uses the stock Superset image but mounts the deployed config, which sets AUTH_TYPE = AUTH_OAUTH, so flask-appbuilder imported authlib and died in create_app — the bootstrap script that installs it was in the mounted Secret but the volume projected only superset_config.py. It also had no gate on Superset, which is a different Helm release, so a restart failed the whole import; published and embedded every dashboard in a shared Superset rather than its own; capped embedding at a fixed page; and raised on a missing database connection after the import had already succeeded. ([`378189f`](https://github.com/OpenG2P/national-social-registry/commit/378189f8952e11e039624ce7b197c2ea823ea173))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Source Superset's bootstrap script in the dashboard-import Job. The Job runs the stock apache/superset image but mounts the deployed Superset's config, which sets AUTH_TYPE = AUTH_OAUTH — so flask-appbuilder imports authlib while building the security manager and the stock image does not ship it. Every run died in create_app before importing anything. The bootstrap script that installs it was already in the mounted Secret, but the volume projected only superset_config.py, so it never reached the pod. ([`97ce577`](https://github.com/OpenG2P/national-social-registry/commit/97ce577281d72123d3c17cac4b386ce183f6962e))

<a id="v-0-0-0-develop-211"></a>

## national-social-registry — develop 0.0.0-develop.211 (2026-08-03)

_commit `491374e` · changes since 0.0.0-develop.209_
<!-- build:0.0.0-develop.211 revision:491374e25ac6968e01c2a764206d76796077f354 ts:1785747498 -->

### Summary

- **Major:** Migration updates for maps content, including new SQL sources for level summaries and quintiles to support poverty score plotting.
- Docker enhancements: pinned the maps base image to a published tag to prevent CI build failures and ensured ownership of maps content by eliminating shared Superset Secret conflicts.
- CI improvements: streamlined the installation process by addressing Helm release conflicts, allowing for successful rendering of the maps chart only when the Superset Secret is absent.
- New files added to support maps functionality, including Dockerfile and SQL source files for data processing.

### Changes since 0.0.0-develop.209

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Pin the maps base image to a published tag. The ARG defaulted to 0.0.0-develop, which CI never publishes — it produces 0.0.0-develop.<n> and develop — so the build failed on the pull. Pinned the way the db-seed image pins its registry-platform base. ([`491374e`](https://github.com/OpenG2P/national-social-registry/commit/491374e25ac6968e01c2a764206d76796077f354))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Own the maps content, and stop the shared Superset Secret blocking an install. The queries read nsr_rpt_* and plot a poverty score, none of which exists in another registry, so they belong here — shipped as an image built FROM openg2p-insights-evidence-builder, the same split as db-seed. Separately, both this chart and Insights declared the Superset service-account Secret, and Helm will not adopt another release's object, so whichever installed second failed; it now renders only when absent. ([`ab0580b`](https://github.com/OpenG2P/national-social-registry/commit/ab0580b553ef8c4012f03e09907ef9baf875f8a5))

<a id="v-0-0-0-develop-209"></a>

## national-social-registry — develop 0.0.0-develop.209 (2026-08-03)

_commit `7463cd0` · changes since 0.0.0-develop.207_
<!-- build:0.0.0-develop.209 revision:7463cd0f7cdc1c469013a4d6aa1a706bdb913296 ts:1785718419 -->

### Summary

- **Major:** Upgraded RP version to 0.0.0-develop.339, introducing significant changes.
- Authentication enhancement: Superset service-account password is now auto-generated, streamlining access to the REST API and preventing dashboard accessibility issues during upgrades.

### Changes since 0.0.0-develop.207

- Bumped up RP version to 0.0.0-develop.339 ([`7463cd0`](https://github.com/OpenG2P/national-social-registry/commit/7463cd0f7cdc1c469013a4d6aa1a706bdb913296))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Generate the Superset service-account password instead of asking for one. It authenticates a machine to Superset's REST API via provider=db and is never seen by a human, so requiring an operator to invent one only added a step to forget — and forgetting it left the dashboards imported but unreachable from Insights. Adopted rather than regenerated on upgrade, and the Insights chart renders the same Secret name and key, so whichever installs first creates it and the other picks it up. ([`1e62982`](https://github.com/OpenG2P/national-social-registry/commit/1e62982a3931add69414b4c6ec0d3645a0d6f0b6))

<a id="v-0-0-0-develop-207"></a>

## national-social-registry — develop 0.0.0-develop.207 (2026-08-02)

_commit `4329f3e` · changes since 0.0.0-develop.205_
<!-- build:0.0.0-develop.207 revision:4329f3e4a6f71e47b984e3b568f5e4d113ed140f ts:1785676162 -->

### Summary

- Data integrity improvements: filtered housing ladder values to match defined registry codes, ensuring only valid entries are emitted and correcting the head of household identification to use the appropriate role.
- Bug fix: resolved a critical use-before-define error that prevented the bulk sample job from starting, ensuring proper execution of the script.
- Docker updates: modifications made to the Docker configuration, enhancing the build process and environment setup.

### Changes since 0.0.0-develop.205

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Generate only values this registry's code lists contain, and find the head of household by role. The housing ladders emitted TRADITIONAL_HUT, APARTMENT and IRON_SHEET, none of which any list defines — no foreign key to catch it, so they landed as codes nothing resolves and charts grouped by them showed categories that do not exist. Lists are now filtered against g2p_attribute_values, not replaced by it: their order is the deprivation gradient deprived_pick reads, which a code list's display order does not carry. Head of household was RELATIONSHIPS[0], correct only while a country used SELF in that slot; it now asks for the head_of_household role. Values the registry defines but this script never emits are reported rather than injected. ([`4329f3e`](https://github.com/OpenG2P/national-social-registry/commit/4329f3e4a6f71e47b984e3b568f5e4d113ed140f))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Fix a use-before-define that stopped the bulk sample job from starting. DISPLACEMENT and PASTORALIST were read by names_and_weights two lines above their assignment, at module level, so the script raised NameError on import and the job never ran. Introduced when those lists were moved below their use. ([`20a10ea`](https://github.com/OpenG2P/national-social-registry/commit/20a10ea106eb705e7097042b776db73341b96ec8))

<a id="v-0-0-0-develop-205"></a>

## national-social-registry — develop 0.0.0-develop.205 (2026-08-02)

_commit `36b9530` · changes since 0.0.0-develop.203_
<!-- build:0.0.0-develop.205 revision:36b953084900f014436823443271f4ef185811d7 ts:1785672871 -->

### Summary

- **Major:** Transitioned code-list dropdowns to read directly from the database, enabling dynamic updates via the registry's attribute table and API, while maintaining backward compatibility for installations without a country pack.
- Version bump to RP 0.0.0-develop.338, indicating ongoing development and potential upcoming features.
- Improved admin UI functionality by allowing edits to code lists directly in the portal, enhancing usability and flexibility.

### Changes since 0.0.0-develop.203

- Bumped up RP version to 0.0.0-develop.338 ([`36b9530`](https://github.com/OpenG2P/national-social-registry/commit/36b953084900f014436823443271f4ef185811d7))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Read code-list dropdowns from the database instead of the widget. Each widget carried its own option array, so the values could only be changed by a release — the registry's attribute table, its API and the admin UI all existed but nothing on the form consulted them, and editing a list in the portal changed nothing on screen. Widgets now name their list; the same values are seeded as rows, where a country pack replaces them at install and an admin can edit them. No value changed, so an install without a pack behaves as before. Yes/no toggles stay static — a boolean is not a code list. ([`2251acf`](https://github.com/OpenG2P/national-social-registry/commit/2251acfc5820b9eb057dcf623f2ef46416aa780b))

<a id="v-0-0-0-develop-203"></a>

## national-social-registry — develop 0.0.0-develop.203 (2026-08-01)

_commit `31fb59f` · changes since 0.0.0-develop.194_
<!-- build:0.0.0-develop.203 revision:31fb59fd8202e6f33bf0cb8ac22596cca6bc5303 ts:1785577135 -->

### Summary

- **Major:** Configuration overhaul for Superset integration: added environment variable wiring, ensured proper database connection instead of SQLite, and enabled REST API embedding for dashboard rendering.
- Data loading improvements: fixed sub-table fixture associations to prevent orphaned data, updated the sample loader to support Master Data paths, and aligned reporting views with updated enums to eliminate invalid values.
- Enhanced reporting clarity: updated NA labels for better self-explanation in charts and individual reporting views, ensuring null values are clearly marked to avoid misinterpretation as missing data.
- Service account enhancements: replaced randomly generated passwords with a consistent secret for Superset access, ensuring machine clients can reliably connect to the Superset API.

### Changes since 0.0.0-develop.194

- Bumped up RP version to 0.0.0-develop.336 ([`31fb59f`](https://github.com/OpenG2P/national-social-registry/commit/31fb59fd8202e6f33bf0cb8ac22596cca6bc5303))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Attach the sub-table fixtures to whoever was actually loaded — same fix as the platform loader, which NSR overrides with its own copy. Its ten sub-tables all link to the demography CSV's id space, so on a country pack every livelihood, shock, asset and housing row orphaned silently. ([`6f425c4`](https://github.com/OpenG2P/national-social-registry/commit/6f425c4bb0e734a8eac0d1b46aa21fe6510d9cc7))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Take the country out of NSR's sample loader and turn on the Master Data path. NSR overrides the platform's load_sample_data.py with its own copy, so the country-agnostic fix did not reach it and it would fail on any pack that is not five levels called country..village — Ethiopia has four, ending at woreda. People and their whole ancestry now come from Master Data, CSV as fallback. Chart enables loadAttributes and syncGeoWidgets, both of which take whatever pack the environment loaded. ([`99c07eb`](https://github.com/OpenG2P/national-social-registry/commit/99c07eb8cdda41c562e8fc2981f72e2972aba3a0))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Make the NA labels self-explanatory — "NA (not working age)", "NA (under 5)", "NA (no ID)". The chart description carrying that explanation only renders on a dashboard when the chart is in the dashboard's expanded_slices metadata, so it was invisible; the label shows on the axis itself. ([`91d7ae7`](https://github.com/OpenG2P/national-social-registry/commit/91d7ae7cab1f03c9d70852377f7f1b8572e7f269))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Label not-applicable nulls as NA in the individual reporting view — employment_status and primary_livelihood are null for every under-5 and school-age child, education_level for every under-5, secondary_livelihood for the 84% with one, fid_verification_status for the half with no ID. Superset rendered these as "null", reading as missing data. Derived booleans still test the raw column, so their meaning is unchanged. ([`07f18a6`](https://github.com/OpenG2P/national-social-registry/commit/07f18a6b7f5e1e92da2779bba44b718d023e63a8))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Align the NSR sample generator and reporting views to the extension's enums. [G2P-5412](https://openg2p.atlassian.net/browse/G2P-5412)'s ProgramEnum rework dropped URBAN_PSNP and DIRECT_SUPPORT, which the generator still wrote; checking that surfaced nine more invalid values predating it (HEAD vs SELF, SETTLED vs HOST_COMMUNITY, the pastoralist/tenure/water/sanitation/lighting/cooking ladders, age_method, citizenship, identity evidence). These are String columns so invalid values inserted silently. The views hardcoded the same invented names, so fixing the generator alone would have made is_head false for every household and is_displaced true for all of them — both sides moved together. Views must be re-applied, not refreshed. ([`804b823`](https://github.com/OpenG2P/national-social-registry/commit/804b82325cda9381d501bb438af940c7fbeeb6b2))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Give the dashboards job Superset's own configuration. It ran Superset's CLI and ORM with no config, so Superset fell back to a SQLite file in the job's pod: the service account and all 8 dashboards were imported into a throwaway database and the job exited 0, leaving the real Superset empty. Adds envFrom/config-secret wiring, an abort if the metadata DB still resolves to sqlite, and enables embedding over the REST API so Insights can actually render the imported dashboards. ([`a0c1b72`](https://github.com/OpenG2P/national-social-registry/commit/a0c1b720f25872151c34b7802142a9709d581eef))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Make the Superset service account usable by machine clients: supersetAdminPasswordSecret replaces the random password the dashboards job generated and discarded, converging the account onto the Secret on each run. Under AUTH_OAUTH provider=db is the only way G2P Insights can reach the Superset API, so a thrown-away password locked it out permanently. ([`14d6269`](https://github.com/OpenG2P/national-social-registry/commit/14d62695fce2468e56ff71e679b53989f7ae7d91))

<a id="v-0-0-0-develop-194"></a>

## national-social-registry — develop 0.0.0-develop.194 (2026-07-30)

_commit `08a905f` · changes since 0.0.0-develop.191_
<!-- build:0.0.0-develop.194 revision:08a905f1e078c8abca9e263573da60346ef09ecf ts:1785399791 -->

### Summary

- Version updates: Increased RP version to 0.0.0-develop.316 across Dockerfiles for db-seed, sanity-tests, celery, partner-api, and staff-api, along with the Helm chart for openg2p-nsr.

### Changes since 0.0.0-develop.191

- Bumped up RP version to 0.0.0-develop.316 in Dockerfiles for db-seed and sanity-tests, and updated the version in the Helm chart for openg2p-nsr. ([`bee4bf7`](https://github.com/OpenG2P/national-social-registry/commit/bee4bf7a6fd7b7c65e31f37d0f55589e577b6387))
- Bumped up RP version to 0.0.0-develop.316 in Dockerfiles for celery, partner-api, and staff-api. ([`072f431`](https://github.com/OpenG2P/national-social-registry/commit/072f431a0cf2a07e6385a95bea095b4142dc139f))

<a id="v-0-0-0-develop-191"></a>

## national-social-registry — develop 0.0.0-develop.191 (2026-07-30)

_commit `22bd74f` · changes since 0.0.0-develop.189_
<!-- build:0.0.0-develop.191 revision:22bd74f5b30f4f351227d7ec89d9b02c2be5bc3d ts:1785392656 -->

### Changes since 0.0.0-develop.189

- [G2P-5412](https://openg2p.atlassian.net/browse/G2P-5412) Refactor household and individual models by removing unused async methods for linking internal record IDs and cleaning up imports. This improves code clarity and maintainability across multiple model files. ([`c49a881`](https://github.com/OpenG2P/national-social-registry/commit/c49a8811bbb404ad4201ccacc96b7df9a49517ad))

<a id="v-0-0-0-develop-189"></a>

## national-social-registry — develop 0.0.0-develop.189 (2026-07-30)

_commit `76e2da2` · changes since 0.0.0-develop.188_
<!-- build:0.0.0-develop.189 revision:76e2da2d384e5e4867ec9a3e3be03c3007997312 ts:1785382413 -->

### Changes since 0.0.0-develop.188

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Raise the default bulk sample to 250k individuals, sized against Kamuntu's 668 villages so leaf-level percentages are reportable rather than suppressed. Clarify that expectedCountry is the root P-code (XK/ET), not the pack name. ([`76e2da2`](https://github.com/OpenG2P/national-social-registry/commit/76e2da2d384e5e4867ec9a3e3be03c3007997312))

<a id="v-0-0-0-develop-188"></a>

## national-social-registry — develop 0.0.0-develop.188 (2026-07-29)

_commit `36a87e2` · changes since 0.0.0-develop.185_
<!-- build:0.0.0-develop.188 revision:36a87e27db022365e32013bfa70833f2dc7be097 ts:1785304301 -->

### Summary

- Dashboard enhancements: implemented adhoc SQL COUNT(*) for improved chart metrics and dataset column validation, and automated service user creation during dashboard imports.
- Version update: bumped RP version to 0.0.0-develop.299.

### Changes since 0.0.0-develop.185

- Bumped up RP version 0.0.0-develop.299 ([`36a87e2`](https://github.com/OpenG2P/national-social-registry/commit/36a87e27db022365e32013bfa70833f2dc7be097))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Use adhoc SQL COUNT(*) in charts; make the dashboard import create its service user and replace stale charts. ([`d1862a8`](https://github.com/OpenG2P/national-social-registry/commit/d1862a82dd8a869e983f94c09732f05b780228d1))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Use an adhoc SQL COUNT(*) metric so charts pass dataset column validation. ([`b80cf1e`](https://github.com/OpenG2P/national-social-registry/commit/b80cf1e4037de7ed5e764a1d236ef42576962b1f))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 10 develop builds** and the **latest 10 release
> candidates** per release line. Older develop builds and release candidates
> are pruned as they are superseded, and a release's candidates are removed
> once it ships. Those versions still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
