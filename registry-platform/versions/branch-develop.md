## registry-platform — `develop` branch (2026-07-19)

_moving branch · latest commit `c73493f` · baseline: v1.0.0_
<!-- build:develop revision:c73493fd9c9990fe57ee36b28461aba944bcaf17 ts:1784449800 -->

### Summary

_Changes on `develop` since v1.0.0:_

- Repointed Partner Management to use commons-services and aligned PM-seed authentication to the g2p-bridge pmSeedClientId pattern.
- Added cookieDomain to environment configuration and updated authentication cookie handling.
- Enhanced consent management, partner management, and WJS support.
- Added client-side CSRF token handling for improved security.
- Refactored IAM permission handling and authentication cookie management.
- Added a new endpoint, list_tasks_for_request, and related functionality.
- Added the assignee_name field to the ApprovalTask model and updated related logic.
- Implemented permission decoration on one API.
- Fixed terminal approval validation to rollback CR changes when validation fails.
- Updated Content Security Policy (CSP) header to include upgrade-insecure-requests.
- Fixed translations and UI schema seeding issues.
- Corrected the version in init.py to 0.0.0-dev0.
- Updated environment variables and refactored logout handling.
- Added library changelog tracking for better version management.
- Introduced a changelog workflow in GitHub Actions for automated tracking.
- Removed sample locale file from the staff portal UI.

### Recent commits (latest 5)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`c73493f`](https://github.com/OpenG2P/registry-platform/commit/c73493fd9c9990fe57ee36b28461aba944bcaf17))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking (kind: library) ([`532a3f9`](https://github.com/OpenG2P/registry-platform/commit/532a3f96341f56c3438421fa984bbc807292f1dc))
- [G2P-5319](https://openg2p.atlassian.net/browse/G2P-5319) Permission decorated enabled on one API. ([`e11e8fe`](https://github.com/OpenG2P/registry-platform/commit/e11e8fe14d717636da5cc8cd1c3d16694db57cca))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Repoint Partner Management to commons-services and align PM-seed auth to the g2p-bridge pmSeedClientId pattern. ([`7d798a4`](https://github.com/OpenG2P/registry-platform/commit/7d798a430fb4ae254fdd749ed06b766bff8f2fc7))
- [G2P-5222](https://openg2p.atlassian.net/browse/G2P-5222) Consent and partner management related. ([`873f96a`](https://github.com/OpenG2P/registry-platform/commit/873f96aa7c2624e5bcee3ca51df344d659f6cdd2))
