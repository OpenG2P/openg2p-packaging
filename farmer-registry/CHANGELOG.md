# farmer-registry changelog

_Published automatically._

**Repository:** [github.com/OpenG2P/farmer-registry](https://github.com/OpenG2P/farmer-registry)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.104`](#v-0-0-0-develop-104) | 2026-07-18 | develop |
| [`0.0.0-develop.103`](#v-0-0-0-develop-103) | 2026-07-18 | develop |
| [`0.0.0-develop.102`](#v-0-0-0-develop-102) | 2026-07-18 | develop |

# Develop builds

<a id="v-0-0-0-develop-104"></a>

## farmer-registry — develop 0.0.0-develop.104 (2026-07-18)

_commit `3ef95ed` · baseline: release the start · previous build 0.0.0-develop.103_
<!-- build:0.0.0-develop.104 revision:3ef95eddd980976f198bc3594a288076eb02038b ts:1784354861 -->

### Summary

_All changes since release the start:_

- Fail closed by default: partner signature validation and consent enforcement are now enabled, aligning with registry platform defaults.
- AWE removed from the project; Commons AWE is now used instead.
- IAM service repository renamed from `openg2p-iam-service` to `iam-service`.
- Major update to the sanity e2e test suite, now including two power e2e tests.
- Added CSRF validation configuration for staff-portal-api requests to enhance security.
- Enhanced data seeding scripts to include geo reference data in the master_data database.
- Updated SQL data models and templates for farmer extension, including modifications to incoming model semantic patterns.
- Updated dependencies and image tags to the latest versions, ensuring compatibility and security.
- Consolidated helm chart with dockers built using libraries from the registry-platform.
- Added Redis configuration for staff-portal-api authentication to improve performance.
- Updated AWE approver user password and added first/last names for new users in keycloak-init.
- Updated SQL seed data for farmer intake forms and templates to support new features.
- Enhanced Docker setup for template uploads, improving deployment efficiency.
- Updated the versioning convention to '0.0.0-develop.N' for better clarity in development.
- Fixed sanity DCI e2e tests to ensure they pass on a live cluster by granting necessary permissions and adjusting polling mechanisms.
- Improved CI migration by dropping dead develop.txt specs and repointing documentation to relevant files.
- Updated the audit database wiring to ensure correct secret usage, preventing test failures.
- Added documentation for Farmer Registry sanity-testing, including flow diagrams and procedures.
- Enhanced performance testing suite added, still a work in progress.
- Fixed install-time 403 errors by adjusting the execution order of sanity tests and IAM role permissions.
- Updated the entrypoint to wait for staff-portal-api readiness, improving install-time reliability.
- Updated the Helm publish workflow to prevent race conditions during deployment.
- Removed unused verification permissions from payload.json to streamline the codebase.
- Updated the URL for Partner Management to align with commons-services.
- Updated the configuration for Staff Portal UI to version 1.1.0.
- Fixed various bugs related to Docker and database seeding to improve stability and performance.
- Updated the SQL data for farmer extension to reflect accurate types and counts in livestock records.
- Refactored internal record IDs for clarity and consistency across the application.
- Removed legacy logging and synced changes with the latest NSR for cleaner code.
- Updated Docker configurations to use the 'develop' branch for better version control.

### New in this build (since 0.0.0-develop.103)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity DCI e2e after change-request test: chart searchText must be the farmer's functional_record_id (SANITY-FARMER-0001), not the SANITYE2E marker — the CR approval regenerates search_text via the ORM and drops the manual marker, so a DCI search for it returns nothing; functional_record_id is a real search field and survives (reproduced and verified against live trial) ([`3ef95ed`](https://github.com/OpenG2P/farmer-registry/commit/3ef95eddd980976f198bc3594a288076eb02038b))

### Since last release (the start)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity DCI e2e after change-request test: chart searchText must be the farmer's functional_record_id (SANITY-FARMER-0001), not the SANITYE2E marker — the CR approval regenerates search_text via the ORM and drops the manual marker, so a DCI search for it returns nothing; functional_record_id is a real search field and survives (reproduced and verified against live trial) ([`3ef95ed`](https://github.com/OpenG2P/farmer-registry/commit/3ef95eddd980976f198bc3594a288076eb02038b))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity e2e install-time 403s: run the sanity test Job at hook-weight 25 so it executes AFTER iam-register (weight 20) pushes the registry's roles→permissions catalog to IAM — the change-request tests were running at weight 15, before IAM knew the registry roles, causing 'Insufficient resource_access roles' ([`540f176`](https://github.com/OpenG2P/farmer-registry/commit/540f1767d159309560970440cae7b4e794494698))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make sanity e2e survive install-time startup race: retry create_change_request on 403 (permission path warms up after staff-portal-api is reachable) with a fresh token up to authReadyTimeout=120s, and wait for staff-portal-api readiness in the entrypoint — the 4 CR tests were failing only because the Job ran ~2min into a fresh install. ([`345fc57`](https://github.com/OpenG2P/farmer-registry/commit/345fc579a35e7bb4d36c0f51b88e5685527cf78f))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity audit-DB wiring: auditDbSecret/key were audit-manager-db-user / audit-manager-db-user-password; the real Secret is audit-manager / audit-manager-db-user (as the auditmanager deployment mounts) — the in-cluster audit test would otherwise fail ([`e286919`](https://github.com/OpenG2P/farmer-registry/commit/e286919fca9c753c7dc3dd61f06d63b0307c9f1d))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make change-request e2e pass end-to-end on a live cluster: grant the sanity user AWE_ADMIN and approve every task on the request (shipped stages are mode='all' with demo approvers); poll for the async history row; key the audit assertion on actor_id (events carry no resource_id); add tab_id to get_number_of_versions; fix teardown to key on internal_record_id (CR/history are stamped with the display name) ([`14ec94c`](https://github.com/OpenG2P/farmer-registry/commit/14ec94c2ed2a4cd436ffec2f087e1833b6fd3ff3))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Docs: add Farmer Registry sanity-testing page (tests, DCI + change-request flow diagrams, seeding & markers, install packaging, run-local procedure, gates/e2e-off behavior, teardown); link from deployment README, helm-chart and SUMMARY ([`347f7bf`](https://github.com/OpenG2P/farmer-registry/commit/347f7bf4da3cf6c4b2214197e804737053acf106))
- Fail closed by default: enable partner signature validation and consent enforcement (matching the registry platform defaults, which the chart inverted); keep sanity e2e off by default; fix stale audit comment; record the consent/signature posture as a perf-testing variable ([`331ab43`](https://github.com/OpenG2P/farmer-registry/commit/331ab43be49d4f800bd6552fbbcabddfc1b45681))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) E2e sanity test suite added with 2 power e2e tests. ([`85b60d1`](https://github.com/OpenG2P/farmer-registry/commit/85b60d11a4628ec7a18322a21de3878a09ba940d))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Tidy CI-migration leftovers in farmer: drop dead develop.txt specs, repoint Chart.yaml comment and celery README to build-publish.yml/Dockerfile ([`6e15b11`](https://github.com/OpenG2P/farmer-registry/commit/6e15b117626e7c8abc678f71c3a3b87148c604b1))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Fix pin/build-arg repo mismatch: install iam-core from openg2p/iam-service (was openg2p-iam-service, which lacks the resolved SHA), and fetch openg2p-data by ref via git fetch+checkout so db-seed accepts a pinned commit SHA (git clone -b takes only a branch/tag name) ([`1f22275`](https://github.com/OpenG2P/farmer-registry/commit/1f22275da0bce42cb361e9792db8d45e9d31d044))
- IAM service repo renamed. ([`ce226a5`](https://github.com/OpenG2P/farmer-registry/commit/ce226a56f6bf9d282ca1c224d1c00fbf30b129ba))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Move to central build-publish CI; self-contained pinned Dockerfiles ([`84ad210`](https://github.com/OpenG2P/farmer-registry/commit/84ad2101e3f730e62dfb55b844f199e386b13ec8))
- [G2P-5342](https://openg2p.atlassian.net/browse/G2P-5342): Update develop.txt files to replace references to 'openg2p-iam-service' with 'iam-service' ([`8e68be8`](https://github.com/OpenG2P/farmer-registry/commit/8e68be8e828c4f135a333353a436e33d8105c8b4))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Production hardening. Resource limits fixed. HPA bug fixed. Dockers run as non-root. ([`41ea585`](https://github.com/OpenG2P/farmer-registry/commit/41ea5851217bf2b8e29b5ea9c03113ab967d629c))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Sync operational role IAM permissions for register metadata API access ([`e5c879b`](https://github.com/OpenG2P/farmer-registry/commit/e5c879b1c2cff372b2fcc14bbac53fb027f70834))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`5b00de3`](https://github.com/OpenG2P/farmer-registry/commit/5b00de3d9da0875353112159c0437877c8e753b1))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Add IAM public URL configuration for Staff Portal UI ([`97ec733`](https://github.com/OpenG2P/farmer-registry/commit/97ec7336b313921b73ef1293d7522e79ab958dc0))
- [G2P-5226](https://openg2p.atlassian.net/browse/G2P-5226) Add Redis configuration for staff-portal-api authentication ([`26383d9`](https://github.com/OpenG2P/farmer-registry/commit/26383d9f0e7753fa0686e1d1d7feb3bf3aa135c6))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Update AWE approver user password and add first/last names for new users in keycloak-init ([`9f768e0`](https://github.com/OpenG2P/farmer-registry/commit/9f768e0366be56a65bac49b3d6bb2da1b8aaba08))
- G2P5221 Add CSP configuration for profile/document images from MinIO ([`499f66a`](https://github.com/OpenG2P/farmer-registry/commit/499f66ad0e265499f137542bc1cfd53db8693c57))
- G2P5221 Add AWE_CALLBACK_CALLER_SERVICE to db-seed and update SQL template ([`9888832`](https://github.com/OpenG2P/farmer-registry/commit/9888832206278d1baea75aed1401b95175a94a9a))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Remove unused verification permissions from payload.json ([`53a2d5f`](https://github.com/OpenG2P/farmer-registry/commit/53a2d5fb8bc1f64dfde7cabba45e8193863d32af))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) URL of CM updated as it is not installed via commons-services. ([`3a76763`](https://github.com/OpenG2P/farmer-registry/commit/3a76763315a054d949ba23e8384cb4a3d3dd0638))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Harden helm-publish workflow against gh-pages push races: add concurrency group + rebase-pull before commit. ([`70c8859`](https://github.com/OpenG2P/farmer-registry/commit/70c88596ad1a9b87c4605fd1a62428e1840d3e6d))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`6da7b1c`](https://github.com/OpenG2P/farmer-registry/commit/6da7b1c8888ae07a6b48bbf4985cebd99652d35d))
-  [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299)  Url for PM updated. ([`724f07a`](https://github.com/OpenG2P/farmer-registry/commit/724f07a9c16239ad5a7c0ad971d9ece620f3b340))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) Ports corrected. ([`79a6cf2`](https://github.com/OpenG2P/farmer-registry/commit/79a6cf269d22c20ada488c1e09823075df46310f))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) questions.yaml updated. ([`b5ebd05`](https://github.com/OpenG2P/farmer-registry/commit/b5ebd0522e17a61f1666d46f7e8302f0791676cf))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sanity tests added. ([`d3d47bd`](https://github.com/OpenG2P/farmer-registry/commit/d3d47bd85fc15fbce068d03f095d8337cf7263bb))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancement for consent, partner management, WJS. ([`984d6a9`](https://github.com/OpenG2P/farmer-registry/commit/984d6a93d2317c936c9565607b59894cc61cd874))
- Versions updated to 'develop' ([`24a4f82`](https://github.com/OpenG2P/farmer-registry/commit/24a4f82147e1ea2e6e736968ad86c3fcf1f16ae3))
- Fix for db seed docker failing. ([`55a08c8`](https://github.com/OpenG2P/farmer-registry/commit/55a08c88d93c1840f9a5de53bc7c36be28cabdc7))
- [G2P-5260](https://openg2p.atlassian.net/browse/G2P-5260) AWE removed from here. Commons AWE used. ([`6b302cd`](https://github.com/OpenG2P/farmer-registry/commit/6b302cd1ccf4a54b9afe742c954f4eef54ac4a78))
- db-seed functionality: Added support for loading geo reference data into the master_data database. ([`7d9f06b`](https://github.com/OpenG2P/farmer-registry/commit/7d9f06b7f93350de0b6f0110578a379cde4b6b96))
- AWE version frozen. ([`9562666`](https://github.com/OpenG2P/farmer-registry/commit/95626664d8ec5e879f4a718589a8a7858e367b3c))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`057c447`](https://github.com/OpenG2P/farmer-registry/commit/057c447d82b1481216b9ebf2cd22f84828e9bc2f))
- [G2P-5202](https://openg2p.atlassian.net/browse/G2P-5202) Bump dependencies and update image tags to latest versions ([`7fdcded`](https://github.com/OpenG2P/farmer-registry/commit/7fdcded62d2089655064a34e551e983e1f2dfb95))
- postgres-init version changed to frozen version ([`42bb8eb`](https://github.com/OpenG2P/farmer-registry/commit/42bb8eba6c19d850a2aee9dd06dea030854f820a))
- [G2P-5187](https://openg2p.atlassian.net/browse/G2P-5187) Develop versioning updated with 0.0.0-develop.N convention ([`c5da4e7`](https://github.com/OpenG2P/farmer-registry/commit/c5da4e76859a54d47793a81547faaad67e41f447))
- Enhance data seeding scripts: Introduced geo hierarchy functions in load_sample_data.py, updated crop and farm input JSON files with new records and modified existing entries, and corrected link IDs in household members and lands JSON files. Adjusted livestock records to reflect accurate types and counts. Updated membership details with new member entries and corrected associations. ([`4f1f54f`](https://github.com/OpenG2P/farmer-registry/commit/4f1f54fd32d9f4ba9ad99c3e1534c0ea57dd4bfc))
- [G2P-5174](https://openg2p.atlassian.net/browse/G2P-5174) Performance test suit added. Still WIP. ([`0d881c9`](https://github.com/OpenG2P/farmer-registry/commit/0d881c9faf7ed5e1a207d5adcf2ad49257be57c0))
- [G2P-5186](https://openg2p.atlassian.net/browse/G2P-5186) Duplicate jobs with same name removed. ([`795d50f`](https://github.com/OpenG2P/farmer-registry/commit/795d50f281c6cfab686c25b9f571cc20ffe0e2e3))
- [G2P-4904](https://openg2p.atlassian.net/browse/G2P-4904) - Farmer data seeding ([`2e124bd`](https://github.com/OpenG2P/farmer-registry/commit/2e124bd979298447502a8c0aaf64bb61755ae56e))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) IAM traces removed with uninstall. ([`14d0804`](https://github.com/OpenG2P/farmer-registry/commit/14d08042bccd4323f5eb1d6dbcd32b6d9dfb38ef))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Calling IAM endpoint to register. ([`65f5f8b`](https://github.com/OpenG2P/farmer-registry/commit/65f5f8b48e8bc19ce65f7229c78068289ea086dc))
- [G2P-5142](https://openg2p.atlassian.net/browse/G2P-5142) update language data seeding: add new field and remove obsolete field ([`13ad7de`](https://github.com/OpenG2P/farmer-registry/commit/13ad7dea9bebfe5562dfca89d546f5767e412820))
- Postgres version corrected. ([`9f936f3`](https://github.com/OpenG2P/farmer-registry/commit/9f936f3bc99651e83fd1c79ff495be7f68295681))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) Changes in AWE configs such that multiple registries can be installed in an env. ([`097746f`](https://github.com/OpenG2P/farmer-registry/commit/097746f38c213d4f7165c3b5c65ad09af254196a))
- Readme cleaned up. ([`62cb828`](https://github.com/OpenG2P/farmer-registry/commit/62cb8285604c6945be9118423b278e2b80059eb7))
- Temp version to fix the harcoded chart name issue. ([`82d5288`](https://github.com/OpenG2P/farmer-registry/commit/82d52880b49ab91cf92aff102f9f3e613fd04d43))
- Version changed 0.0.1 as the previous issue is still there. ([`8533435`](https://github.com/OpenG2P/farmer-registry/commit/85334351785b9129cb9207be67c82495411e313f))
- Changed the version number to fix the problem of fixed chart name appearing while installing with Rancher. ([`3728628`](https://github.com/OpenG2P/farmer-registry/commit/372862881d8d303ad53a3bac825870dc2b4133d7))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Legacy logging removed, changes synced with latest NSR. ([`1a2fbac`](https://github.com/OpenG2P/farmer-registry/commit/1a2fbaca558d6f1f9548616cdf5a05359df43770))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Consolidated helm chart with dockers built using libs from registry-platform. Just like we did for NSR. ([`1b6b457`](https://github.com/OpenG2P/farmer-registry/commit/1b6b457ec6bf89016dcd183f105a9c5fb4d960be))
- [G2P-4924](https://openg2p.atlassian.net/browse/G2P-4924) Seed AWE approval policies for Farmer Registry ([`3134a03`](https://github.com/OpenG2P/farmer-registry/commit/3134a03dc3ac925c4b28e771bdc5b1f374b453ae))
- [G2P-5028](https://openg2p.atlassian.net/browse/G2P-5028) feat(services): implement domain validation utilities for various services ([`e79ad62`](https://github.com/OpenG2P/farmer-registry/commit/e79ad6217157667b9165ab50bcb580acc6276618))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(db-seed): enhance Docker setup for template uploads ([`0757a8f`](https://github.com/OpenG2P/farmer-registry/commit/0757a8f8e1c40e8a109a5b5cbedd61fdabddd150))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(data): update SQL data models and templates for farmer extension ([`92529eb`](https://github.com/OpenG2P/farmer-registry/commit/92529eb9ac452186cd511926513d40d7c7b827a4))
- refactor(data): update SQL data models and templates for farmer extension ([`1115ab1`](https://github.com/OpenG2P/farmer-registry/commit/1115ab1180ae43a47121657331bd1222629f5781))
- Update SQL data for farmer extension: modify incoming model semantic patterns and enhance g2p register scores ([`d61f6c8`](https://github.com/OpenG2P/farmer-registry/commit/d61f6c8548ad877a97c611a58248666b2aec62ac))
- fix(docker): update Staff Portal UI version in configuration file to 1.1.0 ([`4f2b43f`](https://github.com/OpenG2P/farmer-registry/commit/4f2b43f39a4acfc206d86f0c396da1968df5b1bf))
- build: add Docker configuration files for version 1.1.0 of Celery, Partner API, and Staff Portal API ([`4ac52dc`](https://github.com/OpenG2P/farmer-registry/commit/4ac52dcd7b89b249bc014a60576046a39e8b51a0))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(app): remove poverty score models from initialization process ([`94507ea`](https://github.com/OpenG2P/farmer-registry/commit/94507ea741d1c338c3b736d4b29e946c75ee692d))
- feat(data): add new Jinja2 templates for DCI response and farmer data processing ([`5e2c270`](https://github.com/OpenG2P/farmer-registry/commit/5e2c270178a6067942859ad97eac475961418de4))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(data): update SQL data models and templates for farmer extension ([`ae5987e`](https://github.com/OpenG2P/farmer-registry/commit/ae5987e3bc3e409b0c964de669494fc85e34a2be))
- refactor(id_generator): update farmer ID prefix from 'FAR-' to 'FR-' for consistency ([`e0009b8`](https://github.com/OpenG2P/farmer-registry/commit/e0009b8ec967bd1c170510e652ab5e2135dc4cfa))
- refactor(poverty): rename internal_record_id to link_internal_record_id for clarity ([`b67217f`](https://github.com/OpenG2P/farmer-registry/commit/b67217f0591800ef7ba8cd61f9e03e619b8e462a))
- refactor(models): remove poverty score model and update enums to use StrEnum ([`a002e32`](https://github.com/OpenG2P/farmer-registry/commit/a002e32acc0494e8c3d9f2a11763d3587678fa97))
- refactor(score_compute): replace PMT score computation with new poverty score service ([`f5b6641`](https://github.com/OpenG2P/farmer-registry/commit/f5b66410954cd34d482a480b33ecc5bbfc19959c))
- Renaming configurations to meta_data. ([`9416a3b`](https://github.com/OpenG2P/farmer-registry/commit/9416a3baa69f05deb42736535d1fc94cc79a897f))
- fix(docker): update git branch URL for staff portal UI ([`c3da205`](https://github.com/OpenG2P/farmer-registry/commit/c3da2052525d961b49e4a046814677610cf3b3d5))
- build(docker): update image tag to use 'develop' branch ([`791b3f4`](https://github.com/OpenG2P/farmer-registry/commit/791b3f4b0476ccde04e40cf0b027b814f66c13bc))
- build(docker): update dependencies to use 'develop' branch ([`82fec0f`](https://github.com/OpenG2P/farmer-registry/commit/82fec0fc75f87919053f69c1d548dd34aa0c0a30))
- feat(metadata): add SQL seed data for farmer intake forms and templates ([`167fd06`](https://github.com/OpenG2P/farmer-registry/commit/167fd060ef1e77ab33d4bd2c5c462c901647e7f0))
- [G2P-4694](https://openg2p.atlassian.net/browse/G2P-4694)  feat(models): add async method to link internal record ID ([`17ff7c6`](https://github.com/OpenG2P/farmer-registry/commit/17ff7c6a5009fbe98b0a93248da9dbd7863d587c))
- [G2P-4692](https://openg2p.atlassian.net/browse/G2P-4692) Added. ([`c5e4dfa`](https://github.com/OpenG2P/farmer-registry/commit/c5e4dfa9caa5338ea31f80ff250b96965bbd66cd))
- Initial commit ([`6e3cf83`](https://github.com/OpenG2P/farmer-registry/commit/6e3cf838809c5522a8b0cda15b87f726683ec175))

<a id="v-0-0-0-develop-103"></a>

## farmer-registry — develop 0.0.0-develop.103 (2026-07-18)

_commit `540f176` · baseline: release the start · previous build 0.0.0-develop.102_
<!-- build:0.0.0-develop.103 revision:540f1767d159309560970440cae7b4e794494698 ts:1784353688 -->

### Summary

_All changes since release the start:_

- IAM service repo renamed to `iam-service` from `openg2p-iam-service`.
- AWE removed from the project; now using Commons AWE.
- Fail closed by default: partner signature validation and consent enforcement are now enabled, aligning with registry platform defaults.
- Added CSRF validation configuration for staff-portal-api requests.
- Added Redis configuration for staff-portal-api authentication.
- Added IAM public URL configuration for Staff Portal UI.
- Enhanced data seeding scripts to include geo hierarchy functions and updated various records for accuracy.
- E2E sanity test suite added with two power tests.
- Sanity tests now pass end-to-end on a live cluster with necessary permissions and approvals.
- Production hardening: resource limits fixed, HPA bug resolved, and Docker containers now run as non-root.
- Updated develop versioning to follow the `0.0.0-develop.N` convention.
- Updated dependencies and image tags to the latest versions.
- Added support for loading geo reference data into the master_data database during db-seed.
- Updated SQL data models and templates for farmer extension.
- Consolidated helm chart with Docker images built using libraries from the registry platform.
- Enhanced Docker setup for template uploads.
- Updated SQL seed data for farmer intake forms and templates.
- Added domain validation utilities for various services.
- Updated AWE approver user password and added first/last names for new users in keycloak-init.
- Updated language data seeding by adding new fields and removing obsolete ones.
- Updated SQL data for farmer extension to modify incoming model semantic patterns and enhance g2p register scores.
- Added AWE_CALLBACK_CALLER_SERVICE to db-seed and updated SQL template.
- Fixed sanity audit-DB wiring to ensure correct secret usage.
- Updated ports and URLs for Partner Management and other services.
- Enhanced performance test suite added, still a work in progress.
- Removed unused verification permissions from payload.json.
- Fixed db seed Docker failures and corrected Postgres version.
- Updated Staff Portal UI version in configuration file to 1.1.0.
- Updated image tags to use the 'develop' branch.
- Removed legacy logging and synced changes with the latest NSR.
- Updated configurations to use `meta_data` terminology for clarity.
- Various minor fixes and enhancements to improve overall functionality and maintainability.

### New in this build (since 0.0.0-develop.102)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity e2e install-time 403s: run the sanity test Job at hook-weight 25 so it executes AFTER iam-register (weight 20) pushes the registry's roles→permissions catalog to IAM — the change-request tests were running at weight 15, before IAM knew the registry roles, causing 'Insufficient resource_access roles' ([`540f176`](https://github.com/OpenG2P/farmer-registry/commit/540f1767d159309560970440cae7b4e794494698))

### Since last release (the start)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity e2e install-time 403s: run the sanity test Job at hook-weight 25 so it executes AFTER iam-register (weight 20) pushes the registry's roles→permissions catalog to IAM — the change-request tests were running at weight 15, before IAM knew the registry roles, causing 'Insufficient resource_access roles' ([`540f176`](https://github.com/OpenG2P/farmer-registry/commit/540f1767d159309560970440cae7b4e794494698))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make sanity e2e survive install-time startup race: retry create_change_request on 403 (permission path warms up after staff-portal-api is reachable) with a fresh token up to authReadyTimeout=120s, and wait for staff-portal-api readiness in the entrypoint — the 4 CR tests were failing only because the Job ran ~2min into a fresh install. ([`345fc57`](https://github.com/OpenG2P/farmer-registry/commit/345fc579a35e7bb4d36c0f51b88e5685527cf78f))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity audit-DB wiring: auditDbSecret/key were audit-manager-db-user / audit-manager-db-user-password; the real Secret is audit-manager / audit-manager-db-user (as the auditmanager deployment mounts) — the in-cluster audit test would otherwise fail ([`e286919`](https://github.com/OpenG2P/farmer-registry/commit/e286919fca9c753c7dc3dd61f06d63b0307c9f1d))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make change-request e2e pass end-to-end on a live cluster: grant the sanity user AWE_ADMIN and approve every task on the request (shipped stages are mode='all' with demo approvers); poll for the async history row; key the audit assertion on actor_id (events carry no resource_id); add tab_id to get_number_of_versions; fix teardown to key on internal_record_id (CR/history are stamped with the display name) ([`14ec94c`](https://github.com/OpenG2P/farmer-registry/commit/14ec94c2ed2a4cd436ffec2f087e1833b6fd3ff3))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Docs: add Farmer Registry sanity-testing page (tests, DCI + change-request flow diagrams, seeding & markers, install packaging, run-local procedure, gates/e2e-off behavior, teardown); link from deployment README, helm-chart and SUMMARY ([`347f7bf`](https://github.com/OpenG2P/farmer-registry/commit/347f7bf4da3cf6c4b2214197e804737053acf106))
- Fail closed by default: enable partner signature validation and consent enforcement (matching the registry platform defaults, which the chart inverted); keep sanity e2e off by default; fix stale audit comment; record the consent/signature posture as a perf-testing variable ([`331ab43`](https://github.com/OpenG2P/farmer-registry/commit/331ab43be49d4f800bd6552fbbcabddfc1b45681))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) E2e sanity test suite added with 2 power e2e tests. ([`85b60d1`](https://github.com/OpenG2P/farmer-registry/commit/85b60d11a4628ec7a18322a21de3878a09ba940d))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Tidy CI-migration leftovers in farmer: drop dead develop.txt specs, repoint Chart.yaml comment and celery README to build-publish.yml/Dockerfile ([`6e15b11`](https://github.com/OpenG2P/farmer-registry/commit/6e15b117626e7c8abc678f71c3a3b87148c604b1))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Fix pin/build-arg repo mismatch: install iam-core from openg2p/iam-service (was openg2p-iam-service, which lacks the resolved SHA), and fetch openg2p-data by ref via git fetch+checkout so db-seed accepts a pinned commit SHA (git clone -b takes only a branch/tag name) ([`1f22275`](https://github.com/OpenG2P/farmer-registry/commit/1f22275da0bce42cb361e9792db8d45e9d31d044))
- IAM service repo renamed. ([`ce226a5`](https://github.com/OpenG2P/farmer-registry/commit/ce226a56f6bf9d282ca1c224d1c00fbf30b129ba))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Move to central build-publish CI; self-contained pinned Dockerfiles ([`84ad210`](https://github.com/OpenG2P/farmer-registry/commit/84ad2101e3f730e62dfb55b844f199e386b13ec8))
- [G2P-5342](https://openg2p.atlassian.net/browse/G2P-5342): Update develop.txt files to replace references to 'openg2p-iam-service' with 'iam-service' ([`8e68be8`](https://github.com/OpenG2P/farmer-registry/commit/8e68be8e828c4f135a333353a436e33d8105c8b4))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Production hardening. Resource limits fixed. HPA bug fixed. Dockers run as non-root. ([`41ea585`](https://github.com/OpenG2P/farmer-registry/commit/41ea5851217bf2b8e29b5ea9c03113ab967d629c))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Sync operational role IAM permissions for register metadata API access ([`e5c879b`](https://github.com/OpenG2P/farmer-registry/commit/e5c879b1c2cff372b2fcc14bbac53fb027f70834))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`5b00de3`](https://github.com/OpenG2P/farmer-registry/commit/5b00de3d9da0875353112159c0437877c8e753b1))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Add IAM public URL configuration for Staff Portal UI ([`97ec733`](https://github.com/OpenG2P/farmer-registry/commit/97ec7336b313921b73ef1293d7522e79ab958dc0))
- [G2P-5226](https://openg2p.atlassian.net/browse/G2P-5226) Add Redis configuration for staff-portal-api authentication ([`26383d9`](https://github.com/OpenG2P/farmer-registry/commit/26383d9f0e7753fa0686e1d1d7feb3bf3aa135c6))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Update AWE approver user password and add first/last names for new users in keycloak-init ([`9f768e0`](https://github.com/OpenG2P/farmer-registry/commit/9f768e0366be56a65bac49b3d6bb2da1b8aaba08))
- G2P5221 Add CSP configuration for profile/document images from MinIO ([`499f66a`](https://github.com/OpenG2P/farmer-registry/commit/499f66ad0e265499f137542bc1cfd53db8693c57))
- G2P5221 Add AWE_CALLBACK_CALLER_SERVICE to db-seed and update SQL template ([`9888832`](https://github.com/OpenG2P/farmer-registry/commit/9888832206278d1baea75aed1401b95175a94a9a))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Remove unused verification permissions from payload.json ([`53a2d5f`](https://github.com/OpenG2P/farmer-registry/commit/53a2d5fb8bc1f64dfde7cabba45e8193863d32af))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) URL of CM updated as it is not installed via commons-services. ([`3a76763`](https://github.com/OpenG2P/farmer-registry/commit/3a76763315a054d949ba23e8384cb4a3d3dd0638))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Harden helm-publish workflow against gh-pages push races: add concurrency group + rebase-pull before commit. ([`70c8859`](https://github.com/OpenG2P/farmer-registry/commit/70c88596ad1a9b87c4605fd1a62428e1840d3e6d))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`6da7b1c`](https://github.com/OpenG2P/farmer-registry/commit/6da7b1c8888ae07a6b48bbf4985cebd99652d35d))
-  [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299)  Url for PM updated. ([`724f07a`](https://github.com/OpenG2P/farmer-registry/commit/724f07a9c16239ad5a7c0ad971d9ece620f3b340))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) Ports corrected. ([`79a6cf2`](https://github.com/OpenG2P/farmer-registry/commit/79a6cf269d22c20ada488c1e09823075df46310f))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) questions.yaml updated. ([`b5ebd05`](https://github.com/OpenG2P/farmer-registry/commit/b5ebd0522e17a61f1666d46f7e8302f0791676cf))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sanity tests added. ([`d3d47bd`](https://github.com/OpenG2P/farmer-registry/commit/d3d47bd85fc15fbce068d03f095d8337cf7263bb))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancement for consent, partner management, WJS. ([`984d6a9`](https://github.com/OpenG2P/farmer-registry/commit/984d6a93d2317c936c9565607b59894cc61cd874))
- Versions updated to 'develop' ([`24a4f82`](https://github.com/OpenG2P/farmer-registry/commit/24a4f82147e1ea2e6e736968ad86c3fcf1f16ae3))
- Fix for db seed docker failing. ([`55a08c8`](https://github.com/OpenG2P/farmer-registry/commit/55a08c88d93c1840f9a5de53bc7c36be28cabdc7))
- [G2P-5260](https://openg2p.atlassian.net/browse/G2P-5260) AWE removed from here. Commons AWE used. ([`6b302cd`](https://github.com/OpenG2P/farmer-registry/commit/6b302cd1ccf4a54b9afe742c954f4eef54ac4a78))
- db-seed functionality: Added support for loading geo reference data into the master_data database. ([`7d9f06b`](https://github.com/OpenG2P/farmer-registry/commit/7d9f06b7f93350de0b6f0110578a379cde4b6b96))
- AWE version frozen. ([`9562666`](https://github.com/OpenG2P/farmer-registry/commit/95626664d8ec5e879f4a718589a8a7858e367b3c))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`057c447`](https://github.com/OpenG2P/farmer-registry/commit/057c447d82b1481216b9ebf2cd22f84828e9bc2f))
- [G2P-5202](https://openg2p.atlassian.net/browse/G2P-5202) Bump dependencies and update image tags to latest versions ([`7fdcded`](https://github.com/OpenG2P/farmer-registry/commit/7fdcded62d2089655064a34e551e983e1f2dfb95))
- postgres-init version changed to frozen version ([`42bb8eb`](https://github.com/OpenG2P/farmer-registry/commit/42bb8eba6c19d850a2aee9dd06dea030854f820a))
- [G2P-5187](https://openg2p.atlassian.net/browse/G2P-5187) Develop versioning updated with 0.0.0-develop.N convention ([`c5da4e7`](https://github.com/OpenG2P/farmer-registry/commit/c5da4e76859a54d47793a81547faaad67e41f447))
- Enhance data seeding scripts: Introduced geo hierarchy functions in load_sample_data.py, updated crop and farm input JSON files with new records and modified existing entries, and corrected link IDs in household members and lands JSON files. Adjusted livestock records to reflect accurate types and counts. Updated membership details with new member entries and corrected associations. ([`4f1f54f`](https://github.com/OpenG2P/farmer-registry/commit/4f1f54fd32d9f4ba9ad99c3e1534c0ea57dd4bfc))
- [G2P-5174](https://openg2p.atlassian.net/browse/G2P-5174) Performance test suit added. Still WIP. ([`0d881c9`](https://github.com/OpenG2P/farmer-registry/commit/0d881c9faf7ed5e1a207d5adcf2ad49257be57c0))
- [G2P-5186](https://openg2p.atlassian.net/browse/G2P-5186) Duplicate jobs with same name removed. ([`795d50f`](https://github.com/OpenG2P/farmer-registry/commit/795d50f281c6cfab686c25b9f571cc20ffe0e2e3))
- [G2P-4904](https://openg2p.atlassian.net/browse/G2P-4904) - Farmer data seeding ([`2e124bd`](https://github.com/OpenG2P/farmer-registry/commit/2e124bd979298447502a8c0aaf64bb61755ae56e))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) IAM traces removed with uninstall. ([`14d0804`](https://github.com/OpenG2P/farmer-registry/commit/14d08042bccd4323f5eb1d6dbcd32b6d9dfb38ef))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Calling IAM endpoint to register. ([`65f5f8b`](https://github.com/OpenG2P/farmer-registry/commit/65f5f8b48e8bc19ce65f7229c78068289ea086dc))
- [G2P-5142](https://openg2p.atlassian.net/browse/G2P-5142) update language data seeding: add new field and remove obsolete field ([`13ad7de`](https://github.com/OpenG2P/farmer-registry/commit/13ad7dea9bebfe5562dfca89d546f5767e412820))
- Postgres version corrected. ([`9f936f3`](https://github.com/OpenG2P/farmer-registry/commit/9f936f3bc99651e83fd1c79ff495be7f68295681))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) Changes in AWE configs such that multiple registries can be installed in an env. ([`097746f`](https://github.com/OpenG2P/farmer-registry/commit/097746f38c213d4f7165c3b5c65ad09af254196a))
- Readme cleaned up. ([`62cb828`](https://github.com/OpenG2P/farmer-registry/commit/62cb8285604c6945be9118423b278e2b80059eb7))
- Temp version to fix the harcoded chart name issue. ([`82d5288`](https://github.com/OpenG2P/farmer-registry/commit/82d52880b49ab91cf92aff102f9f3e613fd04d43))
- Version changed 0.0.1 as the previous issue is still there. ([`8533435`](https://github.com/OpenG2P/farmer-registry/commit/85334351785b9129cb9207be67c82495411e313f))
- Changed the version number to fix the problem of fixed chart name appearing while installing with Rancher. ([`3728628`](https://github.com/OpenG2P/farmer-registry/commit/372862881d8d303ad53a3bac825870dc2b4133d7))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Legacy logging removed, changes synced with latest NSR. ([`1a2fbac`](https://github.com/OpenG2P/farmer-registry/commit/1a2fbaca558d6f1f9548616cdf5a05359df43770))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Consolidated helm chart with dockers built using libs from registry-platform. Just like we did for NSR. ([`1b6b457`](https://github.com/OpenG2P/farmer-registry/commit/1b6b457ec6bf89016dcd183f105a9c5fb4d960be))
- [G2P-4924](https://openg2p.atlassian.net/browse/G2P-4924) Seed AWE approval policies for Farmer Registry ([`3134a03`](https://github.com/OpenG2P/farmer-registry/commit/3134a03dc3ac925c4b28e771bdc5b1f374b453ae))
- [G2P-5028](https://openg2p.atlassian.net/browse/G2P-5028) feat(services): implement domain validation utilities for various services ([`e79ad62`](https://github.com/OpenG2P/farmer-registry/commit/e79ad6217157667b9165ab50bcb580acc6276618))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(db-seed): enhance Docker setup for template uploads ([`0757a8f`](https://github.com/OpenG2P/farmer-registry/commit/0757a8f8e1c40e8a109a5b5cbedd61fdabddd150))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(data): update SQL data models and templates for farmer extension ([`92529eb`](https://github.com/OpenG2P/farmer-registry/commit/92529eb9ac452186cd511926513d40d7c7b827a4))
- refactor(data): update SQL data models and templates for farmer extension ([`1115ab1`](https://github.com/OpenG2P/farmer-registry/commit/1115ab1180ae43a47121657331bd1222629f5781))
- Update SQL data for farmer extension: modify incoming model semantic patterns and enhance g2p register scores ([`d61f6c8`](https://github.com/OpenG2P/farmer-registry/commit/d61f6c8548ad877a97c611a58248666b2aec62ac))
- fix(docker): update Staff Portal UI version in configuration file to 1.1.0 ([`4f2b43f`](https://github.com/OpenG2P/farmer-registry/commit/4f2b43f39a4acfc206d86f0c396da1968df5b1bf))
- build: add Docker configuration files for version 1.1.0 of Celery, Partner API, and Staff Portal API ([`4ac52dc`](https://github.com/OpenG2P/farmer-registry/commit/4ac52dcd7b89b249bc014a60576046a39e8b51a0))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(app): remove poverty score models from initialization process ([`94507ea`](https://github.com/OpenG2P/farmer-registry/commit/94507ea741d1c338c3b736d4b29e946c75ee692d))
- feat(data): add new Jinja2 templates for DCI response and farmer data processing ([`5e2c270`](https://github.com/OpenG2P/farmer-registry/commit/5e2c270178a6067942859ad97eac475961418de4))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(data): update SQL data models and templates for farmer extension ([`ae5987e`](https://github.com/OpenG2P/farmer-registry/commit/ae5987e3bc3e409b0c964de669494fc85e34a2be))
- refactor(id_generator): update farmer ID prefix from 'FAR-' to 'FR-' for consistency ([`e0009b8`](https://github.com/OpenG2P/farmer-registry/commit/e0009b8ec967bd1c170510e652ab5e2135dc4cfa))
- refactor(poverty): rename internal_record_id to link_internal_record_id for clarity ([`b67217f`](https://github.com/OpenG2P/farmer-registry/commit/b67217f0591800ef7ba8cd61f9e03e619b8e462a))
- refactor(models): remove poverty score model and update enums to use StrEnum ([`a002e32`](https://github.com/OpenG2P/farmer-registry/commit/a002e32acc0494e8c3d9f2a11763d3587678fa97))
- refactor(score_compute): replace PMT score computation with new poverty score service ([`f5b6641`](https://github.com/OpenG2P/farmer-registry/commit/f5b66410954cd34d482a480b33ecc5bbfc19959c))
- Renaming configurations to meta_data. ([`9416a3b`](https://github.com/OpenG2P/farmer-registry/commit/9416a3baa69f05deb42736535d1fc94cc79a897f))
- fix(docker): update git branch URL for staff portal UI ([`c3da205`](https://github.com/OpenG2P/farmer-registry/commit/c3da2052525d961b49e4a046814677610cf3b3d5))
- build(docker): update image tag to use 'develop' branch ([`791b3f4`](https://github.com/OpenG2P/farmer-registry/commit/791b3f4b0476ccde04e40cf0b027b814f66c13bc))
- build(docker): update dependencies to use 'develop' branch ([`82fec0f`](https://github.com/OpenG2P/farmer-registry/commit/82fec0fc75f87919053f69c1d548dd34aa0c0a30))
- feat(metadata): add SQL seed data for farmer intake forms and templates ([`167fd06`](https://github.com/OpenG2P/farmer-registry/commit/167fd060ef1e77ab33d4bd2c5c462c901647e7f0))
- [G2P-4694](https://openg2p.atlassian.net/browse/G2P-4694)  feat(models): add async method to link internal record ID ([`17ff7c6`](https://github.com/OpenG2P/farmer-registry/commit/17ff7c6a5009fbe98b0a93248da9dbd7863d587c))
- [G2P-4692](https://openg2p.atlassian.net/browse/G2P-4692) Added. ([`c5e4dfa`](https://github.com/OpenG2P/farmer-registry/commit/c5e4dfa9caa5338ea31f80ff250b96965bbd66cd))
- Initial commit ([`6e3cf83`](https://github.com/OpenG2P/farmer-registry/commit/6e3cf838809c5522a8b0cda15b87f726683ec175))

<a id="v-0-0-0-develop-102"></a>

## farmer-registry — develop 0.0.0-develop.102 (2026-07-18)

_commit `345fc57` · baseline: release the start · previous build 0.0.0-develop.101_
<!-- build:0.0.0-develop.102 revision:345fc579a35e7bb4d36c0f51b88e5685527cf78f ts:1784352601 -->

### Summary

_All changes since release the start:_

- **Breaking Change:** AWE has been removed; Commons AWE is now used instead. ([`6b302cd`](https://github.com/OpenG2P/farmer-registry/commit/6b302cd1ccf4a54b9afe742c954f4eef54ac4a78))
- **Security Change:** CSRF validation configuration has been added for staff-portal-api requests. ([`5b00de3`](https://github.com/OpenG2P/farmer-registry/commit/5b00de3d9da0875353112159c0437877c8e753b1))
- **Feature Update:** Added support for loading geo reference data into the master_data database. ([`7d9f06b`](https://github.com/OpenG2P/farmer-registry/commit/7d9f06b7f93350de0b6f0110578a379cde4b6b96))
- **Dependency Change:** IAM service repo has been renamed to 'iam-service'. ([`ce226a5`](https://github.com/OpenG2P/farmer-registry/commit/ce226a56f6bf9d282ca1c224d1c00fbf30b129ba))
- **Feature Addition:** E2E sanity test suite has been added with two power E2E tests. ([`85b60d1`](https://github.com/OpenG2P/farmer-registry/commit/85b60d11a4628ec7a18322a21de3878a09ba940d))
- **Feature Update:** Added Redis configuration for staff-portal-api authentication. ([`26383d9`](https://github.com/OpenG2P/farmer-registry/commit/26383d9f0e7753fa0686e1d1d7feb3bf3aa135c6))
- **Feature Update:** Added IAM public URL configuration for Staff Portal UI. ([`97ec733`](https://github.com/OpenG2P/farmer-registry/commit/97ec7336b313921b73ef1293d7522e79ab958dc0))
- **Feature Update:** Updated AWE approver user password and added first/last names for new users in keycloak-init. ([`9f768e0`](https://github.com/OpenG2P/farmer-registry/commit/9f768e0366be56a65bac49b3d6bb2da1b8aaba08))
- **Feature Update:** Enhanced data seeding scripts with new records and corrections in JSON files. ([`4f1f54f`](https://github.com/OpenG2P/farmer-registry/commit/4f1f54fd32d9f4ba9ad99c3e1534c0ea57dd4bfc))
- **Feature Update:** Updated SQL data models and templates for farmer extension. ([`92529eb`](https://github.com/OpenG2P/farmer-registry/commit/92529eb9ac452186cd511926513d40d7c7b827a4))
- **Feature Update:** Added SQL seed data for farmer intake forms and templates. ([`167fd06`](https://github.com/OpenG2

### New in this build (since 0.0.0-develop.101)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make sanity e2e survive install-time startup race: retry create_change_request on 403 (permission path warms up after staff-portal-api is reachable) with a fresh token up to authReadyTimeout=120s, and wait for staff-portal-api readiness in the entrypoint — the 4 CR tests were failing only because the Job ran ~2min into a fresh install. ([`345fc57`](https://github.com/OpenG2P/farmer-registry/commit/345fc579a35e7bb4d36c0f51b88e5685527cf78f))

### Since last release (the start)

- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make sanity e2e survive install-time startup race: retry create_change_request on 403 (permission path warms up after staff-portal-api is reachable) with a fresh token up to authReadyTimeout=120s, and wait for staff-portal-api readiness in the entrypoint — the 4 CR tests were failing only because the Job ran ~2min into a fresh install. ([`345fc57`](https://github.com/OpenG2P/farmer-registry/commit/345fc579a35e7bb4d36c0f51b88e5685527cf78f))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Fix sanity audit-DB wiring: auditDbSecret/key were audit-manager-db-user / audit-manager-db-user-password; the real Secret is audit-manager / audit-manager-db-user (as the auditmanager deployment mounts) — the in-cluster audit test would otherwise fail ([`e286919`](https://github.com/OpenG2P/farmer-registry/commit/e286919fca9c753c7dc3dd61f06d63b0307c9f1d))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Make change-request e2e pass end-to-end on a live cluster: grant the sanity user AWE_ADMIN and approve every task on the request (shipped stages are mode='all' with demo approvers); poll for the async history row; key the audit assertion on actor_id (events carry no resource_id); add tab_id to get_number_of_versions; fix teardown to key on internal_record_id (CR/history are stamped with the display name) ([`14ec94c`](https://github.com/OpenG2P/farmer-registry/commit/14ec94c2ed2a4cd436ffec2f087e1833b6fd3ff3))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) Docs: add Farmer Registry sanity-testing page (tests, DCI + change-request flow diagrams, seeding & markers, install packaging, run-local procedure, gates/e2e-off behavior, teardown); link from deployment README, helm-chart and SUMMARY ([`347f7bf`](https://github.com/OpenG2P/farmer-registry/commit/347f7bf4da3cf6c4b2214197e804737053acf106))
- Fail closed by default: enable partner signature validation and consent enforcement (matching the registry platform defaults, which the chart inverted); keep sanity e2e off by default; fix stale audit comment; record the consent/signature posture as a perf-testing variable ([`331ab43`](https://github.com/OpenG2P/farmer-registry/commit/331ab43be49d4f800bd6552fbbcabddfc1b45681))
- [G2P-5378](https://openg2p.atlassian.net/browse/G2P-5378) E2e sanity test suite added with 2 power e2e tests. ([`85b60d1`](https://github.com/OpenG2P/farmer-registry/commit/85b60d11a4628ec7a18322a21de3878a09ba940d))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Tidy CI-migration leftovers in farmer: drop dead develop.txt specs, repoint Chart.yaml comment and celery README to build-publish.yml/Dockerfile ([`6e15b11`](https://github.com/OpenG2P/farmer-registry/commit/6e15b117626e7c8abc678f71c3a3b87148c604b1))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Fix pin/build-arg repo mismatch: install iam-core from openg2p/iam-service (was openg2p-iam-service, which lacks the resolved SHA), and fetch openg2p-data by ref via git fetch+checkout so db-seed accepts a pinned commit SHA (git clone -b takes only a branch/tag name) ([`1f22275`](https://github.com/OpenG2P/farmer-registry/commit/1f22275da0bce42cb361e9792db8d45e9d31d044))
- IAM service repo renamed. ([`ce226a5`](https://github.com/OpenG2P/farmer-registry/commit/ce226a56f6bf9d282ca1c224d1c00fbf30b129ba))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Move to central build-publish CI; self-contained pinned Dockerfiles ([`84ad210`](https://github.com/OpenG2P/farmer-registry/commit/84ad2101e3f730e62dfb55b844f199e386b13ec8))
- [G2P-5342](https://openg2p.atlassian.net/browse/G2P-5342): Update develop.txt files to replace references to 'openg2p-iam-service' with 'iam-service' ([`8e68be8`](https://github.com/OpenG2P/farmer-registry/commit/8e68be8e828c4f135a333353a436e33d8105c8b4))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Production hardening. Resource limits fixed. HPA bug fixed. Dockers run as non-root. ([`41ea585`](https://github.com/OpenG2P/farmer-registry/commit/41ea5851217bf2b8e29b5ea9c03113ab967d629c))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Sync operational role IAM permissions for register metadata API access ([`e5c879b`](https://github.com/OpenG2P/farmer-registry/commit/e5c879b1c2cff372b2fcc14bbac53fb027f70834))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`5b00de3`](https://github.com/OpenG2P/farmer-registry/commit/5b00de3d9da0875353112159c0437877c8e753b1))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Add IAM public URL configuration for Staff Portal UI ([`97ec733`](https://github.com/OpenG2P/farmer-registry/commit/97ec7336b313921b73ef1293d7522e79ab958dc0))
- [G2P-5226](https://openg2p.atlassian.net/browse/G2P-5226) Add Redis configuration for staff-portal-api authentication ([`26383d9`](https://github.com/OpenG2P/farmer-registry/commit/26383d9f0e7753fa0686e1d1d7feb3bf3aa135c6))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Update AWE approver user password and add first/last names for new users in keycloak-init ([`9f768e0`](https://github.com/OpenG2P/farmer-registry/commit/9f768e0366be56a65bac49b3d6bb2da1b8aaba08))
- G2P5221 Add CSP configuration for profile/document images from MinIO ([`499f66a`](https://github.com/OpenG2P/farmer-registry/commit/499f66ad0e265499f137542bc1cfd53db8693c57))
- G2P5221 Add AWE_CALLBACK_CALLER_SERVICE to db-seed and update SQL template ([`9888832`](https://github.com/OpenG2P/farmer-registry/commit/9888832206278d1baea75aed1401b95175a94a9a))
- [G2P-5221](https://openg2p.atlassian.net/browse/G2P-5221) Remove unused verification permissions from payload.json ([`53a2d5f`](https://github.com/OpenG2P/farmer-registry/commit/53a2d5fb8bc1f64dfde7cabba45e8193863d32af))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) URL of CM updated as it is not installed via commons-services. ([`3a76763`](https://github.com/OpenG2P/farmer-registry/commit/3a76763315a054d949ba23e8384cb4a3d3dd0638))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Harden helm-publish workflow against gh-pages push races: add concurrency group + rebase-pull before commit. ([`70c8859`](https://github.com/OpenG2P/farmer-registry/commit/70c88596ad1a9b87c4605fd1a62428e1840d3e6d))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`6da7b1c`](https://github.com/OpenG2P/farmer-registry/commit/6da7b1c8888ae07a6b48bbf4985cebd99652d35d))
-  [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299)  Url for PM updated. ([`724f07a`](https://github.com/OpenG2P/farmer-registry/commit/724f07a9c16239ad5a7c0ad971d9ece620f3b340))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) Ports corrected. ([`79a6cf2`](https://github.com/OpenG2P/farmer-registry/commit/79a6cf269d22c20ada488c1e09823075df46310f))
- [G2P-5299](https://openg2p.atlassian.net/browse/G2P-5299) questions.yaml updated. ([`b5ebd05`](https://github.com/OpenG2P/farmer-registry/commit/b5ebd0522e17a61f1666d46f7e8302f0791676cf))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Sanity tests added. ([`d3d47bd`](https://github.com/OpenG2P/farmer-registry/commit/d3d47bd85fc15fbce068d03f095d8337cf7263bb))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancement for consent, partner management, WJS. ([`984d6a9`](https://github.com/OpenG2P/farmer-registry/commit/984d6a93d2317c936c9565607b59894cc61cd874))
- Versions updated to 'develop' ([`24a4f82`](https://github.com/OpenG2P/farmer-registry/commit/24a4f82147e1ea2e6e736968ad86c3fcf1f16ae3))
- Fix for db seed docker failing. ([`55a08c8`](https://github.com/OpenG2P/farmer-registry/commit/55a08c88d93c1840f9a5de53bc7c36be28cabdc7))
- [G2P-5260](https://openg2p.atlassian.net/browse/G2P-5260) AWE removed from here. Commons AWE used. ([`6b302cd`](https://github.com/OpenG2P/farmer-registry/commit/6b302cd1ccf4a54b9afe742c954f4eef54ac4a78))
- db-seed functionality: Added support for loading geo reference data into the master_data database. ([`7d9f06b`](https://github.com/OpenG2P/farmer-registry/commit/7d9f06b7f93350de0b6f0110578a379cde4b6b96))
- AWE version frozen. ([`9562666`](https://github.com/OpenG2P/farmer-registry/commit/95626664d8ec5e879f4a718589a8a7858e367b3c))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`057c447`](https://github.com/OpenG2P/farmer-registry/commit/057c447d82b1481216b9ebf2cd22f84828e9bc2f))
- [G2P-5202](https://openg2p.atlassian.net/browse/G2P-5202) Bump dependencies and update image tags to latest versions ([`7fdcded`](https://github.com/OpenG2P/farmer-registry/commit/7fdcded62d2089655064a34e551e983e1f2dfb95))
- postgres-init version changed to frozen version ([`42bb8eb`](https://github.com/OpenG2P/farmer-registry/commit/42bb8eba6c19d850a2aee9dd06dea030854f820a))
- [G2P-5187](https://openg2p.atlassian.net/browse/G2P-5187) Develop versioning updated with 0.0.0-develop.N convention ([`c5da4e7`](https://github.com/OpenG2P/farmer-registry/commit/c5da4e76859a54d47793a81547faaad67e41f447))
- Enhance data seeding scripts: Introduced geo hierarchy functions in load_sample_data.py, updated crop and farm input JSON files with new records and modified existing entries, and corrected link IDs in household members and lands JSON files. Adjusted livestock records to reflect accurate types and counts. Updated membership details with new member entries and corrected associations. ([`4f1f54f`](https://github.com/OpenG2P/farmer-registry/commit/4f1f54fd32d9f4ba9ad99c3e1534c0ea57dd4bfc))
- [G2P-5174](https://openg2p.atlassian.net/browse/G2P-5174) Performance test suit added. Still WIP. ([`0d881c9`](https://github.com/OpenG2P/farmer-registry/commit/0d881c9faf7ed5e1a207d5adcf2ad49257be57c0))
- [G2P-5186](https://openg2p.atlassian.net/browse/G2P-5186) Duplicate jobs with same name removed. ([`795d50f`](https://github.com/OpenG2P/farmer-registry/commit/795d50f281c6cfab686c25b9f571cc20ffe0e2e3))
- [G2P-4904](https://openg2p.atlassian.net/browse/G2P-4904) - Farmer data seeding ([`2e124bd`](https://github.com/OpenG2P/farmer-registry/commit/2e124bd979298447502a8c0aaf64bb61755ae56e))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) IAM traces removed with uninstall. ([`14d0804`](https://github.com/OpenG2P/farmer-registry/commit/14d08042bccd4323f5eb1d6dbcd32b6d9dfb38ef))
- [G2P-5143](https://openg2p.atlassian.net/browse/G2P-5143) Calling IAM endpoint to register. ([`65f5f8b`](https://github.com/OpenG2P/farmer-registry/commit/65f5f8b48e8bc19ce65f7229c78068289ea086dc))
- [G2P-5142](https://openg2p.atlassian.net/browse/G2P-5142) update language data seeding: add new field and remove obsolete field ([`13ad7de`](https://github.com/OpenG2P/farmer-registry/commit/13ad7dea9bebfe5562dfca89d546f5767e412820))
- Postgres version corrected. ([`9f936f3`](https://github.com/OpenG2P/farmer-registry/commit/9f936f3bc99651e83fd1c79ff495be7f68295681))
- [G2P-5103](https://openg2p.atlassian.net/browse/G2P-5103) Changes in AWE configs such that multiple registries can be installed in an env. ([`097746f`](https://github.com/OpenG2P/farmer-registry/commit/097746f38c213d4f7165c3b5c65ad09af254196a))
- Readme cleaned up. ([`62cb828`](https://github.com/OpenG2P/farmer-registry/commit/62cb8285604c6945be9118423b278e2b80059eb7))
- Temp version to fix the harcoded chart name issue. ([`82d5288`](https://github.com/OpenG2P/farmer-registry/commit/82d52880b49ab91cf92aff102f9f3e613fd04d43))
- Version changed 0.0.1 as the previous issue is still there. ([`8533435`](https://github.com/OpenG2P/farmer-registry/commit/85334351785b9129cb9207be67c82495411e313f))
- Changed the version number to fix the problem of fixed chart name appearing while installing with Rancher. ([`3728628`](https://github.com/OpenG2P/farmer-registry/commit/372862881d8d303ad53a3bac825870dc2b4133d7))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Legacy logging removed, changes synced with latest NSR. ([`1a2fbac`](https://github.com/OpenG2P/farmer-registry/commit/1a2fbaca558d6f1f9548616cdf5a05359df43770))
- [G2P-5125](https://openg2p.atlassian.net/browse/G2P-5125) Consolidated helm chart with dockers built using libs from registry-platform. Just like we did for NSR. ([`1b6b457`](https://github.com/OpenG2P/farmer-registry/commit/1b6b457ec6bf89016dcd183f105a9c5fb4d960be))
- [G2P-4924](https://openg2p.atlassian.net/browse/G2P-4924) Seed AWE approval policies for Farmer Registry ([`3134a03`](https://github.com/OpenG2P/farmer-registry/commit/3134a03dc3ac925c4b28e771bdc5b1f374b453ae))
- [G2P-5028](https://openg2p.atlassian.net/browse/G2P-5028) feat(services): implement domain validation utilities for various services ([`e79ad62`](https://github.com/OpenG2P/farmer-registry/commit/e79ad6217157667b9165ab50bcb580acc6276618))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(db-seed): enhance Docker setup for template uploads ([`0757a8f`](https://github.com/OpenG2P/farmer-registry/commit/0757a8f8e1c40e8a109a5b5cbedd61fdabddd150))
- [G2P-4932](https://openg2p.atlassian.net/browse/G2P-4932) feat(data): update SQL data models and templates for farmer extension ([`92529eb`](https://github.com/OpenG2P/farmer-registry/commit/92529eb9ac452186cd511926513d40d7c7b827a4))
- refactor(data): update SQL data models and templates for farmer extension ([`1115ab1`](https://github.com/OpenG2P/farmer-registry/commit/1115ab1180ae43a47121657331bd1222629f5781))
- Update SQL data for farmer extension: modify incoming model semantic patterns and enhance g2p register scores ([`d61f6c8`](https://github.com/OpenG2P/farmer-registry/commit/d61f6c8548ad877a97c611a58248666b2aec62ac))
- fix(docker): update Staff Portal UI version in configuration file to 1.1.0 ([`4f2b43f`](https://github.com/OpenG2P/farmer-registry/commit/4f2b43f39a4acfc206d86f0c396da1968df5b1bf))
- build: add Docker configuration files for version 1.1.0 of Celery, Partner API, and Staff Portal API ([`4ac52dc`](https://github.com/OpenG2P/farmer-registry/commit/4ac52dcd7b89b249bc014a60576046a39e8b51a0))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(app): remove poverty score models from initialization process ([`94507ea`](https://github.com/OpenG2P/farmer-registry/commit/94507ea741d1c338c3b736d4b29e946c75ee692d))
- feat(data): add new Jinja2 templates for DCI response and farmer data processing ([`5e2c270`](https://github.com/OpenG2P/farmer-registry/commit/5e2c270178a6067942859ad97eac475961418de4))
- [G2P-4695](https://openg2p.atlassian.net/browse/G2P-4695) refactor(data): update SQL data models and templates for farmer extension ([`ae5987e`](https://github.com/OpenG2P/farmer-registry/commit/ae5987e3bc3e409b0c964de669494fc85e34a2be))
- refactor(id_generator): update farmer ID prefix from 'FAR-' to 'FR-' for consistency ([`e0009b8`](https://github.com/OpenG2P/farmer-registry/commit/e0009b8ec967bd1c170510e652ab5e2135dc4cfa))
- refactor(poverty): rename internal_record_id to link_internal_record_id for clarity ([`b67217f`](https://github.com/OpenG2P/farmer-registry/commit/b67217f0591800ef7ba8cd61f9e03e619b8e462a))
- refactor(models): remove poverty score model and update enums to use StrEnum ([`a002e32`](https://github.com/OpenG2P/farmer-registry/commit/a002e32acc0494e8c3d9f2a11763d3587678fa97))
- refactor(score_compute): replace PMT score computation with new poverty score service ([`f5b6641`](https://github.com/OpenG2P/farmer-registry/commit/f5b66410954cd34d482a480b33ecc5bbfc19959c))
- Renaming configurations to meta_data. ([`9416a3b`](https://github.com/OpenG2P/farmer-registry/commit/9416a3baa69f05deb42736535d1fc94cc79a897f))
- fix(docker): update git branch URL for staff portal UI ([`c3da205`](https://github.com/OpenG2P/farmer-registry/commit/c3da2052525d961b49e4a046814677610cf3b3d5))
- build(docker): update image tag to use 'develop' branch ([`791b3f4`](https://github.com/OpenG2P/farmer-registry/commit/791b3f4b0476ccde04e40cf0b027b814f66c13bc))
- build(docker): update dependencies to use 'develop' branch ([`82fec0f`](https://github.com/OpenG2P/farmer-registry/commit/82fec0fc75f87919053f69c1d548dd34aa0c0a30))
- feat(metadata): add SQL seed data for farmer intake forms and templates ([`167fd06`](https://github.com/OpenG2P/farmer-registry/commit/167fd060ef1e77ab33d4bd2c5c462c901647e7f0))
- [G2P-4694](https://openg2p.atlassian.net/browse/G2P-4694)  feat(models): add async method to link internal record ID ([`17ff7c6`](https://github.com/OpenG2P/farmer-registry/commit/17ff7c6a5009fbe98b0a93248da9dbd7863d587c))
- [G2P-4692](https://openg2p.atlassian.net/browse/G2P-4692) Added. ([`c5e4dfa`](https://github.com/OpenG2P/farmer-registry/commit/c5e4dfa9caa5338ea31f80ff250b96965bbd66cd))
- Initial commit ([`6e3cf83`](https://github.com/OpenG2P/farmer-registry/commit/6e3cf838809c5522a8b0cda15b87f726683ec175))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 3 develop builds** and the **latest 3 release
> candidates** per release line. Older develop builds and release candidates
> are pruned as they are superseded, and a release's candidates are removed
> once it ships. Those versions still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
