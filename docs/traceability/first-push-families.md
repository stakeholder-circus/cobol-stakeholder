# First push families

This local tranche ports the deterministic family-focus contract into a compiled GnuCOBOL runtime.

| Family group | COBOL path | Source reference | Parity class |
| --- | --- | --- | --- |
| classic-six | `src/stakeholder.cob` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| modern-core | `src/stakeholder.cob` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| later families | `src/stakeholder.cob` | grouped fallback policy in current deterministic repos | grouped fallback |
| CLI contract | `src/stakeholder.cob`, `tests/test_cli.sh` | small-tranche smoke contract | deterministic |
| experimental provider | `src/stakeholder.cob`, `tests/test_cli.sh` | fail-fast provider policy in current deterministic repos | explicit fail-fast |

Rust and Java remain canonical behavioral anchors; this COBOL tranche is local-only and native-validated.
