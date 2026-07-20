# registry-platform

_Published automatically._

**Repository:** [github.com/OpenG2P/registry-platform](https://github.com/OpenG2P/registry-platform)

| Version | Date | Type |
| --- | --- | --- |
| [`develop`](#v-branch-develop) | 2026-07-20 | branch |

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

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
