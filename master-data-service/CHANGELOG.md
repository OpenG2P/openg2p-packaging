# master-data-service changelog

_Published automatically. Newest first._

## master-data-service — Unreleased (0.0.0-develop.25, 2026-07-13)

_commit `815addd` · baseline: release the start · previous build 0.0.0-develop.24_
<!-- build:0.0.0-develop.25 revision:815addd771c33c9821b793076a77e77a17a80e8f -->

### Summary

_All changes since release the start:_

- Improved integration with the registry database and IAM for master data.
- Added a new API endpoint to retrieve all G2P geographic levels.
- Enhanced geo data loading for more efficient processing and hierarchy derivation.
- Resolved issues related to API boot crashes and pre-commit errors.

### New in this build (since 0.0.0-develop.24)

- [G2P-5341](https://openg2p.atlassian.net/browse/G2P-5341) Fix master-data-api boot crash: source keycloak_client_id from iam-core auth config ([`815addd`](https://github.com/OpenG2P/master-data-service/commit/815addd771c33c9821b793076a77e77a17a80e8f))

### Since last release (the start)

- [G2P-5341](https://openg2p.atlassian.net/browse/G2P-5341) Fix master-data-api boot crash: source keycloak_client_id from iam-core auth config ([`815addd`](https://github.com/OpenG2P/master-data-service/commit/815addd771c33c9821b793076a77e77a17a80e8f))
- [G2P-5341](https://openg2p.atlassian.net/browse/G2P-5341): Clean up registry DB and data policy codechanges in data policy handling. ([`2253343`](https://github.com/OpenG2P/master-data-service/commit/225334332fbdeffbc3a45243e6f8c56177f4508e))
- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented. ([`54307f3`](https://github.com/OpenG2P/master-data-service/commit/54307f32726d73c3bd1d0f0995ebe4c4b89e3038))
- Fix API boot crash: migrate to iam-core 1.3 auth API; use fastapi-common develop ([`81e48ae`](https://github.com/OpenG2P/master-data-service/commit/81e48ae613337c5368bd11eaccc44dfb3400382a))
- Fix for pre-commit error. ([`ead069c`](https://github.com/OpenG2P/master-data-service/commit/ead069c724d157407402408a27eb28915a9e0f1a))
- 0.0.0-develop.N versioning implemented. Postgres init helm fixed. ([`48a5039`](https://github.com/OpenG2P/master-data-service/commit/48a5039f389038749d3d024fe608a6d8edc3e3ab))
- pre-commit fix ([`c3c4d0b`](https://github.com/OpenG2P/master-data-service/commit/c3c4d0b230f1dd8714771b466c09cb7182043f1f))
- [G2P-5268](https://openg2p.atlassian.net/browse/G2P-5268): Enhance master-data API with registry database integration and IAM support ([`192f442`](https://github.com/OpenG2P/master-data-service/commit/192f44229deb652fbdf34f7e21f44b360feb95a3))
- [G2P-5264](https://openg2p.atlassian.net/browse/G2P-5264): Add get_all_g2p_geo_levels API endpoint and response handling ([`2dbea0e`](https://github.com/OpenG2P/master-data-service/commit/2dbea0e341ad2bd58c0c3d7d24f4d4aab07fc6dd))
- Remove db-seed Dockerfile, entrypoint script, and related Kubernetes job configuration from the repository. ([`9533157`](https://github.com/OpenG2P/master-data-service/commit/9533157fe193a4b382410ffcc5ae99e5df793365))
- Refactor geo data loading to use a single denormalized CSV. Update logic to derive hierarchy and path IDs for geo levels and values. Adjusted database insertion methods for idempotency and clarified uniqueness constraints in the model. ([`0995a76`](https://github.com/OpenG2P/master-data-service/commit/0995a769d0e8e0890635c508cc2b1ac7bbd6d87b))
- Fix docker issue ([`8b478f6`](https://github.com/OpenG2P/master-data-service/commit/8b478f66ea306c738d305859bc8bcd1fd0883a0c))
- Remove unique constraint ([`ccdfff4`](https://github.com/OpenG2P/master-data-service/commit/ccdfff41e5260f71220cac4c2350f3702581a3b4))
- [G2P-4934](https://openg2p.atlassian.net/browse/G2P-4934) - master-data seeding + docker ([`b464953`](https://github.com/OpenG2P/master-data-service/commit/b46495387e48070d947ca2565ed5baa2c5f8e1b1))
- [G2P-5144](https://openg2p.atlassian.net/browse/G2P-5144) Pre-commit errors fixed. ([`2ac3823`](https://github.com/OpenG2P/master-data-service/commit/2ac3823aeb99baa0c6d91360058109992d8fc8ff))
- [G2P-5144](https://openg2p.atlassian.net/browse/G2P-5144) Consolidated all repos. Initial version. ([`c65eddc`](https://github.com/OpenG2P/master-data-service/commit/c65eddc91987bb69c5a51093f9ab93b12b264aa4))
- Initial commit ([`4fa6336`](https://github.com/OpenG2P/master-data-service/commit/4fa63366263b94176bd2c4de25c10f079fb63eec))

