## master-data-service — Unreleased (0.0.0-develop.22, 2026-07-13)

_commit `54307f3` · baseline: release the start_
<!-- build:0.0.0-develop.22 revision:54307f32726d73c3bd1d0f0995ebe4c4b89e3038 -->

### Summary

_All changes since release the start:_

- Improved API stability and added new endpoints for geographic data.
- Enhanced master data management with registry integration and IAM support.
- Fixed various pre-commit and Docker-related issues.
- Updated versioning and deployment configurations.

### Since last release (the start)

- [G2P-5335](https://openg2p.atlassian.net/browse/G2P-5335) New CI implemented. (`54307f3`)
- Fix API boot crash: migrate to iam-core 1.3 auth API; use fastapi-common develop (`81e48ae`)
- Fix for pre-commit error. (`ead069c`)
- 0.0.0-develop.N versioning implemented. Postgres init helm fixed. (`48a5039`)
- pre-commit fix (`c3c4d0b`)
- [G2P-5268](https://openg2p.atlassian.net/browse/G2P-5268): Enhance master-data API with registry database integration and IAM support (`192f442`)
- [G2P-5264](https://openg2p.atlassian.net/browse/G2P-5264): Add get_all_g2p_geo_levels API endpoint and response handling (`2dbea0e`)
- Remove db-seed Dockerfile, entrypoint script, and related Kubernetes job configuration from the repository. (`9533157`)
- Refactor geo data loading to use a single denormalized CSV. Update logic to derive hierarchy and path IDs for geo levels and values. Adjusted database insertion methods for idempotency and clarified uniqueness constraints in the model. (`0995a76`)
- Fix docker issue (`8b478f6`)
- Remove unique constraint (`ccdfff4`)
- [G2P-4934](https://openg2p.atlassian.net/browse/G2P-4934) - master-data seeding + docker (`b464953`)
- [G2P-5144](https://openg2p.atlassian.net/browse/G2P-5144) Pre-commit errors fixed. (`2ac3823`)
- [G2P-5144](https://openg2p.atlassian.net/browse/G2P-5144) Consolidated all repos. Initial version. (`c65eddc`)
- Initial commit (`4fa6336`)
