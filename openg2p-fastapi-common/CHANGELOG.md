# openg2p-fastapi-common

_Published automatically._

**Repository:** [github.com/OpenG2P/openg2p-fastapi-common](https://github.com/OpenG2P/openg2p-fastapi-common)

| Version | Date | Type | Notes |
| --- | --- | --- | --- |
| [`1.2.1`](#v-1-2-1) | 2026-09-04 | release |  |
| [`develop`](#v-branch-develop) | 2026-09-02 | branch |  |
| [`1.2.0`](#v-1-2-0) | 2026-09-01 | release |  |

# Releases

<a id="v-1-2-1"></a>

## openg2p-fastapi-common 1.2.1 — 2026-09-04

<!-- build:1.2.1 revision:4a05bf1b5ead891d37cbdabded4c668721d5f1be ts:1788511318 -->

_commit `4a05bf1` · changes since release 1.2.0_

### Release notes

## What's Changed
* [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmak… by @vin0dkhichar in https://github.com/OpenG2P/openg2p-fastapi-common/pull/68
* Fix session management integration in crypto modules for 1.2 branch by @vin0dkhichar in https://github.com/OpenG2P/openg2p-fastapi-common/pull/69
* Bump version to 1.2.1 by @vin0dkhichar in https://github.com/OpenG2P/openg2p-fastapi-common/pull/70


**Full Changelog**: https://github.com/OpenG2P/openg2p-fastapi-common/compare/1.2.0...1.2.1

### Summary

- **Major:** Version bump to 1.2.1, indicating a new release.
- Security enhancement: fixed session management integration in crypto modules for improved reliability.
- Database improvements: enhanced connection management with async sessionmaker and optimized pool settings for better performance.
- Documentation updates: revised README to reflect migration to GitLab, including formatting fixes and updated repository links. 
- New test coverage: added a test file for database pool and sessionmaker functionality.

### Changes

- Bump version to 1.2.1 ([`3eda2e4`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/3eda2e43f91b0c02e05f599c56935d5e2088d963))
- Fix session management integration in crypto modules for 1.2 branch ([`e65568f`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/e65568f0e8e1812aba4ecef1666d48f4e789d586))
- [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmaker and pool settings ([`17057b7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17057b7ec69f02bc982813886749d61a4f94d620))
- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))
- Format project name and update repository location ([`8df6fe7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/8df6fe726af4eef7ec281d9890e45dc31ef10509))
- Update README.md ([`1dd3991`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/1dd39910c6f1c8b7dcbeba46aa3d2a186e75b480))

<a id="v-1-2-0"></a>

## openg2p-fastapi-common 1.2.0 — 2026-09-01

<!-- build:1.2.0 revision:2926e24b19fb04dba31b40d326d6ad59b2ad30b7 ts:1788254820 -->

_commit `2926e24` · changes since release v1.1.5_

### Release notes

## What's Changed
* 1.1 into develop by @PSNAppz in https://github.com/OpenG2P/openg2p-fastapi-common/pull/58
* 1.1 by @venky-ganapathy in https://github.com/OpenG2P/openg2p-fastapi-common/pull/64
* [G2P-5581](https://openg2p.atlassian.net/browse/G2P-5581) remove obsolete openg2p-fastapi-partner-auth module and introduce centralized crypto/key management by @pjoshi751 in https://github.com/OpenG2P/openg2p-fastapi-common/pull/67

## New Contributors
* @venky-ganapathy made their first contribution in https://github.com/OpenG2P/openg2p-fastapi-common/pull/64
* @pjoshi751 made their first contribution in https://github.com/OpenG2P/openg2p-fastapi-common/pull/67

**Full Changelog**: https://github.com/OpenG2P/openg2p-fastapi-common/compare/v1.1.7...1.2.0

### Summary

- **Major:** Removed deprecated authentication components and the obsolete openg2p-fastapi-partner-auth module, introducing centralized crypto/key management in openg2p-fastapi-common.
- Notification system enhancement: Added Novu notification implementation and related configurations.
- Database connection stability: Enabled connection-pool pre-ping and recycle to prevent stale pooled connections, addressing intermittent HTTP 500 errors.
- Security improvements: Introduced middleware for security headers in API responses and added tests for these headers.
- Dependency updates: Updated FastAPI dependency and made changes to various dependency manifests.
- Changelog management: Implemented automated library changelog tracking and removed the obsolete manual tag.yml.
- Local crypto management added to bypass Keymanager, along with caching of keys for partner management service.

### Changes

- [G2P-5605](https://openg2p.atlassian.net/browse/G2P-5605) Point the package metadata at GitHub ([`ad1b0b1`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ad1b0b1573b4982d9304ad4531f5a4763ada3cf1))
- [G2P-5602](https://openg2p.atlassian.net/browse/G2P-5602) Add Novu notification implementation and related configurations ([`0a2bc12`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/0a2bc128c25b0bd33036a3e395eff49f69c9ea1e))
- G2p-5581 Remove deprecated authentication components and update FastAPI dependency ([`7103451`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/710345129fea2f554a2276b08af60a5251a607b1))
- [G2P-5581](https://openg2p.atlassian.net/browse/G2P-5581) remove obsolete openg2p-fastapi-partner-auth module and introduce centralized crypto/key management in openg2p-fastapi-common ([`3d0442a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/3d0442af074881302ec56abd203b12fb2464a7c9))
- [G2P-5383](https://openg2p.atlassian.net/browse/G2P-5383) fastapi-common: enable connection-pool pre-ping and recycle — SQLAlchemy defaults (pre_ping=False, recycle=-1) let every service hand out stale pooled connections, surfacing as intermittent HTTP 500s (asyncpg ConnectionDoesNotExistError) on long-running pods such as the Consent Manager ([`b11fac3`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/b11fac39f8db6dc12581bf14d179c67ed5bce672))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Grant packages: write in library changelog caller (reusable images/chart jobs require it at startup) ([`dd7de09`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/dd7de091b14b9080791d131ecd8151cd35b31fd7))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Fix ruff C408 (dict() -&gt; literal) in test_partner_mgmt_key_store.py ([`9ddccc0`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9ddccc00f502c49415c0220e72d17a4a8edc3c5a))
- Just to trigger workflows, no change in code ([`17cda3d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17cda3d3341420b50b50d2950b97db3c7a9885d3))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) Add library changelog tracking; drop obsolete manual tag.yml ([`c129243`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/c129243dd26f802a8861563fe38d4c8d37544254))
- [G2P-5261](https://openg2p.atlassian.net/browse/G2P-5261) Caching of keys added as we are using partner management service going forward. ([`8869814`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/886981402893b9011dc6a68ffdf2448fba1c85df))
- [G2P-5209](https://openg2p.atlassian.net/browse/G2P-5209) Local crypto management added (to bypass Keymanager) ([`f77ff90`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/f77ff9008e5cc84af13e3be5e675a4e444e142c6))
- [G2P-4490](https://openg2p.atlassian.net/browse/G2P-4490) style: pre-commit fix ([`9ed50ea`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/9ed50eac614055ec339908135ca0e87c8703bb95))
- [G2P-4490](https://openg2p.atlassian.net/browse/G2P-4490) test(api): add tests for security headers in api responses ([`50799bb`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/50799bb55fe993b7d2e3893f96e5cec0d6a31a2b))
- [G2P-4490](https://openg2p.atlassian.net/browse/G2P-4490) feat(api): add security headers middleware ([`ae620d0`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ae620d08a6a3ef57f812c06939299ccd51239c31))

# Branches (moving)

<a id="v-branch-develop"></a>

## openg2p-fastapi-common — `develop` branch (2026-09-02)

_moving branch · latest commit `5a855e2` · baseline: v1.1.5_
<!-- build:develop revision:5a855e201c56c54998de2c92a06bb10f1db89ad0 ts:1788325413 -->

### Summary

_Changes on `develop` since v1.1.5:_

- **Major:** Enhanced database connection management with async sessionmaker and connection pool settings, including pre-ping and recycling to prevent stale connections causing HTTP 500 errors.
- Security improvements: Added middleware for security headers in API responses and implemented tests to verify their presence.
- Repository migration: Updated README files to reflect the transition from GitHub to GitLab, including formatting fixes and repository link updates.
- Dependency updates: Modified dependency manifests in `pyproject.toml` and added changelog tracking for library updates.
- Testing enhancements: Introduced new tests for database connection management and partner management key store, alongside fixes for existing test code.

### Recent commits (latest 5)

- [G2P-5620](https://openg2p.atlassian.net/browse/G2P-5620) Enhance database connection management with async sessionmaker and pool settings ([`17057b7`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/17057b7ec69f02bc982813886749d61a4f94d620))
- Update README to reflect repository migration to GitLab ([`6a5ed6d`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/6a5ed6dea154808836ba540d1fa46d401e2fac77))
- Update README to reflect repository migration to GitLab ([`491b36b`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/491b36b0e9fed5065ae20455f8dc27ffbd76a7f7))
- Revise README to indicate GitLab migration ([`406933a`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/406933a4913430d9096c0aa4a59dc5f171b89b79))
- Fix README formatting and update repository link ([`ef554af`](https://github.com/OpenG2P/openg2p-fastapi-common/commit/ef554afb6616d7764d65605e71eb069c1075f7c9))

---

> **What's shown here.** This is a **library**, consumed directly by git
> reference (a branch, tag, or commit) — there is no image or chart. Each
> **tagged version** is listed in full; each tracked **branch** shows its
> current state and its **last 5 commits**. Pin a **tag** (or a commit)
> for a fixed version, or a **branch** to track the latest. This page is
> generated automatically from commit history; do not edit it by hand.
