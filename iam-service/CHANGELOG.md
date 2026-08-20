# iam-service

_Published automatically._

**Repository:** [github.com/OpenG2P/iam-service](https://github.com/OpenG2P/iam-service)

| Version | Date | Type |
| --- | --- | --- |
| [`0.0.0-develop.80`](#v-0-0-0-develop-80) | 2026-08-20 | develop |
| [`0.0.0-develop.78`](#v-0-0-0-develop-78) | 2026-08-20 | develop |
| [`0.0.0-develop.77`](#v-0-0-0-develop-77) | 2026-08-10 | develop |
| [`0.0.0-develop.72`](#v-0-0-0-develop-72) | 2026-08-06 | develop |
| [`0.0.0-develop.70`](#v-0-0-0-develop-70) | 2026-08-06 | develop |

# Develop builds

<a id="v-0-0-0-develop-80"></a>

## iam-service — develop 0.0.0-develop.80 (2026-08-20)

_commit `6eac6a9` · changes since 0.0.0-develop.78_
<!-- build:0.0.0-develop.80 revision:6eac6a995e00b392fdf65b7a5a5faf983b14b38e ts:1787201110 -->

### Changes since 0.0.0-develop.78

- [G2P-5537](https://openg2p.atlassian.net/browse/G2P-5537) Refactor API routes and hooks for attribute management; streamline payload structures and enhance response handling ([`42d17ed`](https://github.com/OpenG2P/iam-service/commit/42d17edb31e640c3e2ac580c381309d1dc7f5055))

<a id="v-0-0-0-develop-78"></a>

## iam-service — develop 0.0.0-develop.78 (2026-08-20)

_commit `9de210b` · changes since 0.0.0-develop.77_
<!-- build:0.0.0-develop.78 revision:9de210b49892450a651173bdd85538db21e692b9 ts:1787200350 -->

### Changes since 0.0.0-develop.77

- [G2P-4929](https://openg2p.atlassian.net/browse/G2P-4929) Wire iam-agent-portal-api into the IAM chart behind a disabled-by-default switch ([`9de210b`](https://github.com/OpenG2P/iam-service/commit/9de210b49892450a651173bdd85538db21e692b9))

<a id="v-0-0-0-develop-77"></a>

## iam-service — develop 0.0.0-develop.77 (2026-08-10)

_commit `7e8db51` · changes since 0.0.0-develop.72_
<!-- build:0.0.0-develop.77 revision:7e8db5141c4728f694636c081e69ceb2241c41aa ts:1786352758 -->

### Summary

- Code cleanup: removed unused SQL seed script and login providers JSON, eliminated unused client directives, and refactored to implement the ApplicationsPageClient component.
- Configuration updates: enhanced values.yaml to include backend API URLs for iam-staff-ui and updated the login provider ID.
- Feature enhancement: improved IconBase64Field with MIME type detection and added delete permissions to IAM staff UI permissions.

### Changes since 0.0.0-develop.72

- Remove unused SQL seed script and login providers JSON; update IAM_STAFF_UI_PERMISSIONS to include delete permissions ([`1c5a6a6`](https://github.com/OpenG2P/iam-service/commit/1c5a6a633a477e72d5d16ff6e67fd97fc0fd39eb))
- Enhance values.yaml: Add backend API URLs for iam-staff-ui and update login provider ID ([`6d1d4f9`](https://github.com/OpenG2P/iam-service/commit/6d1d4f9d7708a7484dbff19db6fc89ab2cbfac34))
- Refactor: Remove unused use client directives and implement ApplicationsPageClient component ([`a694c5d`](https://github.com/OpenG2P/iam-service/commit/a694c5d11faf44ea65ea3197bc173ec56486d6f4))
- [G2P-5485](https://openg2p.atlassian.net/browse/G2P-5485) Enhance IconBase64Field with MIME type detection ([`2556ffa`](https://github.com/OpenG2P/iam-service/commit/2556ffa32f5137038cffca59e9e5deb91e5a82af))

<a id="v-0-0-0-develop-72"></a>

## iam-service — develop 0.0.0-develop.72 (2026-08-06)

_commit `f7f1d44` · changes since 0.0.0-develop.70_
<!-- build:0.0.0-develop.72 revision:f7f1d448e121e19cca13088ba6251f6921564bd3 ts:1786019264 -->

### Changes since 0.0.0-develop.70

- [G2P-5479](https://openg2p.atlassian.net/browse/G2P-5479) Add policy filter preview and view data policy modal components ([`5234a36`](https://github.com/OpenG2P/iam-service/commit/5234a3655cc2f27e4bb0471743df402ff66df143))

<a id="v-0-0-0-develop-70"></a>

## iam-service — develop 0.0.0-develop.70 (2026-08-06)

_commit `c607223` · changes since v1.3.0_
<!-- build:0.0.0-develop.70 revision:c607223ffb7ebdb4e3d132fa719253e1d4aea593 ts:1785992562 -->

### Summary

- **Major:** Implemented data policy management and middleware, enhancing compliance and governance capabilities.
- UI enhancements: Refactored application management with Keycloak integration, improved accessibility and consistency across UI components, and added reusable modals and loading skeletons.
- Authentication improvements: Refactored authentication and RBAC contexts, introduced reusable hooks/components, and implemented typed data management for applications and login providers.
- CI/CD updates: New continuous integration system implemented, alongside versioning changes for better release management.
- Testing improvements: Increased unit test coverage for IAM staff portal API components and core functionality, ensuring higher reliability and accuracy.

### Changes since v1.3.0

- Test: Update data policy middleware tests for accuracy and coverage ([`35f3bd9`](https://github.com/OpenG2P/iam-service/commit/35f3bd9004798e51b97bcdec69528df7cd9e9476))
- Feat: Implement data policy management and middleware ([`8a1c8cd`](https://github.com/OpenG2P/iam-service/commit/8a1c8cdca49d67828304428cd64f38da89570977))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Enhance application management with Keycloak integration ([`d7b1c7f`](https://github.com/OpenG2P/iam-service/commit/d7b1c7f348009636a95db8db1d0fd2c060250b12))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Refactor UI components for consistency: update styles, improve accessibility, and enhance user experience across error, button, input, and modal components ([`0c1d936`](https://github.com/OpenG2P/iam-service/commit/0c1d93694207a526adc4162de79743275c451bde))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Add reusable UI components, improve modal styling, and refactor application and login provider pages ([`12956d8`](https://github.com/OpenG2P/iam-service/commit/12956d893015c299b7f4057572f7bd9b6f33c6f0))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Refactor application and login provider components ([`b582d6f`](https://github.com/OpenG2P/iam-service/commit/b582d6fcd7a74a1202f7a642e1fa410c093301ed))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Add Roles, Permissions, and Role-Permissions management tabs with reusable modals, enhanced tables, login provider improvements, and loading skeletons ([`e70231c`](https://github.com/OpenG2P/iam-service/commit/e70231c8b56f1b0c908f5075025dbc038dc69abf))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Refactor authentication and RBAC contexts, introduce reusable hooks/components, and add typed application and login provider data management ([`7ff270c`](https://github.com/OpenG2P/iam-service/commit/7ff270cb101d0861b808be879b220880a3c8e5c9))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Refactor ApplicationAccess, Applications, and LoginProviders controllers to use strongly typed response models ([`ab5686d`](https://github.com/OpenG2P/iam-service/commit/ab5686dd272343ca932825f65a8acbc83da3cbfe))
- [G2P-5431](https://openg2p.atlassian.net/browse/G2P-5431) Implement Application Management module in IAM Staff UI ([`235f138`](https://github.com/OpenG2P/iam-service/commit/235f138d8a691ee6efb123d4791238748ec74a8e))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Fix chart-image-paths to .iamStaffPortalApi.image.tag (chart shipped unpinned) ([`947f58f`](https://github.com/OpenG2P/iam-service/commit/947f58f1b04920854189aa65c8b9c99ff708da39))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented ([`8109437`](https://github.com/OpenG2P/iam-service/commit/810943725a2040fadbf4c18868471f205daa930c))
- 0.0.0-develop.N versioning implemented. ([`a1579ba`](https://github.com/OpenG2P/iam-service/commit/a1579ba229373a333ceb75797685e3a086d2b9d8))
- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Add unit tests for IAM staff portal API components ([`8670822`](https://github.com/OpenG2P/iam-service/commit/867082285f362b88550be7ba2a265621eb0b8a4d))
- [G2P-5313](https://openg2p.atlassian.net/browse/G2P-5313) Improve unit test coverage for core IAM functionality ([`c762c7b`](https://github.com/OpenG2P/iam-service/commit/c762c7b741a5c9d19bbd30b6875daacbd5d88717))

---

> **What's shown here.** This catalogue lists **every stable release**, plus
> the **latest 20 develop builds** and the **latest 10 release
> candidates** per release line -- candidates are KEPT after their release
> ships, as the audit trail of the release run. Older develop builds and
> release candidates are pruned as they are superseded. Those versions
> still exist in the container and Helm
> registries — they are simply not listed here. This page is generated
> automatically from commit history; do not edit it by hand.
