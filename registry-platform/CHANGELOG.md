# registry-platform

_Published automatically._

**Repository:** [github.com/OpenG2P/registry-platform](https://github.com/OpenG2P/registry-platform)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.329`](#v-0-0-0-develop-329) | 2026-07-30 | develop |
| [`0.0.0-develop.316`](#v-0-0-0-develop-316) | 2026-07-30 | develop |
| [`0.0.0-develop.311`](#v-0-0-0-develop-311) | 2026-07-30 | develop |
| [`0.0.0-develop.299`](#v-0-0-0-develop-299) | 2026-07-29 | develop |
| [`0.0.0-develop.298`](#v-0-0-0-develop-298) | 2026-07-29 | develop |
| [`0.0.0-develop.297`](#v-0-0-0-develop-297) | 2026-07-28 | develop |
| [`0.0.0-develop.296`](#v-0-0-0-develop-296) | 2026-07-24 | develop |
| [`0.0.0-develop.295`](#v-0-0-0-develop-295) | 2026-07-24 | develop |
| [`0.0.0-develop.294`](#v-0-0-0-develop-294) | 2026-07-24 | develop |
| [`0.0.0-develop.292`](#v-0-0-0-develop-292) | 2026-07-23 | develop |
| [`develop`](#v-branch-develop) | 2026-07-20 | branch |

# Develop builds

<a id="v-0-0-0-develop-329"></a>

## registry-platform — develop 0.0.0-develop.329 (2026-07-30)

_commit `7da37f9` · changes since 0.0.0-develop.316_
<!-- build:0.0.0-develop.329 revision:7da37f9dc8fc274140b490673cd77d28c157e975 ts:1785406111 -->

### Summary

- **Major:** Version bump to 1.1.1 for the registry platform, including an update to ui widget version 1.1.4-dev.4.
- Refactoring improvements: streamlined history field handling in g2p_register, fixed audit details in the table widget, and recreated widget store on version change in VersionHistoryPage to prevent stale data.
- Feature enhancements: added unsaved changes warning in intake-form and improved permissions handling in DataPoliciesListPage.
- Dependency updates: modified package-lock.json and package.json for staff-ui, reflecting changes in dependencies.

### Changes since 0.0.0-develop.316

- [G2P-5365](https://openg2p.atlassian.net/browse/G2P-5365) refactor(useCrViewData): fix audit details in table widget ([`a71fb67`](https://github.com/OpenG2P/registry-platform/commit/a71fb679b913cabf8988c5b4f568f61b8feaf939))
- [G2P-5382](https://openg2p.atlassian.net/browse/G2P-5382) refactor(VersionHistoryPage): recreate widget store on version change to prevent stale data ([`b622225`](https://github.com/OpenG2P/registry-platform/commit/b6222259a0c84b503b85467f78fa503bb8238455))
- [G2P-5365](https://openg2p.atlassian.net/browse/G2P-5365) refactor(g2p_register): streamline history field handling - update base fields to exclude from current register data - add last approved by and approved at fields to current register data ([`102b30b`](https://github.com/OpenG2P/registry-platform/commit/102b30bf51eb76e73c103af2735138cb6bf83295))
- bumped up the version to 1.1.1 for registry platform ([`6367bae`](https://github.com/OpenG2P/registry-platform/commit/6367bae50d7ef6c6a31700324311620d67c7d44a))
- feat(DataPoliciesListPage): update registry-widgets version and enhance permissions handling ([`aa86b28`](https://github.com/OpenG2P/registry-platform/commit/aa86b28ce26915ac4b8e78695462f15c7917cc58))
- published and updated ui widget version to 1.1.4-dev.4 ([`3abf27c`](https://github.com/OpenG2P/registry-platform/commit/3abf27c95df473313630476afa24d82e73ff7e1a))
- [G2P-5381](https://openg2p.atlassian.net/browse/G2P-5381) feat(intake-form): add unsaved changes warning before submit ([`9b664e1`](https://github.com/OpenG2P/registry-platform/commit/9b664e1fa37246c91e73262a82341ff299d82dfe))

<a id="v-0-0-0-develop-316"></a>

## registry-platform — develop 0.0.0-develop.316 (2026-07-30)

_commit `514e6ba` · changes since 0.0.0-develop.311_
<!-- build:0.0.0-develop.316 revision:514e6ba3842246972c6b4beedc7ec1077cbe72ff ts:1785393049 -->

### Summary

- New features: introduced services for intake form management in Celery, and added an API endpoint to retrieve allowed parents for intake forms.
- Code cleanup: removed unused async methods and cleaned up imports across the models.
- Testing enhancements: added a new test for the intake form link service to improve coverage.

### Changes since 0.0.0-develop.311

- [G2P-5412](https://openg2p.atlassian.net/browse/G2P-5412) refactor(models): remove unused async methods and clean imports ([`0b777ad`](https://github.com/OpenG2P/registry-platform/commit/0b777ade7a8ccd158ad16ca59503667d4b4e1dcf))
- [G2P-5411](https://openg2p.atlassian.net/browse/G2P-5411) feat(celery): register new services for intake form management ([`2d3eea1`](https://github.com/OpenG2P/registry-platform/commit/2d3eea1146572a4c61d61eef8694a0a4cf7c842b))
- [G2P-5411](https://openg2p.atlassian.net/browse/G2P-5411) feat(intake-form): add endpoint to retrieve allowed parents for intake forms ([`6d02119`](https://github.com/OpenG2P/registry-platform/commit/6d0211985c9ed0c8b42341b6dde67a16245116e3))

<a id="v-0-0-0-develop-311"></a>

## registry-platform — develop 0.0.0-develop.311 (2026-07-30)

_commit `2e95438` · changes since 0.0.0-develop.299_
<!-- build:0.0.0-develop.311 revision:2e95438355948739fed448f06c1aad346c999320 ts:1785384384 -->

### Summary

- **Major:** Refactored UI and API routes by removing deprecated tab and section routes, streamlining the codebase with 14 files deleted and significant reductions in lines of code.
- Upsert functionality added for submission search text in the intake form data service, enhancing data handling capabilities.
- Aligned tab and section service with current ORM columns, ensuring consistency and accuracy in data representation.

### Changes since 0.0.0-develop.299

- [G2P-5400](https://openg2p.atlassian.net/browse/G2P-5400) refactor(ui-routes): Remove deprecated tab and section routes ([`574c372`](https://github.com/OpenG2P/registry-platform/commit/574c372ce3497ad3abdae962a1b0dfa32ebbfc33))
- [G2P-5400](https://openg2p.atlassian.net/browse/G2P-5400) refactor (staff-api): Remove legacy tab and section CRUD routes ([`de2db46`](https://github.com/OpenG2P/registry-platform/commit/de2db4656099d3927004a7f7ae7496f4ae776553))
- [G2P-5400](https://openg2p.atlassian.net/browse/G2P-5400) fix(register): align tab/section service with current ORM columns ([`9bb223b`](https://github.com/OpenG2P/registry-platform/commit/9bb223be957d852468e87d8edfe2de3975ce1f24))
- [G2P-5206](https://openg2p.atlassian.net/browse/G2P-5206) feat: add upsert functionality for submission search text in intake form data service ([`02a7a34`](https://github.com/OpenG2P/registry-platform/commit/02a7a342cc3ea18249202197a2ebb83089f8bfc8))

<a id="v-0-0-0-develop-299"></a>

## registry-platform — develop 0.0.0-develop.299 (2026-07-29)

_commit `525b84f` · changes since 0.0.0-develop.298_
<!-- build:0.0.0-develop.299 revision:525b84f27a6029cc6882a208a98b154e35271a37 ts:1785303898 -->

### Changes since 0.0.0-develop.298

- Just to take latest version of openg2p-data ([`525b84f`](https://github.com/OpenG2P/registry-platform/commit/525b84f27a6029cc6882a208a98b154e35271a37))

<a id="v-0-0-0-develop-298"></a>

## registry-platform — develop 0.0.0-develop.298 (2026-07-29)

_commit `80e5002` · changes since 0.0.0-develop.297_
<!-- build:0.0.0-develop.298 revision:80e5002bdd7cf922b118aeed74b479e6a3d9fdbe ts:1785289432 -->

### Changes since 0.0.0-develop.297

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Pin the db-seed image to openg2p-data develop in CI. ([`80e5002`](https://github.com/OpenG2P/registry-platform/commit/80e5002bdd7cf922b118aeed74b479e6a3d9fdbe))

<a id="v-0-0-0-develop-297"></a>

## registry-platform — develop 0.0.0-develop.297 (2026-07-28)

_commit `dc2dc8d` · changes since 0.0.0-develop.296_
<!-- build:0.0.0-develop.297 revision:dc2dc8d64a905b3b632139aa99b7660420acc4b4 ts:1785239217 -->

### Changes since 0.0.0-develop.296

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Track openg2p-data develop for the db-seed image. ([`dc2dc8d`](https://github.com/OpenG2P/registry-platform/commit/dc2dc8d64a905b3b632139aa99b7660420acc4b4))

<a id="v-0-0-0-develop-296"></a>

## registry-platform — develop 0.0.0-develop.296 (2026-07-24)

_commit `6ec5f56` · changes since 0.0.0-develop.295_
<!-- build:0.0.0-develop.296 revision:6ec5f56c97c3744ac71f6bb0594db12d864203a1 ts:1784883549 -->

### Changes since 0.0.0-develop.295

- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) db-seed: make sample-data loading idempotent — add ON CONFLICT (internal_record_id) DO NOTHING to the register/sub-table inserts so a re-install over an already-seeded database is a no-op instead of failing on g2p_register_*_pkey ([`6ec5f56`](https://github.com/OpenG2P/registry-platform/commit/6ec5f56c97c3744ac71f6bb0594db12d864203a1))

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
