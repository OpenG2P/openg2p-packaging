# registry-platform

_Published automatically._

**Repository:** [github.com/OpenG2P/registry-platform](https://github.com/OpenG2P/registry-platform)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.341`](#v-0-0-0-develop-341) | 2026-08-03 | develop |
| [`0.0.0-develop.339`](#v-0-0-0-develop-339) | 2026-08-02 | develop |
| [`0.0.0-develop.338`](#v-0-0-0-develop-338) | 2026-08-02 | develop |
| [`0.0.0-develop.336`](#v-0-0-0-develop-336) | 2026-08-01 | develop |
| [`0.0.0-develop.335`](#v-0-0-0-develop-335) | 2026-08-01 | develop |
| [`0.0.0-develop.334`](#v-0-0-0-develop-334) | 2026-08-01 | develop |
| [`0.0.0-develop.331`](#v-0-0-0-develop-331) | 2026-07-31 | develop |
| [`0.0.0-develop.329`](#v-0-0-0-develop-329) | 2026-07-30 | develop |
| [`0.0.0-develop.316`](#v-0-0-0-develop-316) | 2026-07-30 | develop |
| [`0.0.0-develop.311`](#v-0-0-0-develop-311) | 2026-07-30 | develop |
| [`develop`](#v-branch-develop) | 2026-07-20 | branch |

# Develop builds

<a id="v-0-0-0-develop-341"></a>

## registry-platform — develop 0.0.0-develop.341 (2026-08-03)

_commit `d643f2e` · changes since 0.0.0-develop.339_
<!-- build:0.0.0-develop.341 revision:d643f2e4a2815c48640a0072ef2ba6418600eff1 ts:1785734706 -->

### Changes since 0.0.0-develop.339

- [G2P-5451](https://openg2p.atlassian.net/browse/G2P-5451) feat(document):  add read only user access for minio client ([`da42213`](https://github.com/OpenG2P/registry-platform/commit/da42213bf2512603a4cbfd3747fc9382dc5e01c8))

<a id="v-0-0-0-develop-339"></a>

## registry-platform — develop 0.0.0-develop.339 (2026-08-02)

_commit `b890549` · changes since 0.0.0-develop.338_
<!-- build:0.0.0-develop.339 revision:b890549d41cb2e9fdba8eb811291594a6f6c74dd ts:1785674347 -->

### Changes since 0.0.0-develop.338

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Surface the country pack in questions.yaml. None of the geo-seed options were in the Rancher form, so the one place a deployment declares its country was reachable only by hand-editing values — an installer had no way to know the choice existed, and every install silently took the fictitious default. ([`b890549`](https://github.com/OpenG2P/registry-platform/commit/b890549d41cb2e9fdba8eb811291594a6f6c74dd))

<a id="v-0-0-0-develop-338"></a>

## registry-platform — develop 0.0.0-develop.338 (2026-08-02)

_commit `495542f` · changes since 0.0.0-develop.336_
<!-- build:0.0.0-develop.338 revision:495542f02dbafc3b3cc7159d428b6597b01e6222 ts:1785661762 -->

### Summary

- Data handling improvements: Updated geo data loading to reflect the new master-data structure, enabling a five-level slug-path hierarchy, and modified code-list dropdowns to read from the database, eliminating truncation and allowing full selection of options.
- User interface enhancements: Resolved issues with dropdown rendering by removing the default page size limit, ensuring all options are visible and selectable.

### Changes since 0.0.0-develop.336

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Correct the loadGeoData comment. It still described the old direction, where the registry pushed geo into master-data because master-data shipped none — so it read as though the flag were needed for sample data. Master Data seeds its own geography from a country pack now, and enabling this writes a second, five-level slug-path hierarchy over it. ([`495542f`](https://github.com/OpenG2P/registry-platform/commit/495542f02dbafc3b3cc7159d428b6597b01e6222))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Read code-list dropdowns from the database instead of the widget, in the reference extension, and stop truncating them. The attributes route defaulted to page_size 20, so a longer list rendered 20 options with nothing to indicate the rest existed and the missing values simply could not be chosen. ([`22c1d78`](https://github.com/OpenG2P/registry-platform/commit/22c1d78693bae934355b57868858e7132f939f0f))

<a id="v-0-0-0-develop-336"></a>

## registry-platform — develop 0.0.0-develop.336 (2026-08-01)

_commit `cd8845f` · changes since 0.0.0-develop.335_
<!-- build:0.0.0-develop.336 revision:cd8845ff72c92519207b3a23eeea948c0adfb82f ts:1785559322 -->

### Changes since 0.0.0-develop.335

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Attach the sub-table fixtures to whoever was actually loaded. They link to the demography CSV's id space, so once people come from a country pack every land parcel, crop, housing and programme row pointed at a record that does not exist — and with no foreign key to violate they landed as orphans, leaving farmers who own nothing and households with no housing data. Links are remapped onto the loaded records, cycling when a pack carries fewer samples than the fixtures assume, and a table that had one row per record keeps one. Links pointing within the fixture set — a crop's parcel — are left alone. No-op when the ids already match. ([`cd8845f`](https://github.com/OpenG2P/registry-platform/commit/cd8845ff72c92519207b3a23eeea948c0adfb82f))

<a id="v-0-0-0-develop-335"></a>

## registry-platform — develop 0.0.0-develop.335 (2026-08-01)

_commit `35bf698` · changes since 0.0.0-develop.334_
<!-- build:0.0.0-develop.335 revision:35bf698cfd4cd9afcd8b635c3c308e5d8797d49d ts:1785558195 -->

### Changes since 0.0.0-develop.334

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Supply head_individual_id, headship_type and adult/elderly counts with the master-data samples. Registries differ in what they record about a household and NSR needs these four; supplying the union costs nothing since each loader takes only the keys it asks for. ([`35bf698`](https://github.com/OpenG2P/registry-platform/commit/35bf698cfd4cd9afcd8b635c3c308e5d8797d49d))

<a id="v-0-0-0-develop-334"></a>

## registry-platform — develop 0.0.0-develop.334 (2026-08-01)

_commit `782fa19` · changes since 0.0.0-develop.331_
<!-- build:0.0.0-develop.334 revision:782fa19fafd11251d7fd737058e14b3834667862 ts:1785557598 -->

### Summary

- **Major:** Data model overhaul: removed country dependency from sample seeding and geo widgets, introducing a new sync_geo_widgets step to align dropdowns with actual hierarchy, and validating coded values against seeded country lists.
- Registry enhancement: seeded registry code lists from Master Data at install time, establishing MDS as a dependency, and ensuring roles are stored in a new table to avoid issues with existing columns.
- Improved data integrity: resolved sample-data geo IDs against master data instead of relying on slug-paths, with fallback mechanisms in place, and ensured validation on both change-request and intake-form paths.

### Changes since 0.0.0-develop.331

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Take the country out of sample seeding and the geo widgets. load_sample_data no longer assumes five levels called country..village — that describes Kamuntu and nothing else, and Ethiopia has four ending at woreda; people and their whole ancestry now come from Master Data, with the CSV as fallback. New sync_geo_widgets step (SYNC_GEO_WIDGETS, default false) matches a register's geo dropdowns to the hierarchy actually loaded, since an extension's hardcoded level names produce dropdowns that silently return nothing against a country that names them differently. Labels are left alone but reported when they name the wrong level. ([`782fa19`](https://github.com/OpenG2P/registry-platform/commit/782fa19fafd11251d7fd737058e14b3834667862))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Validate coded values against the seeded country lists, behind registry_core_validate_attribute_values (default false). This is the check the compiled enums do today, and it is what lets them be deleted: an enum is fixed at image build time, so a registry validating against one can only serve the country it was built for. Fields map to lists by convention — 30 of Ethiopia's 34 already match a column name — with a field_map for the few that don't. Applied on both the change-request and intake-form paths. Also resolve sample-data geo ids against master-data instead of computing slug-paths, which match nothing once master-data is seeded from a P-coded pack; slug-paths remain the fallback and the outcome is always reported. ([`b806b8a`](https://github.com/OpenG2P/registry-platform/commit/b806b8aee6845b8cf0594e40634542ffb710feb5))
- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Seed registry code lists from Master Data, behind LOAD_ATTRIBUTES (default false). The registry copies the country pack's lists into its own tables at install and validates against that copy after, so MDS is an install-time dependency, not a runtime one. Roles go in a new table, not a new column: create_all never adds columns to existing tables, so a column would be declared by the ORM and missing from every upgraded database. Where an extension fixture and the pack define the same list, the pack replaces it — merging left PROGRAM_NAME with 18 values and a dropdown showing every programme twice — and each replaced value is logged. ([`62dee1a`](https://github.com/OpenG2P/registry-platform/commit/62dee1a537ef6ccc6303c21219c755368d7281ae))

<a id="v-0-0-0-develop-331"></a>

## registry-platform — develop 0.0.0-develop.331 (2026-07-31)

_commit `ed1d67a` · changes since 0.0.0-develop.329_
<!-- build:0.0.0-develop.331 revision:ed1d67a83ef73da194289862a47d61662724c3c1 ts:1785412578 -->

### Summary

- Dependency updates: synchronized `staff-portal-ui` to version `1.1.6-dev.3` and updated related package manifests for `ui-widgets`.
- Documentation improvement: clarified geo-join functionality in `load_sample_data.py`, addressing discrepancies between master data and demographic records.

### Changes since 0.0.0-develop.329

- [G2P-4804](https://openg2p.atlassian.net/browse/G2P-4804) Correct the geo-join comment in load_sample_data.py. It claimed the slug-path id keeps the registry<->master-data join working, but master data is now seeded from P-coded country packs, so demography-seeded records carry ids MDS has never heard of and never appear on a map. Documents the mismatch and the two-part fix. ([`ed1d67a`](https://github.com/OpenG2P/registry-platform/commit/ed1d67a83ef73da194289862a47d61662724c3c1))
- chore(ui-widgets): version for npm next publish, sync staff-portal-ui @1.1.6-dev.3 [skip ci] ([`0169c66`](https://github.com/OpenG2P/registry-platform/commit/0169c661a768770067d044ae1d3b67acdfd741cc))

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
