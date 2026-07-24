# registry-platform

_Published automatically._

**Repository:** [github.com/OpenG2P/registry-platform](https://github.com/OpenG2P/registry-platform)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.295`](#v-0-0-0-develop-295) | 2026-07-24 | develop |
| [`0.0.0-develop.294`](#v-0-0-0-develop-294) | 2026-07-24 | develop |
| [`0.0.0-develop.292`](#v-0-0-0-develop-292) | 2026-07-23 | develop |
| [`0.0.0-develop.291`](#v-0-0-0-develop-291) | 2026-07-23 | develop |
| [`0.0.0-develop.288`](#v-0-0-0-develop-288) | 2026-07-23 | develop |
| [`0.0.0-develop.286`](#v-0-0-0-develop-286) | 2026-07-22 | develop |
| [`0.0.0-develop.285`](#v-0-0-0-develop-285) | 2026-07-22 | develop |
| [`develop`](#v-branch-develop) | 2026-07-20 | branch |

# Develop builds

<a id="v-0-0-0-develop-295"></a>

## registry-platform — develop 0.0.0-develop.295 (2026-07-24)

_commit `c5214fc` · changes since 0.0.0-develop.294_
<!-- build:0.0.0-develop.295 revision:c5214fc0ea55c590df3599b2b82c7245ac967417 ts:1784868682 -->

### Changes since 0.0.0-develop.294

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: make the DCI overlay tolerant of an older pinned harness — probe for post_search and fall back to a plain POST instead of failing collection with ImportError ([`c5214fc`](https://github.com/OpenG2P/registry-platform/commit/c5214fc0ea55c590df3599b2b82c7245ac967417))

<a id="v-0-0-0-develop-294"></a>

## registry-platform — develop 0.0.0-develop.294 (2026-07-24)

_commit `9ded7ac` · changes since 0.0.0-develop.292_
<!-- build:0.0.0-develop.294 revision:9ded7ac1e08c7fba279ff4b8cb71e844fd4bc7a2 ts:1784860124 -->

### Summary

- Sanity enhancements: implemented retry logic for DCI searches on 5xx errors while maintaining fail-closed behavior for genuine policy denials, and added a contract test to ensure variant fixtures integrity during collection.
- Testing improvements: introduced a new contract test file to validate the overlay of fixtures, enhancing the robustness of the testing framework.

### Changes since 0.0.0-develop.292

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: retry a DCI search only when a dependency returns 5xx (e.g. Consent Manager stale-connection 500) — a genuine policy denial is never retried, so fail-closed behaviour is still asserted ([`9ded7ac`](https://github.com/OpenG2P/registry-platform/commit/9ded7ac1e08c7fba279ff4b8cb71e844fd4bc7a2))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: add a contract test asserting a variant's fixtures overlay satisfies every fixtures.<SYMBOL> the inherited harness imports — renaming a symbol in an overlay silently breaks sanity/dci.py and friends at collection time ([`23c58b3`](https://github.com/OpenG2P/registry-platform/commit/23c58b3fb72a204db6a6694142b34005e7918f02))

<a id="v-0-0-0-develop-292"></a>

## registry-platform — develop 0.0.0-develop.292 (2026-07-23)

_commit `dd25651` · changes since 0.0.0-develop.291_
<!-- build:0.0.0-develop.292 revision:dd256515449c69dd3290db2d9ddbc2f9c9fefbea ts:1784807418 -->

### Changes since 0.0.0-develop.291

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: fail instead of silently passing — default SANITY_FAIL_ON_ERROR/failOnError to true so a failing suite fails the Job and the install, and make fixtures FAIL when a dependency is configured but broken (unconfigured dependencies still skip), so a run cannot go green having dropped every consent and signature test ([`dd25651`](https://github.com/OpenG2P/registry-platform/commit/dd256515449c69dd3290db2d9ddbc2f9c9fefbea))

<a id="v-0-0-0-develop-291"></a>

## registry-platform — develop 0.0.0-develop.291 (2026-07-23)

_commit `a46a5e4` · changes since 0.0.0-develop.288_
<!-- build:0.0.0-develop.291 revision:a46a5e47bd790eb64d514c92c73d056fb909eca1 ts:1784807328 -->

### Summary

- Bug fix: resolved an issue in Partner Management where HTTP 400 responses for already-onboarded partners were not triggering the correct status code, leading to silent skips in consent/signature tests.
- Dependency updates: synchronized `staff-portal-ui` to version `1.1.6-dev.2` and made changes to the `package-lock.json` and `package.json` files for `ui-widgets`.
- Testing improvements: enhanced error handling by surfacing response bodies on failure for better debugging.

### Changes since 0.0.0-develop.288

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: fix PM partner seeding — Partner Management returns HTTP 400 with body code PM-PRT-409 for an already-onboarded partner, so the status_code==409 branch never fired and every consent/signature test silently SKIPPED; also surface the response body on failure ([`112378f`](https://github.com/OpenG2P/registry-platform/commit/112378f8f3edd5c16060b079b35551ce1f20129f))
- chore(ui-widgets): version for npm next publish, sync staff-portal-ui @1.1.6-dev.2 [skip ci] ([`7b30e97`](https://github.com/OpenG2P/registry-platform/commit/7b30e979cbc9e443e8dadce4a61a5f97dc19b6c2))

<a id="v-0-0-0-develop-288"></a>

## registry-platform — develop 0.0.0-develop.288 (2026-07-23)

_commit `01ce237` · baseline: release v1.0.0 · previous build 0.0.0-develop.286_
<!-- build:0.0.0-develop.288 revision:01ce237388d7e036eb9492d6c08e581bd485cb9f ts:1784782986 -->

### Summary

_All changes since release v1.0.0:_

- **Major:** CI improvements: unified build-publish workflow for all images and charts, added lightweight PR checks, and excluded Dependabot branches from builds.
- Security enhancements: added CSRF validation for staff-portal-api requests and client-side CSRF token handling, improving overall request security.
- Reference registry updates: cleaned up unused message rules, corrected Dockerfile comments, and ensured individual change requests seed correctly even with existing data.
- Testing improvements: enhanced e2e test logging with timestamps and structured outputs, and ensured reference e2e tests are fully green.
- UI/UX refinements: improved document handling in intake forms, updated breadcrumb navigation, and added configurable reference generator for better user experience.
- Dependency management: updated @openg2p/registry-widgets to version 1.1.4 and synchronized various widget versions across modules.
- Refactoring efforts: streamlined document handling processes, improved logging for missing references, and removed deprecated classes for cleaner codebase.
- Feature additions: introduced new data policy management features, enhanced file validation profiles, and added application reference field generation.
- Miscellaneous fixes: addressed various bugs related to document uploads, attribute visibility, and improved error handling across multiple components.

### New in this build (since 0.0.0-develop.286)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Chart: make the IAM tile name values-driven (iamRegister.applicationDescription via __APPLICATION_DESCRIPTION__) so a wrapper chart can set it, and fix the reference registry's id-generator idTypes (farmer -> individual) so its Individual register actually gets a functional-ID pool ([`01ce237`](https://github.com/OpenG2P/registry-platform/commit/01ce237388d7e036eb9492d6c08e581bd485cb9f))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Fix ui-widgets npm-publish drift+race: self-heal dev version from npm 'next' dist-tag, retry the just-published widget install for registry propagation so commit-back lands; realign develop to 1.1.6-dev.1 ([`688ec49`](https://github.com/OpenG2P/registry-platform/commit/688ec4941c3b085d75217f077c495949888fc531))

### Since last release (v1.0.0)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Chart: make the IAM tile name values-driven (iamRegister.applicationDescription via __APPLICATION_DESCRIPTION__) so a wrapper chart can set it, and fix the reference registry's id-generator idTypes (farmer -> individual) so its Individual register actually gets a functional-ID pool ([`01ce237`](https://github.com/OpenG2P/registry-platform/commit/01ce237388d7e036eb9492d6c08e581bd485cb9f))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Fix ui-widgets npm-publish drift+race: self-heal dev version from npm 'next' dist-tag, retry the just-published widget install for registry propagation so commit-back lands; realign develop to 1.1.6-dev.1 ([`688ec49`](https://github.com/OpenG2P/registry-platform/commit/688ec4941c3b085d75217f077c495949888fc531))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Fix ui-widgets npm publish collision: bump develop version 1.1.4-dev.3 → 1.1.6-dev.0 (ahead of released 1.1.5) so the dev prerelease no longer republishes an existing version ([`bc4a341`](https://github.com/OpenG2P/registry-platform/commit/bc4a341cd8f862cd71bddd985ec0d86f66b1902f))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: stop build-publish on Dependabot branches (exclude !dependabot/**); add lightweight ui-ci PR check (npm type-check+build, no publish) for the UI packages ([`0364f07`](https://github.com/OpenG2P/registry-platform/commit/0364f0759eb6097e95ce888256b4f8bdba6212cd))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: single build-publish workflow for all images+chart at one locked version — fold staff-ui in (own context), add staffUi+sanity to chart-image-paths, drop separate docker-staff-portal-ui.yml ([`aebd339`](https://github.com/OpenG2P/registry-platform/commit/aebd3399642c4b65bd90c9e354c3d374bc60974b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry cleanup: remove broken/unused inbound message-rule seed, de-NSR (templates→individual_to_dci, registry name, master-data URLs), correct Dockerfile/README comments to the runnable reference-registry + Option-C model ([`d7139ea`](https://github.com/OpenG2P/registry-platform/commit/d7139ea1bb36a12681daa5805cfb16a80d747d50))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e logs: clean titled per-test banner + timestamped step lines + RESULT footer; suppress httpx and pytest live-log noise (drop log_cli, run with -s) ([`c72eb16`](https://github.com/OpenG2P/registry-platform/commit/c72eb16907af882b891ecb4866e46c744faaf2b0))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: history test reads g2p_register_history_individuals (last farmer-table ref); reference e2e now fully green (DCI + change-request/AWE) ([`d424e68`](https://github.com/OpenG2P/registry-platform/commit/d424e68853f2359035aaed506a8e9d1a60229a46))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: fix ScopeMismatch — use a plain logger (not the function-scoped step fixture) inside the module-scoped change_request fixture ([`d6399e7`](https://github.com/OpenG2P/registry-platform/commit/d6399e79eacebe7e4bfcc3148aa8427928af12b4))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference AWE seed collision-tolerant: split individual vs household groups with ON CONFLICT DO NOTHING so the individual change_request policy+stages always seed even when a shared AWE DB already has registry.change_request.household from another registry ([`b15861f`](https://github.com/OpenG2P/registry-platform/commit/b15861f3b494ebca04d26a97b3994fbb3aa67689))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference DCI seed to core schema (documents/data_models/outgoing_templates) so DCI search resolves the Individual template; add timestamped per-test step logging (DCI + change-request/AWE stages) ([`d171513`](https://github.com/OpenG2P/registry-platform/commit/d17151398c368b7dc6394a2f2ec92d549fbc8f8b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity CR e2e: target reference individual UI tab/section + individuals table for the change-request test ([`749f91f`](https://github.com/OpenG2P/registry-platform/commit/749f91ff5b878ccd6b66da446c58489baa0ca805))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity DCI e2e: read name/birth_date directly under demographic_info (reference DCI-standard template shape) ([`877d833`](https://github.com/OpenG2P/registry-platform/commit/877d83337e5961d413578a4a66e7df3619d327f3))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e: point reference sanity suite at individual register (data_seed table, register id, DCI scopes/type) so e2e runs against the reference registry ([`3f8b410`](https://github.com/OpenG2P/registry-platform/commit/3f8b410ecb81d896d3172295bed70e642d0cc87b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry db-seed green: minimal seed with demo-data loaders (sample/geo/images/templates) defaulted OFF in base chart, farmer overlay re-enables; add openg2p-registry-sanity-tests image + e2e suite + CI entry ([`1476fbb`](https://github.com/OpenG2P/registry-platform/commit/1476fbb1dc89769c7139f83324f0ecce95a024e8))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry + naming cleanup: RP images are runnable reference registries (individual+household from NSR), env-selected extension (Option C), staff-api/bene-api/celery-*/staff-ui rename, single openg2p-registry chart; farmer extends via REGISTRY_EXTENSION_MODULE ([`db42ba2`](https://github.com/OpenG2P/registry-platform/commit/db42ba21748d16f714506f157779bd0006c1cba6))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Invert build model: registry-platform publishes base images + Helm chart, farmer-registry extends ([`53d580c`](https://github.com/OpenG2P/registry-platform/commit/53d580c0d8e454996e559fb34a7450b4790ba2ae))
- chore(ui-widgets): version for npm next publish, sync staff-portal-ui @1.1.4-dev.3 [skip ci] ([`4e4548b`](https://github.com/OpenG2P/registry-platform/commit/4e4548b3fb2e645191fd660836fd2d7b674097fe))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`c73493f`](https://github.com/OpenG2P/registry-platform/commit/c73493fd9c9990fe57ee36b28461aba944bcaf17))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking (kind: library) ([`532a3f9`](https://github.com/OpenG2P/registry-platform/commit/532a3f96341f56c3438421fa984bbc807292f1dc))
- [G2P-5375](https://openg2p.atlassian.net/browse/G2P-5375) Update @openg2p/registry-widgets version to 1.1.4 ([`c0331db`](https://github.com/OpenG2P/registry-platform/commit/c0331db71aa8c9af8fdc38643bcc8e7cc58898b7))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: update buildSectionsDataMap return type - change return type to always return an object ([`b010347`](https://github.com/OpenG2P/registry-platform/commit/b010347a6f87170f3975f417e30bdcd7937821ee))
- updating the ui widget develop tag 1.1.4-dev.2 in the staff portal ui ([`08cb976`](https://github.com/OpenG2P/registry-platform/commit/08cb976ce5d3172f4c82a8ac2a5bf5eb75eced47))
- updating the ui widget develop tag in the staff portal ui ([`5bb768f`](https://github.com/OpenG2P/registry-platform/commit/5bb768fa8c60e7d83e1c9d1019ffe603174f5725))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update file rendering for change request header, submission header, and DocsWidget ([`e103a51`](https://github.com/OpenG2P/registry-platform/commit/e103a518aa0ff0d25ee5896b1e9ed6bbe375f9e4))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(intake_form_register): dedupe document ingestion by register - update document retrieval to group by register - adjust document processing to use register-level sections - enhance logging for missing section references ([`5eaaf0c`](https://github.com/OpenG2P/registry-platform/commit/5eaaf0cb28c6bb165363ede1741a91752bf8fb09))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) chore(helper): remove unused MinioClient import ([`93630f0`](https://github.com/OpenG2P/registry-platform/commit/93630f0813c7892332faf88d9f0aaf91eed555f4))
- updating the ui widget tag in the staff portal ui ([`13ca764`](https://github.com/OpenG2P/registry-platform/commit/13ca76482e411b901e97a294e7868bc84f9cb1c6))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(enum): restore entry in ChangeRequestSourceEnum ([`4d7ff96`](https://github.com/OpenG2P/registry-platform/commit/4d7ff96e277eef3e77444856a9154f08ac92ec2f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor(geo-hierarchy): enhance layout and widget handling ([`46317cf`](https://github.com/OpenG2P/registry-platform/commit/46317cf8a7193859eeac8961974935085456857f))
- fix(g2p_register): handle geo hierarchy service absence gracefully ([`9fcf214`](https://github.com/OpenG2P/registry-platform/commit/9fcf214da6ae5b40a706f501a94d249d1776dba5))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(service): streamline document handling on change approval ([`eb99cf3`](https://github.com/OpenG2P/registry-platform/commit/eb99cf322e02386f0b55cf2acd4828ab69d737bf))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(service): add record image URLs to change request data ([`860817e`](https://github.com/OpenG2P/registry-platform/commit/860817e82a27173ba101a7245c11dc2c70222854))
- [G2P-5330](https://openg2p.atlassian.net/browse/G2P-5330) fix(controller): remove permissions for upload and delete documents ([`ee6528a`](https://github.com/OpenG2P/registry-platform/commit/ee6528a6ab92b9992aae536417ec46eb33aef20f))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) fix(model): simplify created_at field by removing timezone support and using utcnow ([`fbaae54`](https://github.com/OpenG2P/registry-platform/commit/fbaae549dac2aacb3c33b8e484584454cd1ec201))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: preview url issue for HeaderSectionWidget ([`512c3f5`](https://github.com/OpenG2P/registry-platform/commit/512c3f56338338f09a272b4e5f9da370a979de0a))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: refetch approval status after decision and split approval hooks ([`fc0cec9`](https://github.com/OpenG2P/registry-platform/commit/fc0cec9c6397df2398232da4297af1e908386a09))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update geo hierarchy and document handling ([`91edd25`](https://github.com/OpenG2P/registry-platform/commit/91edd25d5f914b95a705d39d4798c204adef4808))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update register and intake form document handling ([`24009ab`](https://github.com/OpenG2P/registry-platform/commit/24009ab9cf81d514b80355557d0e60bf623d75b4))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: rename template_file_id to template_document_id across the application ([`cf1e75d`](https://github.com/OpenG2P/registry-platform/commit/cf1e75df4a98a8281f25d18bbb6fd8689afcb06f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): ensure created_at uses timezone-aware DateTime ([`ed8df39`](https://github.com/OpenG2P/registry-platform/commit/ed8df39a39859cce4b48826afc15b626fc6dc07d))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) chore: update ui-widgets to v1.1.3 ([`f8adc49`](https://github.com/OpenG2P/registry-platform/commit/f8adc49a10b4ae2ad1e0c154a2630f5f8a41162d))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(minio): update bucket handling to use StrEnum directly ([`3140005`](https://github.com/OpenG2P/registry-platform/commit/3140005bd027d2d387a673e70bcdbaae275f78d5))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): update bucket column type to Enum - change bucket column from String to Enum for DocumentBucket - adjust default value for bucket to use Enum directly ([`d9b49b7`](https://github.com/OpenG2P/registry-platform/commit/d9b49b7645ed77a75fec0fae2c56893b89544465))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(helper): correct import path for DocumentBucket ([`d0359fd`](https://github.com/OpenG2P/registry-platform/commit/d0359fd27cf924b3bfcdb437d3007288df544cb3))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(controller): unify error response handling for new document controller ([`737c444`](https://github.com/OpenG2P/registry-platform/commit/737c44447b063627e145377e8d8800c17bfd23eb))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(errors): update error handling to use new default error code ([`69ad5ee`](https://github.com/OpenG2P/registry-platform/commit/69ad5ee2fad88b69b1b2f1920db9e70b8b2948fb))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) refactor: update docs widget configuration to use 'widget-total-docs' and enhance column distribution logic ([`cd85f91`](https://github.com/OpenG2P/registry-platform/commit/cd85f9156c45e66d8c93f78327f218b35711f2b9))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: remove fixed layout configuration from geo hierarchy widget and improve column distribution logic ([`1cb6017`](https://github.com/OpenG2P/registry-platform/commit/1cb6017df8a6850b02801a0e8e9df13ee0b78c6b))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(documents): add dashboard image validation profile ([`142b0f2`](https://github.com/OpenG2P/registry-platform/commit/142b0f27ca95e5b50bd490f51dbdd33a007ea91a))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) feat(documents): enhance file validation and upload profiles ([`1b4581b`](https://github.com/OpenG2P/registry-platform/commit/1b4581bc20b9a74727ce9ddb165c24f95db18880))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(icons): enhance file validation for uploads ([`d459348`](https://github.com/OpenG2P/registry-platform/commit/d459348825030d5b898f489bd6be29c2f586d512))
- [G2P-5334](https://openg2p.atlassian.net/browse/G2P-5334) Remove dash from new intake form breadcrumb ([`3520034`](https://github.com/OpenG2P/registry-platform/commit/3520034cf157cfec9e5d7f0497319657d7332309))
- [G2P-5332](https://openg2p.atlassian.net/browse/G2P-5332) add register icon remove button ([`b4a2d47`](https://github.com/OpenG2P/registry-platform/commit/b4a2d47725861e6db6a10a4e24786c7f76b464dd))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) add docs widget ([`66aed2a`](https://github.com/OpenG2P/registry-platform/commit/66aed2a4cf094a820d51ba1bdbf84452678f0252))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and request response ([`595e7dc`](https://github.com/OpenG2P/registry-platform/commit/595e7dcf3374fa4b7cad04c3a82738604bc7d779))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve geo location, requestDataSourceHandler, and translation handling ([`9117fe8`](https://github.com/OpenG2P/registry-platform/commit/9117fe885fcafca9ba7aab3305c21426cc64d8ad))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) fix: template file upload size and type ([`8dbcb73`](https://github.com/OpenG2P/registry-platform/commit/8dbcb736bbc42de6c5d159c9b341c891472f8c70))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix: update 1MB image upload limit for logo, favicon, and register icon ([`fd6a81d`](https://github.com/OpenG2P/registry-platform/commit/fd6a81de7a737212dd6725b645d04f87cdcbca56))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update environment variables and streamline document handling ([`b0c2e53`](https://github.com/OpenG2P/registry-platform/commit/b0c2e53b0e641f7d082e97acb0bc7507d21d30b4))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and configurations for celery queue tasks ([`40fdc64`](https://github.com/OpenG2P/registry-platform/commit/40fdc644350c9959b319594ea4844f2fa3ddef01))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): streamline document handling in apis and remove template file controller ([`fd5666e`](https://github.com/OpenG2P/registry-platform/commit/fd5666e57c7a88f85b15cadb81016cfb02892c4b))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) ([`14ae7bd`](https://github.com/OpenG2P/registry-platform/commit/14ae7bde33b24bd2513e1e68e45f48b585ea2185))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(documents): streamline document handling and update schemas ([`09f5306`](https://github.com/OpenG2P/registry-platform/commit/09f53060963e5f18e09f93d8911b410a0f4d9c0f))
- [G2P-5306](https://openg2p.atlassian.net/browse/G2P-5306) refactor(document): restructure document handling and abstract MinioClient ([`7ba5cbe`](https://github.com/OpenG2P/registry-platform/commit/7ba5cbebc018f20091d6b7002e20b7d162ed4f91))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(models): update document handling in data models ([`c20ccd8`](https://github.com/OpenG2P/registry-platform/commit/c20ccd825362ac9ddc430c20994ebe40d8b3c944))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Permission decorated enabled on one API. ([`e11e8fe`](https://github.com/OpenG2P/registry-platform/commit/e11e8fe14d717636da5cc8cd1c3d16694db57cca))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Restrict config nav to CONFIG_NAV_ACTIONS and guard config sub-pages ([`aaca369`](https://github.com/OpenG2P/registry-platform/commit/aaca36983e9e86dea39674c0167371253006d4ab))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) refactor: update attribute value fetching in AttributeValueInput component ([`02ddbfb`](https://github.com/OpenG2P/registry-platform/commit/02ddbfbc08b854a9fe3357a6e1071d6adbfd67f8))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`7d798a4`](https://github.com/OpenG2P/registry-platform/commit/7d798a430fb4ae254fdd749ed06b766bff8f2fc7))
- changed the widget version and published the dev ([`f2ef6ab`](https://github.com/OpenG2P/registry-platform/commit/f2ef6ab88262300981abdd7530de65c914f304a8))
- [G2P-5271](https://openg2p.atlassian.net/browse/G2P-5271) Update version to 1.1.0 across all modules ([`60f853d`](https://github.com/OpenG2P/registry-platform/commit/60f853de9f4007f98f9e8619e22f8f34804c89fb))
- [G2P-5181](https://openg2p.atlassian.net/browse/G2P-5181): Record Level Access - Approach using BaseRepository with Generics T ([`1ab3f52`](https://github.com/OpenG2P/registry-platform/commit/1ab3f527730353e97b6b5657cd51a9c9496db317))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Consent and partner management related. ([`873f96a`](https://github.com/OpenG2P/registry-platform/commit/873f96aa7c2624e5bcee3ca51df344d659f6cdd2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancements for consent management, partner management and WJS support. ([`a9ba084`](https://github.com/OpenG2P/registry-platform/commit/a9ba084b7654de83842e97cbf3c8f4f29ec6edd4))
- 'develop' version was incorrect in init.py. Changed to 0.0.0-dev0 ([`3dd3947`](https://github.com/OpenG2P/registry-platform/commit/3dd3947aeb10293855202d76696c408beaa727e3))
- [G2P-5267](https://openg2p.atlassian.net/browse/G2P-5267) rename attribute labels to reference data ([`37aee91`](https://github.com/OpenG2P/registry-platform/commit/37aee9110037cee04cd676cd88211bc4e9a428a3))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: add new data policy management features for administrative areas and reference data ([`533420a`](https://github.com/OpenG2P/registry-platform/commit/533420afb69b95229ec51ce796ea4d37a2739497))
- [G2P-5265](https://openg2p.atlassian.net/browse/G2P-5265) feat(intake): add configurable reference generator ([`55cf95d`](https://github.com/OpenG2P/registry-platform/commit/55cf95dd473eda2885cce6a1a03439b0b6684eba))
- [G2P-5263](https://openg2p.atlassian.net/browse/G2P-5263) Update breadcrumbs for register and intake form pages ([`dad3970`](https://github.com/OpenG2P/registry-platform/commit/dad39709fb54a307b61dbf7f5c58d85412d24b56))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: extend data policy to handle new policy target ([`faef96b`](https://github.com/OpenG2P/registry-platform/commit/faef96bdd783349c7553b2a77a2d89a9b9f4f65b))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Refactor AWE proxy request handling to support pagination and improve payload resolution ([`364cce2`](https://github.com/OpenG2P/registry-platform/commit/364cce2cefd2cd93d50aa4365f0f90ac3e2c5e69))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122) cleanup: remove unused change request approval code ([`f538140`](https://github.com/OpenG2P/registry-platform/commit/f53814018f7158da6f9aec58d2a6a2fbc88cd8be))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122): add approvals list ([`b64eda0`](https://github.com/OpenG2P/registry-platform/commit/b64eda0920c70c29ebaead9eb2a128a66cf82255))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`1f8c663`](https://github.com/OpenG2P/registry-platform/commit/1f8c663d3a0ded1841efd87e9a1c96ea1be3ecda))
- [G2P-5178](https://openg2p.atlassian.net/browse/G2P-5178) feat(attribute-service): add search functionality for attributes and values ([`78f2d13`](https://github.com/OpenG2P/registry-platform/commit/78f2d1328420dcf731b70ae55dd6e3fd708422e1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) feat: support logo within text and registry favicon ([`8ba88a2`](https://github.com/OpenG2P/registry-platform/commit/8ba88a28e6032f68299432f52d3f8b98285e8935))
- [G2P-5247](https://openg2p.atlassian.net/browse/G2P-5247) Add request_id to VersionForDateData and update G2PRegisterService to populate it from change requests ([`f31d5b8`](https://github.com/OpenG2P/registry-platform/commit/f31d5b89ea0e5fb954d2f4af871bb5217136e110))
- [G2P-5245](https://openg2p.atlassian.net/browse/G2P-5245) feat(application-reference): add application reference field, its generation, usage and update api ([`a2a9ece`](https://github.com/OpenG2P/registry-platform/commit/a2a9eced23a584ccb43ba87568aa1a961721f162))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve UI widgets and add example UI schema reference ([`866ed7a`](https://github.com/OpenG2P/registry-platform/commit/866ed7ace683f1e752d42f5c460e409ffd190ec1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add cookieDomain to environment configuration and update auth cookie handling ([`bffa646`](https://github.com/OpenG2P/registry-platform/commit/bffa64684394f29747f74f1722024a479f6d28a2))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add assignee_name field to ApprovalTask model and update related logic ([`5648eb2`](https://github.com/OpenG2P/registry-platform/commit/5648eb2f95bb7f5cb59be06a053ce8d45fe5751c))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add upgrade-insecure-requests to CSP header ([`71c5085`](https://github.com/OpenG2P/registry-platform/commit/71c5085cfc1067bf45bfe3cdd8d9ac61ea241034))
- [G2P-5182](https://openg2p.atlassian.net/browse/G2P-5182) fix: boolean conditional visibility, dialog-table conditions, and attribute API hooks ([`48f4136`](https://github.com/OpenG2P/registry-platform/commit/48f41364aa11ad02e80cbe204f55b82d95af804e))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Fix: rollback CR changes when terminal approval validation fails ([`8868209`](https://github.com/OpenG2P/registry-platform/commit/88682099c356820fa9ab71d1ec9d038b924c3a01))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add list_tasks_for_request endpoint and related functionality ([`0ac9dce`](https://github.com/OpenG2P/registry-platform/commit/0ac9dcee872d2c270f30804d0acc67b2838a1109))
- [G2P-5219](https://openg2p.atlassian.net/browse/G2P-5219) feat(change-request): add pre-approve hook for change requests ([`1f236ae`](https://github.com/OpenG2P/registry-platform/commit/1f236ae68f75f6aebf011c910f7a811b09f5f19c))
- fix: correct variable name in G2PRegistrantAuthenticationControllerService ([`20ba84f`](https://github.com/OpenG2P/registry-platform/commit/20ba84fee15e14e4f6d35554430e8ed4ad75a1b1))
- [G2P-5208](https://openg2p.atlassian.net/browse/G2P-5208) refactor(intake-form): simplify submission search logic ([`b7fd7e9`](https://github.com/OpenG2P/registry-platform/commit/b7fd7e9aa82ff75c660e747bda6da11ecbb5635b))
- [G2P-5206](https://openg2p.atlassian.net/browse/G2P-5206) refactor(models): remove deprecated G2PIntakeFormSectionPayload class ([`fffbde9`](https://github.com/OpenG2P/registry-platform/commit/fffbde9a586f5124b1556876ca6ae315251db39d))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`5e43850`](https://github.com/OpenG2P/registry-platform/commit/5e43850944e58926167dc1282f71cd4be0d40582))
- [G2P-5194](https://openg2p.atlassian.net/browse/G2P-5194) - changed version to develop in develop branch ([`26a1690`](https://github.com/OpenG2P/registry-platform/commit/26a16900553e77ed314248de8530311b8f61b75c))
- [G2P-5183](https://openg2p.atlassian.net/browse/G2P-5183) Add client-side CSRF token handling ([`e9b48ad`](https://github.com/OpenG2P/registry-platform/commit/e9b48ad4fb1dc808a474b01c5aa09fa70aadeb70))
- [G2P-5154](https://openg2p.atlassian.net/browse/G2P-5154) Update environment variables, and refactor logout handling ([`cbead27`](https://github.com/OpenG2P/registry-platform/commit/cbead274b7c0a43f2e81d7b29c7e8e45a6047c1e))
- [G2P-5153](https://openg2p.atlassian.net/browse/G2P-5153) Refactor IAM permission handling and authentication cookie management ([`8a6abe5`](https://github.com/OpenG2P/registry-platform/commit/8a6abe5de479bf2647f89b31fbfa62989114ef3e))

<a id="v-0-0-0-develop-286"></a>

## registry-platform — develop 0.0.0-develop.286 (2026-07-22)

_commit `bc4a341` · baseline: release v1.0.0 · previous build 0.0.0-develop.285_
<!-- build:0.0.0-develop.286 revision:bc4a341cd8f862cd71bddd985ec0d86f66b1902f ts:1784721315 -->

### Summary

_All changes since release v1.0.0:_

- **Major:** CI/CD improvements: unified build-publish workflow for all images and charts, added lightweight PR checks for UI packages, and excluded Dependabot branches from builds.
- Reference registry enhancements: cleaned up unused message-rule seeds, updated Dockerfile comments, and ensured DCI search resolves the Individual template.
- Sanity testing improvements: enhanced e2e logs with structured output, fixed ScopeMismatch issues, and ensured full pass for reference e2e tests.
- Document handling refactor: streamlined document ingestion and retrieval processes, updated schemas, and improved error handling across document-related APIs.
- Feature additions: implemented configurable reference generators, enhanced file validation profiles, and added support for application references and CSRF token handling.
- UI/UX updates: improved layout and handling of geo hierarchy widgets, updated breadcrumbs for forms, and added new icons for registers.
- Dependency updates: bumped versions for @openg2p/registry-widgets and ui-widgets, ensuring compatibility and feature enhancements.
- Cleanup and refactoring: removed deprecated code, optimized attribute fetching, and improved logging for document processing.

### New in this build (since 0.0.0-develop.285)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Fix ui-widgets npm publish collision: bump develop version 1.1.4-dev.3 → 1.1.6-dev.0 (ahead of released 1.1.5) so the dev prerelease no longer republishes an existing version ([`bc4a341`](https://github.com/OpenG2P/registry-platform/commit/bc4a341cd8f862cd71bddd985ec0d86f66b1902f))

### Since last release (v1.0.0)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Fix ui-widgets npm publish collision: bump develop version 1.1.4-dev.3 → 1.1.6-dev.0 (ahead of released 1.1.5) so the dev prerelease no longer republishes an existing version ([`bc4a341`](https://github.com/OpenG2P/registry-platform/commit/bc4a341cd8f862cd71bddd985ec0d86f66b1902f))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: stop build-publish on Dependabot branches (exclude !dependabot/**); add lightweight ui-ci PR check (npm type-check+build, no publish) for the UI packages ([`0364f07`](https://github.com/OpenG2P/registry-platform/commit/0364f0759eb6097e95ce888256b4f8bdba6212cd))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: single build-publish workflow for all images+chart at one locked version — fold staff-ui in (own context), add staffUi+sanity to chart-image-paths, drop separate docker-staff-portal-ui.yml ([`aebd339`](https://github.com/OpenG2P/registry-platform/commit/aebd3399642c4b65bd90c9e354c3d374bc60974b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry cleanup: remove broken/unused inbound message-rule seed, de-NSR (templates→individual_to_dci, registry name, master-data URLs), correct Dockerfile/README comments to the runnable reference-registry + Option-C model ([`d7139ea`](https://github.com/OpenG2P/registry-platform/commit/d7139ea1bb36a12681daa5805cfb16a80d747d50))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e logs: clean titled per-test banner + timestamped step lines + RESULT footer; suppress httpx and pytest live-log noise (drop log_cli, run with -s) ([`c72eb16`](https://github.com/OpenG2P/registry-platform/commit/c72eb16907af882b891ecb4866e46c744faaf2b0))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: history test reads g2p_register_history_individuals (last farmer-table ref); reference e2e now fully green (DCI + change-request/AWE) ([`d424e68`](https://github.com/OpenG2P/registry-platform/commit/d424e68853f2359035aaed506a8e9d1a60229a46))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: fix ScopeMismatch — use a plain logger (not the function-scoped step fixture) inside the module-scoped change_request fixture ([`d6399e7`](https://github.com/OpenG2P/registry-platform/commit/d6399e79eacebe7e4bfcc3148aa8427928af12b4))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference AWE seed collision-tolerant: split individual vs household groups with ON CONFLICT DO NOTHING so the individual change_request policy+stages always seed even when a shared AWE DB already has registry.change_request.household from another registry ([`b15861f`](https://github.com/OpenG2P/registry-platform/commit/b15861f3b494ebca04d26a97b3994fbb3aa67689))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference DCI seed to core schema (documents/data_models/outgoing_templates) so DCI search resolves the Individual template; add timestamped per-test step logging (DCI + change-request/AWE stages) ([`d171513`](https://github.com/OpenG2P/registry-platform/commit/d17151398c368b7dc6394a2f2ec92d549fbc8f8b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity CR e2e: target reference individual UI tab/section + individuals table for the change-request test ([`749f91f`](https://github.com/OpenG2P/registry-platform/commit/749f91ff5b878ccd6b66da446c58489baa0ca805))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity DCI e2e: read name/birth_date directly under demographic_info (reference DCI-standard template shape) ([`877d833`](https://github.com/OpenG2P/registry-platform/commit/877d83337e5961d413578a4a66e7df3619d327f3))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e: point reference sanity suite at individual register (data_seed table, register id, DCI scopes/type) so e2e runs against the reference registry ([`3f8b410`](https://github.com/OpenG2P/registry-platform/commit/3f8b410ecb81d896d3172295bed70e642d0cc87b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry db-seed green: minimal seed with demo-data loaders (sample/geo/images/templates) defaulted OFF in base chart, farmer overlay re-enables; add openg2p-registry-sanity-tests image + e2e suite + CI entry ([`1476fbb`](https://github.com/OpenG2P/registry-platform/commit/1476fbb1dc89769c7139f83324f0ecce95a024e8))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry + naming cleanup: RP images are runnable reference registries (individual+household from NSR), env-selected extension (Option C), staff-api/bene-api/celery-*/staff-ui rename, single openg2p-registry chart; farmer extends via REGISTRY_EXTENSION_MODULE ([`db42ba2`](https://github.com/OpenG2P/registry-platform/commit/db42ba21748d16f714506f157779bd0006c1cba6))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Invert build model: registry-platform publishes base images + Helm chart, farmer-registry extends ([`53d580c`](https://github.com/OpenG2P/registry-platform/commit/53d580c0d8e454996e559fb34a7450b4790ba2ae))
- chore(ui-widgets): version for npm next publish, sync staff-portal-ui @1.1.4-dev.3 [skip ci] ([`4e4548b`](https://github.com/OpenG2P/registry-platform/commit/4e4548b3fb2e645191fd660836fd2d7b674097fe))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`c73493f`](https://github.com/OpenG2P/registry-platform/commit/c73493fd9c9990fe57ee36b28461aba944bcaf17))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking (kind: library) ([`532a3f9`](https://github.com/OpenG2P/registry-platform/commit/532a3f96341f56c3438421fa984bbc807292f1dc))
- [G2P-5375](https://openg2p.atlassian.net/browse/G2P-5375) Update @openg2p/registry-widgets version to 1.1.4 ([`c0331db`](https://github.com/OpenG2P/registry-platform/commit/c0331db71aa8c9af8fdc38643bcc8e7cc58898b7))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: update buildSectionsDataMap return type - change return type to always return an object ([`b010347`](https://github.com/OpenG2P/registry-platform/commit/b010347a6f87170f3975f417e30bdcd7937821ee))
- updating the ui widget develop tag 1.1.4-dev.2 in the staff portal ui ([`08cb976`](https://github.com/OpenG2P/registry-platform/commit/08cb976ce5d3172f4c82a8ac2a5bf5eb75eced47))
- updating the ui widget develop tag in the staff portal ui ([`5bb768f`](https://github.com/OpenG2P/registry-platform/commit/5bb768fa8c60e7d83e1c9d1019ffe603174f5725))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update file rendering for change request header, submission header, and DocsWidget ([`e103a51`](https://github.com/OpenG2P/registry-platform/commit/e103a518aa0ff0d25ee5896b1e9ed6bbe375f9e4))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(intake_form_register): dedupe document ingestion by register - update document retrieval to group by register - adjust document processing to use register-level sections - enhance logging for missing section references ([`5eaaf0c`](https://github.com/OpenG2P/registry-platform/commit/5eaaf0cb28c6bb165363ede1741a91752bf8fb09))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) chore(helper): remove unused MinioClient import ([`93630f0`](https://github.com/OpenG2P/registry-platform/commit/93630f0813c7892332faf88d9f0aaf91eed555f4))
- updating the ui widget tag in the staff portal ui ([`13ca764`](https://github.com/OpenG2P/registry-platform/commit/13ca76482e411b901e97a294e7868bc84f9cb1c6))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(enum): restore entry in ChangeRequestSourceEnum ([`4d7ff96`](https://github.com/OpenG2P/registry-platform/commit/4d7ff96e277eef3e77444856a9154f08ac92ec2f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor(geo-hierarchy): enhance layout and widget handling ([`46317cf`](https://github.com/OpenG2P/registry-platform/commit/46317cf8a7193859eeac8961974935085456857f))
- fix(g2p_register): handle geo hierarchy service absence gracefully ([`9fcf214`](https://github.com/OpenG2P/registry-platform/commit/9fcf214da6ae5b40a706f501a94d249d1776dba5))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(service): streamline document handling on change approval ([`eb99cf3`](https://github.com/OpenG2P/registry-platform/commit/eb99cf322e02386f0b55cf2acd4828ab69d737bf))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(service): add record image URLs to change request data ([`860817e`](https://github.com/OpenG2P/registry-platform/commit/860817e82a27173ba101a7245c11dc2c70222854))
- [G2P-5330](https://openg2p.atlassian.net/browse/G2P-5330) fix(controller): remove permissions for upload and delete documents ([`ee6528a`](https://github.com/OpenG2P/registry-platform/commit/ee6528a6ab92b9992aae536417ec46eb33aef20f))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) fix(model): simplify created_at field by removing timezone support and using utcnow ([`fbaae54`](https://github.com/OpenG2P/registry-platform/commit/fbaae549dac2aacb3c33b8e484584454cd1ec201))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: preview url issue for HeaderSectionWidget ([`512c3f5`](https://github.com/OpenG2P/registry-platform/commit/512c3f56338338f09a272b4e5f9da370a979de0a))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: refetch approval status after decision and split approval hooks ([`fc0cec9`](https://github.com/OpenG2P/registry-platform/commit/fc0cec9c6397df2398232da4297af1e908386a09))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update geo hierarchy and document handling ([`91edd25`](https://github.com/OpenG2P/registry-platform/commit/91edd25d5f914b95a705d39d4798c204adef4808))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update register and intake form document handling ([`24009ab`](https://github.com/OpenG2P/registry-platform/commit/24009ab9cf81d514b80355557d0e60bf623d75b4))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: rename template_file_id to template_document_id across the application ([`cf1e75d`](https://github.com/OpenG2P/registry-platform/commit/cf1e75df4a98a8281f25d18bbb6fd8689afcb06f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): ensure created_at uses timezone-aware DateTime ([`ed8df39`](https://github.com/OpenG2P/registry-platform/commit/ed8df39a39859cce4b48826afc15b626fc6dc07d))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) chore: update ui-widgets to v1.1.3 ([`f8adc49`](https://github.com/OpenG2P/registry-platform/commit/f8adc49a10b4ae2ad1e0c154a2630f5f8a41162d))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(minio): update bucket handling to use StrEnum directly ([`3140005`](https://github.com/OpenG2P/registry-platform/commit/3140005bd027d2d387a673e70bcdbaae275f78d5))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): update bucket column type to Enum - change bucket column from String to Enum for DocumentBucket - adjust default value for bucket to use Enum directly ([`d9b49b7`](https://github.com/OpenG2P/registry-platform/commit/d9b49b7645ed77a75fec0fae2c56893b89544465))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(helper): correct import path for DocumentBucket ([`d0359fd`](https://github.com/OpenG2P/registry-platform/commit/d0359fd27cf924b3bfcdb437d3007288df544cb3))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(controller): unify error response handling for new document controller ([`737c444`](https://github.com/OpenG2P/registry-platform/commit/737c44447b063627e145377e8d8800c17bfd23eb))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(errors): update error handling to use new default error code ([`69ad5ee`](https://github.com/OpenG2P/registry-platform/commit/69ad5ee2fad88b69b1b2f1920db9e70b8b2948fb))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) refactor: update docs widget configuration to use 'widget-total-docs' and enhance column distribution logic ([`cd85f91`](https://github.com/OpenG2P/registry-platform/commit/cd85f9156c45e66d8c93f78327f218b35711f2b9))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: remove fixed layout configuration from geo hierarchy widget and improve column distribution logic ([`1cb6017`](https://github.com/OpenG2P/registry-platform/commit/1cb6017df8a6850b02801a0e8e9df13ee0b78c6b))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(documents): add dashboard image validation profile ([`142b0f2`](https://github.com/OpenG2P/registry-platform/commit/142b0f27ca95e5b50bd490f51dbdd33a007ea91a))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) feat(documents): enhance file validation and upload profiles ([`1b4581b`](https://github.com/OpenG2P/registry-platform/commit/1b4581bc20b9a74727ce9ddb165c24f95db18880))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(icons): enhance file validation for uploads ([`d459348`](https://github.com/OpenG2P/registry-platform/commit/d459348825030d5b898f489bd6be29c2f586d512))
- [G2P-5334](https://openg2p.atlassian.net/browse/G2P-5334) Remove dash from new intake form breadcrumb ([`3520034`](https://github.com/OpenG2P/registry-platform/commit/3520034cf157cfec9e5d7f0497319657d7332309))
- [G2P-5332](https://openg2p.atlassian.net/browse/G2P-5332) add register icon remove button ([`b4a2d47`](https://github.com/OpenG2P/registry-platform/commit/b4a2d47725861e6db6a10a4e24786c7f76b464dd))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) add docs widget ([`66aed2a`](https://github.com/OpenG2P/registry-platform/commit/66aed2a4cf094a820d51ba1bdbf84452678f0252))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and request response ([`595e7dc`](https://github.com/OpenG2P/registry-platform/commit/595e7dcf3374fa4b7cad04c3a82738604bc7d779))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve geo location, requestDataSourceHandler, and translation handling ([`9117fe8`](https://github.com/OpenG2P/registry-platform/commit/9117fe885fcafca9ba7aab3305c21426cc64d8ad))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) fix: template file upload size and type ([`8dbcb73`](https://github.com/OpenG2P/registry-platform/commit/8dbcb736bbc42de6c5d159c9b341c891472f8c70))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix: update 1MB image upload limit for logo, favicon, and register icon ([`fd6a81d`](https://github.com/OpenG2P/registry-platform/commit/fd6a81de7a737212dd6725b645d04f87cdcbca56))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update environment variables and streamline document handling ([`b0c2e53`](https://github.com/OpenG2P/registry-platform/commit/b0c2e53b0e641f7d082e97acb0bc7507d21d30b4))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and configurations for celery queue tasks ([`40fdc64`](https://github.com/OpenG2P/registry-platform/commit/40fdc644350c9959b319594ea4844f2fa3ddef01))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): streamline document handling in apis and remove template file controller ([`fd5666e`](https://github.com/OpenG2P/registry-platform/commit/fd5666e57c7a88f85b15cadb81016cfb02892c4b))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) ([`14ae7bd`](https://github.com/OpenG2P/registry-platform/commit/14ae7bde33b24bd2513e1e68e45f48b585ea2185))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(documents): streamline document handling and update schemas ([`09f5306`](https://github.com/OpenG2P/registry-platform/commit/09f53060963e5f18e09f93d8911b410a0f4d9c0f))
- [G2P-5306](https://openg2p.atlassian.net/browse/G2P-5306) refactor(document): restructure document handling and abstract MinioClient ([`7ba5cbe`](https://github.com/OpenG2P/registry-platform/commit/7ba5cbebc018f20091d6b7002e20b7d162ed4f91))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(models): update document handling in data models ([`c20ccd8`](https://github.com/OpenG2P/registry-platform/commit/c20ccd825362ac9ddc430c20994ebe40d8b3c944))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Permission decorated enabled on one API. ([`e11e8fe`](https://github.com/OpenG2P/registry-platform/commit/e11e8fe14d717636da5cc8cd1c3d16694db57cca))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Restrict config nav to CONFIG_NAV_ACTIONS and guard config sub-pages ([`aaca369`](https://github.com/OpenG2P/registry-platform/commit/aaca36983e9e86dea39674c0167371253006d4ab))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) refactor: update attribute value fetching in AttributeValueInput component ([`02ddbfb`](https://github.com/OpenG2P/registry-platform/commit/02ddbfbc08b854a9fe3357a6e1071d6adbfd67f8))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`7d798a4`](https://github.com/OpenG2P/registry-platform/commit/7d798a430fb4ae254fdd749ed06b766bff8f2fc7))
- changed the widget version and published the dev ([`f2ef6ab`](https://github.com/OpenG2P/registry-platform/commit/f2ef6ab88262300981abdd7530de65c914f304a8))
- [G2P-5271](https://openg2p.atlassian.net/browse/G2P-5271) Update version to 1.1.0 across all modules ([`60f853d`](https://github.com/OpenG2P/registry-platform/commit/60f853de9f4007f98f9e8619e22f8f34804c89fb))
- [G2P-5181](https://openg2p.atlassian.net/browse/G2P-5181): Record Level Access - Approach using BaseRepository with Generics T ([`1ab3f52`](https://github.com/OpenG2P/registry-platform/commit/1ab3f527730353e97b6b5657cd51a9c9496db317))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Consent and partner management related. ([`873f96a`](https://github.com/OpenG2P/registry-platform/commit/873f96aa7c2624e5bcee3ca51df344d659f6cdd2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancements for consent management, partner management and WJS support. ([`a9ba084`](https://github.com/OpenG2P/registry-platform/commit/a9ba084b7654de83842e97cbf3c8f4f29ec6edd4))
- 'develop' version was incorrect in init.py. Changed to 0.0.0-dev0 ([`3dd3947`](https://github.com/OpenG2P/registry-platform/commit/3dd3947aeb10293855202d76696c408beaa727e3))
- [G2P-5267](https://openg2p.atlassian.net/browse/G2P-5267) rename attribute labels to reference data ([`37aee91`](https://github.com/OpenG2P/registry-platform/commit/37aee9110037cee04cd676cd88211bc4e9a428a3))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: add new data policy management features for administrative areas and reference data ([`533420a`](https://github.com/OpenG2P/registry-platform/commit/533420afb69b95229ec51ce796ea4d37a2739497))
- [G2P-5265](https://openg2p.atlassian.net/browse/G2P-5265) feat(intake): add configurable reference generator ([`55cf95d`](https://github.com/OpenG2P/registry-platform/commit/55cf95dd473eda2885cce6a1a03439b0b6684eba))
- [G2P-5263](https://openg2p.atlassian.net/browse/G2P-5263) Update breadcrumbs for register and intake form pages ([`dad3970`](https://github.com/OpenG2P/registry-platform/commit/dad39709fb54a307b61dbf7f5c58d85412d24b56))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: extend data policy to handle new policy target ([`faef96b`](https://github.com/OpenG2P/registry-platform/commit/faef96bdd783349c7553b2a77a2d89a9b9f4f65b))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Refactor AWE proxy request handling to support pagination and improve payload resolution ([`364cce2`](https://github.com/OpenG2P/registry-platform/commit/364cce2cefd2cd93d50aa4365f0f90ac3e2c5e69))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122) cleanup: remove unused change request approval code ([`f538140`](https://github.com/OpenG2P/registry-platform/commit/f53814018f7158da6f9aec58d2a6a2fbc88cd8be))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122): add approvals list ([`b64eda0`](https://github.com/OpenG2P/registry-platform/commit/b64eda0920c70c29ebaead9eb2a128a66cf82255))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`1f8c663`](https://github.com/OpenG2P/registry-platform/commit/1f8c663d3a0ded1841efd87e9a1c96ea1be3ecda))
- [G2P-5178](https://openg2p.atlassian.net/browse/G2P-5178) feat(attribute-service): add search functionality for attributes and values ([`78f2d13`](https://github.com/OpenG2P/registry-platform/commit/78f2d1328420dcf731b70ae55dd6e3fd708422e1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) feat: support logo within text and registry favicon ([`8ba88a2`](https://github.com/OpenG2P/registry-platform/commit/8ba88a28e6032f68299432f52d3f8b98285e8935))
- [G2P-5247](https://openg2p.atlassian.net/browse/G2P-5247) Add request_id to VersionForDateData and update G2PRegisterService to populate it from change requests ([`f31d5b8`](https://github.com/OpenG2P/registry-platform/commit/f31d5b89ea0e5fb954d2f4af871bb5217136e110))
- [G2P-5245](https://openg2p.atlassian.net/browse/G2P-5245) feat(application-reference): add application reference field, its generation, usage and update api ([`a2a9ece`](https://github.com/OpenG2P/registry-platform/commit/a2a9eced23a584ccb43ba87568aa1a961721f162))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve UI widgets and add example UI schema reference ([`866ed7a`](https://github.com/OpenG2P/registry-platform/commit/866ed7ace683f1e752d42f5c460e409ffd190ec1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add cookieDomain to environment configuration and update auth cookie handling ([`bffa646`](https://github.com/OpenG2P/registry-platform/commit/bffa64684394f29747f74f1722024a479f6d28a2))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add assignee_name field to ApprovalTask model and update related logic ([`5648eb2`](https://github.com/OpenG2P/registry-platform/commit/5648eb2f95bb7f5cb59be06a053ce8d45fe5751c))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add upgrade-insecure-requests to CSP header ([`71c5085`](https://github.com/OpenG2P/registry-platform/commit/71c5085cfc1067bf45bfe3cdd8d9ac61ea241034))
- [G2P-5182](https://openg2p.atlassian.net/browse/G2P-5182) fix: boolean conditional visibility, dialog-table conditions, and attribute API hooks ([`48f4136`](https://github.com/OpenG2P/registry-platform/commit/48f41364aa11ad02e80cbe204f55b82d95af804e))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Fix: rollback CR changes when terminal approval validation fails ([`8868209`](https://github.com/OpenG2P/registry-platform/commit/88682099c356820fa9ab71d1ec9d038b924c3a01))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add list_tasks_for_request endpoint and related functionality ([`0ac9dce`](https://github.com/OpenG2P/registry-platform/commit/0ac9dcee872d2c270f30804d0acc67b2838a1109))
- [G2P-5219](https://openg2p.atlassian.net/browse/G2P-5219) feat(change-request): add pre-approve hook for change requests ([`1f236ae`](https://github.com/OpenG2P/registry-platform/commit/1f236ae68f75f6aebf011c910f7a811b09f5f19c))
- fix: correct variable name in G2PRegistrantAuthenticationControllerService ([`20ba84f`](https://github.com/OpenG2P/registry-platform/commit/20ba84fee15e14e4f6d35554430e8ed4ad75a1b1))
- [G2P-5208](https://openg2p.atlassian.net/browse/G2P-5208) refactor(intake-form): simplify submission search logic ([`b7fd7e9`](https://github.com/OpenG2P/registry-platform/commit/b7fd7e9aa82ff75c660e747bda6da11ecbb5635b))
- [G2P-5206](https://openg2p.atlassian.net/browse/G2P-5206) refactor(models): remove deprecated G2PIntakeFormSectionPayload class ([`fffbde9`](https://github.com/OpenG2P/registry-platform/commit/fffbde9a586f5124b1556876ca6ae315251db39d))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`5e43850`](https://github.com/OpenG2P/registry-platform/commit/5e43850944e58926167dc1282f71cd4be0d40582))
- [G2P-5194](https://openg2p.atlassian.net/browse/G2P-5194) - changed version to develop in develop branch ([`26a1690`](https://github.com/OpenG2P/registry-platform/commit/26a16900553e77ed314248de8530311b8f61b75c))
- [G2P-5183](https://openg2p.atlassian.net/browse/G2P-5183) Add client-side CSRF token handling ([`e9b48ad`](https://github.com/OpenG2P/registry-platform/commit/e9b48ad4fb1dc808a474b01c5aa09fa70aadeb70))
- [G2P-5154](https://openg2p.atlassian.net/browse/G2P-5154) Update environment variables, and refactor logout handling ([`cbead27`](https://github.com/OpenG2P/registry-platform/commit/cbead274b7c0a43f2e81d7b29c7e8e45a6047c1e))
- [G2P-5153](https://openg2p.atlassian.net/browse/G2P-5153) Refactor IAM permission handling and authentication cookie management ([`8a6abe5`](https://github.com/OpenG2P/registry-platform/commit/8a6abe5de479bf2647f89b31fbfa62989114ef3e))

<a id="v-0-0-0-develop-285"></a>

## registry-platform — develop 0.0.0-develop.285 (2026-07-22)

_commit `0364f07` · baseline: release v1.0.0 · previous build 0.0.0-develop.284_
<!-- build:0.0.0-develop.285 revision:0364f0759eb6097e95ce888256b4f8bdba6212cd ts:1784720149 -->

### Summary

_All changes since release v1.0.0:_

- **Major:** CI/CD overhaul: unified build-publish workflow for all images and charts, including staff-ui; added lightweight UI CI checks and excluded Dependabot branches.
- Reference registry enhancements: cleaned up unused message-rule seeds, improved Dockerfile documentation, and ensured DCI search resolves the Individual template.
- Sanity testing improvements: made e2e tests fully green, enhanced logging with timestamps, and fixed ScopeMismatch issues in change_request fixtures.
- Document handling refactor: streamlined ingestion and retrieval processes, updated schemas, and improved error handling across document-related services.
- Security updates: added CSRF validation for staff-portal-api requests and implemented client-side CSRF token handling.
- Feature additions: introduced configurable reference generator, enhanced file validation profiles, and added application reference fields.
- UI/UX improvements: updated geo hierarchy layout, improved widget handling, and added support for logos and favicons in the application.
- Dependency updates: synchronized versions across modules, including the update of @openg2p/registry-widgets to 1.1.4 and ui-widgets to v1.1.3.

### New in this build (since 0.0.0-develop.284)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: stop build-publish on Dependabot branches (exclude !dependabot/**); add lightweight ui-ci PR check (npm type-check+build, no publish) for the UI packages ([`0364f07`](https://github.com/OpenG2P/registry-platform/commit/0364f0759eb6097e95ce888256b4f8bdba6212cd))

### Since last release (v1.0.0)

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: stop build-publish on Dependabot branches (exclude !dependabot/**); add lightweight ui-ci PR check (npm type-check+build, no publish) for the UI packages ([`0364f07`](https://github.com/OpenG2P/registry-platform/commit/0364f0759eb6097e95ce888256b4f8bdba6212cd))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) CI: single build-publish workflow for all images+chart at one locked version — fold staff-ui in (own context), add staffUi+sanity to chart-image-paths, drop separate docker-staff-portal-ui.yml ([`aebd339`](https://github.com/OpenG2P/registry-platform/commit/aebd3399642c4b65bd90c9e354c3d374bc60974b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry cleanup: remove broken/unused inbound message-rule seed, de-NSR (templates→individual_to_dci, registry name, master-data URLs), correct Dockerfile/README comments to the runnable reference-registry + Option-C model ([`d7139ea`](https://github.com/OpenG2P/registry-platform/commit/d7139ea1bb36a12681daa5805cfb16a80d747d50))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e logs: clean titled per-test banner + timestamped step lines + RESULT footer; suppress httpx and pytest live-log noise (drop log_cli, run with -s) ([`c72eb16`](https://github.com/OpenG2P/registry-platform/commit/c72eb16907af882b891ecb4866e46c744faaf2b0))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: history test reads g2p_register_history_individuals (last farmer-table ref); reference e2e now fully green (DCI + change-request/AWE) ([`d424e68`](https://github.com/OpenG2P/registry-platform/commit/d424e68853f2359035aaed506a8e9d1a60229a46))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity: fix ScopeMismatch — use a plain logger (not the function-scoped step fixture) inside the module-scoped change_request fixture ([`d6399e7`](https://github.com/OpenG2P/registry-platform/commit/d6399e79eacebe7e4bfcc3148aa8427928af12b4))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference AWE seed collision-tolerant: split individual vs household groups with ON CONFLICT DO NOTHING so the individual change_request policy+stages always seed even when a shared AWE DB already has registry.change_request.household from another registry ([`b15861f`](https://github.com/OpenG2P/registry-platform/commit/b15861f3b494ebca04d26a97b3994fbb3aa67689))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference DCI seed to core schema (documents/data_models/outgoing_templates) so DCI search resolves the Individual template; add timestamped per-test step logging (DCI + change-request/AWE stages) ([`d171513`](https://github.com/OpenG2P/registry-platform/commit/d17151398c368b7dc6394a2f2ec92d549fbc8f8b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity CR e2e: target reference individual UI tab/section + individuals table for the change-request test ([`749f91f`](https://github.com/OpenG2P/registry-platform/commit/749f91ff5b878ccd6b66da446c58489baa0ca805))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity DCI e2e: read name/birth_date directly under demographic_info (reference DCI-standard template shape) ([`877d833`](https://github.com/OpenG2P/registry-platform/commit/877d83337e5961d413578a4a66e7df3619d327f3))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Sanity e2e: point reference sanity suite at individual register (data_seed table, register id, DCI scopes/type) so e2e runs against the reference registry ([`3f8b410`](https://github.com/OpenG2P/registry-platform/commit/3f8b410ecb81d896d3172295bed70e642d0cc87b))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry db-seed green: minimal seed with demo-data loaders (sample/geo/images/templates) defaulted OFF in base chart, farmer overlay re-enables; add openg2p-registry-sanity-tests image + e2e suite + CI entry ([`1476fbb`](https://github.com/OpenG2P/registry-platform/commit/1476fbb1dc89769c7139f83324f0ecce95a024e8))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Reference registry + naming cleanup: RP images are runnable reference registries (individual+household from NSR), env-selected extension (Option C), staff-api/bene-api/celery-*/staff-ui rename, single openg2p-registry chart; farmer extends via REGISTRY_EXTENSION_MODULE ([`db42ba2`](https://github.com/OpenG2P/registry-platform/commit/db42ba21748d16f714506f157779bd0006c1cba6))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) Invert build model: registry-platform publishes base images + Helm chart, farmer-registry extends ([`53d580c`](https://github.com/OpenG2P/registry-platform/commit/53d580c0d8e454996e559fb34a7450b4790ba2ae))
- chore(ui-widgets): version for npm next publish, sync staff-portal-ui @1.1.4-dev.3 [skip ci] ([`4e4548b`](https://github.com/OpenG2P/registry-platform/commit/4e4548b3fb2e645191fd660836fd2d7b674097fe))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`c73493f`](https://github.com/OpenG2P/registry-platform/commit/c73493fd9c9990fe57ee36b28461aba944bcaf17))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking (kind: library) ([`532a3f9`](https://github.com/OpenG2P/registry-platform/commit/532a3f96341f56c3438421fa984bbc807292f1dc))
- [G2P-5375](https://openg2p.atlassian.net/browse/G2P-5375) Update @openg2p/registry-widgets version to 1.1.4 ([`c0331db`](https://github.com/OpenG2P/registry-platform/commit/c0331db71aa8c9af8fdc38643bcc8e7cc58898b7))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: update buildSectionsDataMap return type - change return type to always return an object ([`b010347`](https://github.com/OpenG2P/registry-platform/commit/b010347a6f87170f3975f417e30bdcd7937821ee))
- updating the ui widget develop tag 1.1.4-dev.2 in the staff portal ui ([`08cb976`](https://github.com/OpenG2P/registry-platform/commit/08cb976ce5d3172f4c82a8ac2a5bf5eb75eced47))
- updating the ui widget develop tag in the staff portal ui ([`5bb768f`](https://github.com/OpenG2P/registry-platform/commit/5bb768fa8c60e7d83e1c9d1019ffe603174f5725))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update file rendering for change request header, submission header, and DocsWidget ([`e103a51`](https://github.com/OpenG2P/registry-platform/commit/e103a518aa0ff0d25ee5896b1e9ed6bbe375f9e4))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(intake_form_register): dedupe document ingestion by register - update document retrieval to group by register - adjust document processing to use register-level sections - enhance logging for missing section references ([`5eaaf0c`](https://github.com/OpenG2P/registry-platform/commit/5eaaf0cb28c6bb165363ede1741a91752bf8fb09))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) chore(helper): remove unused MinioClient import ([`93630f0`](https://github.com/OpenG2P/registry-platform/commit/93630f0813c7892332faf88d9f0aaf91eed555f4))
- updating the ui widget tag in the staff portal ui ([`13ca764`](https://github.com/OpenG2P/registry-platform/commit/13ca76482e411b901e97a294e7868bc84f9cb1c6))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(enum): restore entry in ChangeRequestSourceEnum ([`4d7ff96`](https://github.com/OpenG2P/registry-platform/commit/4d7ff96e277eef3e77444856a9154f08ac92ec2f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor(geo-hierarchy): enhance layout and widget handling ([`46317cf`](https://github.com/OpenG2P/registry-platform/commit/46317cf8a7193859eeac8961974935085456857f))
- fix(g2p_register): handle geo hierarchy service absence gracefully ([`9fcf214`](https://github.com/OpenG2P/registry-platform/commit/9fcf214da6ae5b40a706f501a94d249d1776dba5))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) refactor(service): streamline document handling on change approval ([`eb99cf3`](https://github.com/OpenG2P/registry-platform/commit/eb99cf322e02386f0b55cf2acd4828ab69d737bf))
- [G2P-5347](https://openg2p.atlassian.net/browse/G2P-5347) fix(service): add record image URLs to change request data ([`860817e`](https://github.com/OpenG2P/registry-platform/commit/860817e82a27173ba101a7245c11dc2c70222854))
- [G2P-5330](https://openg2p.atlassian.net/browse/G2P-5330) fix(controller): remove permissions for upload and delete documents ([`ee6528a`](https://github.com/OpenG2P/registry-platform/commit/ee6528a6ab92b9992aae536417ec46eb33aef20f))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) fix(model): simplify created_at field by removing timezone support and using utcnow ([`fbaae54`](https://github.com/OpenG2P/registry-platform/commit/fbaae549dac2aacb3c33b8e484584454cd1ec201))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: preview url issue for HeaderSectionWidget ([`512c3f5`](https://github.com/OpenG2P/registry-platform/commit/512c3f56338338f09a272b4e5f9da370a979de0a))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: refetch approval status after decision and split approval hooks ([`fc0cec9`](https://github.com/OpenG2P/registry-platform/commit/fc0cec9c6397df2398232da4297af1e908386a09))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update geo hierarchy and document handling ([`91edd25`](https://github.com/OpenG2P/registry-platform/commit/91edd25d5f914b95a705d39d4798c204adef4808))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: update register and intake form document handling ([`24009ab`](https://github.com/OpenG2P/registry-platform/commit/24009ab9cf81d514b80355557d0e60bf623d75b4))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) refactor: rename template_file_id to template_document_id across the application ([`cf1e75d`](https://github.com/OpenG2P/registry-platform/commit/cf1e75df4a98a8281f25d18bbb6fd8689afcb06f))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): ensure created_at uses timezone-aware DateTime ([`ed8df39`](https://github.com/OpenG2P/registry-platform/commit/ed8df39a39859cce4b48826afc15b626fc6dc07d))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) chore: update ui-widgets to v1.1.3 ([`f8adc49`](https://github.com/OpenG2P/registry-platform/commit/f8adc49a10b4ae2ad1e0c154a2630f5f8a41162d))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(minio): update bucket handling to use StrEnum directly ([`3140005`](https://github.com/OpenG2P/registry-platform/commit/3140005bd027d2d387a673e70bcdbaae275f78d5))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix(model): update bucket column type to Enum - change bucket column from String to Enum for DocumentBucket - adjust default value for bucket to use Enum directly ([`d9b49b7`](https://github.com/OpenG2P/registry-platform/commit/d9b49b7645ed77a75fec0fae2c56893b89544465))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix(helper): correct import path for DocumentBucket ([`d0359fd`](https://github.com/OpenG2P/registry-platform/commit/d0359fd27cf924b3bfcdb437d3007288df544cb3))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(controller): unify error response handling for new document controller ([`737c444`](https://github.com/OpenG2P/registry-platform/commit/737c44447b063627e145377e8d8800c17bfd23eb))
- [G2P-5336](https://openg2p.atlassian.net/browse/G2P-5336) fix(errors): update error handling to use new default error code ([`69ad5ee`](https://github.com/OpenG2P/registry-platform/commit/69ad5ee2fad88b69b1b2f1920db9e70b8b2948fb))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) refactor: update docs widget configuration to use 'widget-total-docs' and enhance column distribution logic ([`cd85f91`](https://github.com/OpenG2P/registry-platform/commit/cd85f9156c45e66d8c93f78327f218b35711f2b9))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: remove fixed layout configuration from geo hierarchy widget and improve column distribution logic ([`1cb6017`](https://github.com/OpenG2P/registry-platform/commit/1cb6017df8a6850b02801a0e8e9df13ee0b78c6b))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(documents): add dashboard image validation profile ([`142b0f2`](https://github.com/OpenG2P/registry-platform/commit/142b0f27ca95e5b50bd490f51dbdd33a007ea91a))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) feat(documents): enhance file validation and upload profiles ([`1b4581b`](https://github.com/OpenG2P/registry-platform/commit/1b4581bc20b9a74727ce9ddb165c24f95db18880))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) refactor(icons): enhance file validation for uploads ([`d459348`](https://github.com/OpenG2P/registry-platform/commit/d459348825030d5b898f489bd6be29c2f586d512))
- [G2P-5334](https://openg2p.atlassian.net/browse/G2P-5334) Remove dash from new intake form breadcrumb ([`3520034`](https://github.com/OpenG2P/registry-platform/commit/3520034cf157cfec9e5d7f0497319657d7332309))
- [G2P-5332](https://openg2p.atlassian.net/browse/G2P-5332) add register icon remove button ([`b4a2d47`](https://github.com/OpenG2P/registry-platform/commit/b4a2d47725861e6db6a10a4e24786c7f76b464dd))
- [G2P-5339](https://openg2p.atlassian.net/browse/G2P-5339) add docs widget ([`66aed2a`](https://github.com/OpenG2P/registry-platform/commit/66aed2a4cf094a820d51ba1bdbf84452678f0252))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and request response ([`595e7dc`](https://github.com/OpenG2P/registry-platform/commit/595e7dcf3374fa4b7cad04c3a82738604bc7d779))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve geo location, requestDataSourceHandler, and translation handling ([`9117fe8`](https://github.com/OpenG2P/registry-platform/commit/9117fe885fcafca9ba7aab3305c21426cc64d8ad))
- [G2P-5326](https://openg2p.atlassian.net/browse/G2P-5326) fix: template file upload size and type ([`8dbcb73`](https://github.com/OpenG2P/registry-platform/commit/8dbcb736bbc42de6c5d159c9b341c891472f8c70))
- [G2P-5275](https://openg2p.atlassian.net/browse/G2P-5275) fix: update 1MB image upload limit for logo, favicon, and register icon ([`fd6a81d`](https://github.com/OpenG2P/registry-platform/commit/fd6a81de7a737212dd6725b645d04f87cdcbca56))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update environment variables and streamline document handling ([`b0c2e53`](https://github.com/OpenG2P/registry-platform/commit/b0c2e53b0e641f7d082e97acb0bc7507d21d30b4))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): update document handling and configurations for celery queue tasks ([`40fdc64`](https://github.com/OpenG2P/registry-platform/commit/40fdc644350c9959b319594ea4844f2fa3ddef01))
- [G2P-5325](https://openg2p.atlassian.net/browse/G2P-5325) refactor(documents): streamline document handling in apis and remove template file controller ([`fd5666e`](https://github.com/OpenG2P/registry-platform/commit/fd5666e57c7a88f85b15cadb81016cfb02892c4b))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) ([`14ae7bd`](https://github.com/OpenG2P/registry-platform/commit/14ae7bde33b24bd2513e1e68e45f48b585ea2185))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(documents): streamline document handling and update schemas ([`09f5306`](https://github.com/OpenG2P/registry-platform/commit/09f53060963e5f18e09f93d8911b410a0f4d9c0f))
- [G2P-5306](https://openg2p.atlassian.net/browse/G2P-5306) refactor(document): restructure document handling and abstract MinioClient ([`7ba5cbe`](https://github.com/OpenG2P/registry-platform/commit/7ba5cbebc018f20091d6b7002e20b7d162ed4f91))
- [G2P-5307](https://openg2p.atlassian.net/browse/G2P-5307) refactor(models): update document handling in data models ([`c20ccd8`](https://github.com/OpenG2P/registry-platform/commit/c20ccd825362ac9ddc430c20994ebe40d8b3c944))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Permission decorated enabled on one API. ([`e11e8fe`](https://github.com/OpenG2P/registry-platform/commit/e11e8fe14d717636da5cc8cd1c3d16694db57cca))
- [G2P-5318](https://openg2p.atlassian.net/browse/G2P-5318) Restrict config nav to CONFIG_NAV_ACTIONS and guard config sub-pages ([`aaca369`](https://github.com/OpenG2P/registry-platform/commit/aaca36983e9e86dea39674c0167371253006d4ab))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) refactor: update attribute value fetching in AttributeValueInput component ([`02ddbfb`](https://github.com/OpenG2P/registry-platform/commit/02ddbfbc08b854a9fe3357a6e1071d6adbfd67f8))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`7d798a4`](https://github.com/OpenG2P/registry-platform/commit/7d798a430fb4ae254fdd749ed06b766bff8f2fc7))
- changed the widget version and published the dev ([`f2ef6ab`](https://github.com/OpenG2P/registry-platform/commit/f2ef6ab88262300981abdd7530de65c914f304a8))
- [G2P-5271](https://openg2p.atlassian.net/browse/G2P-5271) Update version to 1.1.0 across all modules ([`60f853d`](https://github.com/OpenG2P/registry-platform/commit/60f853de9f4007f98f9e8619e22f8f34804c89fb))
- [G2P-5181](https://openg2p.atlassian.net/browse/G2P-5181): Record Level Access - Approach using BaseRepository with Generics T ([`1ab3f52`](https://github.com/OpenG2P/registry-platform/commit/1ab3f527730353e97b6b5657cd51a9c9496db317))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Consent and partner management related. ([`873f96a`](https://github.com/OpenG2P/registry-platform/commit/873f96aa7c2624e5bcee3ca51df344d659f6cdd2))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Enhancements for consent management, partner management and WJS support. ([`a9ba084`](https://github.com/OpenG2P/registry-platform/commit/a9ba084b7654de83842e97cbf3c8f4f29ec6edd4))
- 'develop' version was incorrect in init.py. Changed to 0.0.0-dev0 ([`3dd3947`](https://github.com/OpenG2P/registry-platform/commit/3dd3947aeb10293855202d76696c408beaa727e3))
- [G2P-5267](https://openg2p.atlassian.net/browse/G2P-5267) rename attribute labels to reference data ([`37aee91`](https://github.com/OpenG2P/registry-platform/commit/37aee9110037cee04cd676cd88211bc4e9a428a3))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: add new data policy management features for administrative areas and reference data ([`533420a`](https://github.com/OpenG2P/registry-platform/commit/533420afb69b95229ec51ce796ea4d37a2739497))
- [G2P-5265](https://openg2p.atlassian.net/browse/G2P-5265) feat(intake): add configurable reference generator ([`55cf95d`](https://github.com/OpenG2P/registry-platform/commit/55cf95dd473eda2885cce6a1a03439b0b6684eba))
- [G2P-5263](https://openg2p.atlassian.net/browse/G2P-5263) Update breadcrumbs for register and intake form pages ([`dad3970`](https://github.com/OpenG2P/registry-platform/commit/dad39709fb54a307b61dbf7f5c58d85412d24b56))
- [G2P-5262](https://openg2p.atlassian.net/browse/G2P-5262) feat: extend data policy to handle new policy target ([`faef96b`](https://github.com/OpenG2P/registry-platform/commit/faef96bdd783349c7553b2a77a2d89a9b9f4f65b))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Refactor AWE proxy request handling to support pagination and improve payload resolution ([`364cce2`](https://github.com/OpenG2P/registry-platform/commit/364cce2cefd2cd93d50aa4365f0f90ac3e2c5e69))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122) cleanup: remove unused change request approval code ([`f538140`](https://github.com/OpenG2P/registry-platform/commit/f53814018f7158da6f9aec58d2a6a2fbc88cd8be))
- [G2P-5122](https://openg2p.atlassian.net/browse/G2P-5122): add approvals list ([`b64eda0`](https://github.com/OpenG2P/registry-platform/commit/b64eda0920c70c29ebaead9eb2a128a66cf82255))
- [G2P-5255](https://openg2p.atlassian.net/browse/G2P-5255) Add CSRF validation configuration for staff-portal-api requests ([`1f8c663`](https://github.com/OpenG2P/registry-platform/commit/1f8c663d3a0ded1841efd87e9a1c96ea1be3ecda))
- [G2P-5178](https://openg2p.atlassian.net/browse/G2P-5178) feat(attribute-service): add search functionality for attributes and values ([`78f2d13`](https://github.com/OpenG2P/registry-platform/commit/78f2d1328420dcf731b70ae55dd6e3fd708422e1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) feat: support logo within text and registry favicon ([`8ba88a2`](https://github.com/OpenG2P/registry-platform/commit/8ba88a28e6032f68299432f52d3f8b98285e8935))
- [G2P-5247](https://openg2p.atlassian.net/browse/G2P-5247) Add request_id to VersionForDateData and update G2PRegisterService to populate it from change requests ([`f31d5b8`](https://github.com/OpenG2P/registry-platform/commit/f31d5b89ea0e5fb954d2f4af871bb5217136e110))
- [G2P-5245](https://openg2p.atlassian.net/browse/G2P-5245) feat(application-reference): add application reference field, its generation, usage and update api ([`a2a9ece`](https://github.com/OpenG2P/registry-platform/commit/a2a9eced23a584ccb43ba87568aa1a961721f162))
- [G2P-5238](https://openg2p.atlassian.net/browse/G2P-5238) refactor: improve UI widgets and add example UI schema reference ([`866ed7a`](https://github.com/OpenG2P/registry-platform/commit/866ed7ace683f1e752d42f5c460e409ffd190ec1))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add cookieDomain to environment configuration and update auth cookie handling ([`bffa646`](https://github.com/OpenG2P/registry-platform/commit/bffa64684394f29747f74f1722024a479f6d28a2))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add assignee_name field to ApprovalTask model and update related logic ([`5648eb2`](https://github.com/OpenG2P/registry-platform/commit/5648eb2f95bb7f5cb59be06a053ce8d45fe5751c))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add upgrade-insecure-requests to CSP header ([`71c5085`](https://github.com/OpenG2P/registry-platform/commit/71c5085cfc1067bf45bfe3cdd8d9ac61ea241034))
- [G2P-5182](https://openg2p.atlassian.net/browse/G2P-5182) fix: boolean conditional visibility, dialog-table conditions, and attribute API hooks ([`48f4136`](https://github.com/OpenG2P/registry-platform/commit/48f41364aa11ad02e80cbe204f55b82d95af804e))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Fix: rollback CR changes when terminal approval validation fails ([`8868209`](https://github.com/OpenG2P/registry-platform/commit/88682099c356820fa9ab71d1ec9d038b924c3a01))
- [G2P-5232](https://openg2p.atlassian.net/browse/G2P-5232) Add list_tasks_for_request endpoint and related functionality ([`0ac9dce`](https://github.com/OpenG2P/registry-platform/commit/0ac9dcee872d2c270f30804d0acc67b2838a1109))
- [G2P-5219](https://openg2p.atlassian.net/browse/G2P-5219) feat(change-request): add pre-approve hook for change requests ([`1f236ae`](https://github.com/OpenG2P/registry-platform/commit/1f236ae68f75f6aebf011c910f7a811b09f5f19c))
- fix: correct variable name in G2PRegistrantAuthenticationControllerService ([`20ba84f`](https://github.com/OpenG2P/registry-platform/commit/20ba84fee15e14e4f6d35554430e8ed4ad75a1b1))
- [G2P-5208](https://openg2p.atlassian.net/browse/G2P-5208) refactor(intake-form): simplify submission search logic ([`b7fd7e9`](https://github.com/OpenG2P/registry-platform/commit/b7fd7e9aa82ff75c660e747bda6da11ecbb5635b))
- [G2P-5206](https://openg2p.atlassian.net/browse/G2P-5206) refactor(models): remove deprecated G2PIntakeFormSectionPayload class ([`fffbde9`](https://github.com/OpenG2P/registry-platform/commit/fffbde9a586f5124b1556876ca6ae315251db39d))
- [G2P-5207](https://openg2p.atlassian.net/browse/G2P-5207) fix: translations and UI schema seeding ([`5e43850`](https://github.com/OpenG2P/registry-platform/commit/5e43850944e58926167dc1282f71cd4be0d40582))
- [G2P-5194](https://openg2p.atlassian.net/browse/G2P-5194) - changed version to develop in develop branch ([`26a1690`](https://github.com/OpenG2P/registry-platform/commit/26a16900553e77ed314248de8530311b8f61b75c))
- [G2P-5183](https://openg2p.atlassian.net/browse/G2P-5183) Add client-side CSRF token handling ([`e9b48ad`](https://github.com/OpenG2P/registry-platform/commit/e9b48ad4fb1dc808a474b01c5aa09fa70aadeb70))
- [G2P-5154](https://openg2p.atlassian.net/browse/G2P-5154) Update environment variables, and refactor logout handling ([`cbead27`](https://github.com/OpenG2P/registry-platform/commit/cbead274b7c0a43f2e81d7b29c7e8e45a6047c1e))
- [G2P-5153](https://openg2p.atlassian.net/browse/G2P-5153) Refactor IAM permission handling and authentication cookie management ([`8a6abe5`](https://github.com/OpenG2P/registry-platform/commit/8a6abe5de479bf2647f89b31fbfa62989114ef3e))

# Branches (moving)

<a id="v-branch-develop"></a>

## registry-platform — `develop` branch (2026-07-20)

_moving branch · latest commit `0aa8e36` · baseline: v1.0.0_
<!-- build:develop revision:0aa8e362af8ff75fdc8322b855b3a2aa99217420 ts:1784523907 -->

### Summary

_Changes on `develop` since v1.0.0:_

- **Major:** Refactor of document handling across the application, including removal of deprecated classes, restructuring of document processing, and enhancements to validation profiles for uploads.
- Security improvements: Added CSRF validation for API requests and client-side CSRF token handling to enhance protection against cross-site request forgery.
- Dependency updates: Upgraded `@openg2p/registry-widgets` to version 1.1.4 and updated various environment variables across modules.
- UI enhancements: Improved layout and handling of geo hierarchy widgets, added new icons, and updated breadcrumb navigation for intake forms.
- Refactoring efforts: Streamlined error handling in controllers, improved logging for document ingestion, and deduplicated document retrieval processes.
- Cleanup and maintenance: Removed unused code and imports, including the deletion of several controller services and middleware related to document handling.
- Feature additions: Introduced new data policy management features and configurable reference generators for administrative areas.

### Recent commits (latest 5)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`c73493f`](https://github.com/OpenG2P/registry-platform/commit/c73493fd9c9990fe57ee36b28461aba944bcaf17))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking (kind: library) ([`532a3f9`](https://github.com/OpenG2P/registry-platform/commit/532a3f96341f56c3438421fa984bbc807292f1dc))
- [G2P-5375](https://openg2p.atlassian.net/browse/G2P-5375) Update @openg2p/registry-widgets version to 1.1.4 ([`c0331db`](https://github.com/OpenG2P/registry-platform/commit/c0331db71aa8c9af8fdc38643bcc8e7cc58898b7))
- [G2P-4763](https://openg2p.atlassian.net/browse/G2P-4763) fix: update buildSectionsDataMap return type - change return type to always return an object ([`b010347`](https://github.com/OpenG2P/registry-platform/commit/b010347a6f87170f3975f417e30bdcd7937821ee))
- updating the ui widget develop tag 1.1.4-dev.2 in the staff portal ui ([`08cb976`](https://github.com/OpenG2P/registry-platform/commit/08cb976ce5d3172f4c82a8ac2a5bf5eb75eced47))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 10 develop builds** and the **latest 10 release
> candidates** per release line. Older develop builds and release candidates
> are pruned as they are superseded, and a release's candidates are removed
> once it ships. Those versions still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
