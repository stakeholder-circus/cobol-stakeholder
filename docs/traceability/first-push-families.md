# Deterministic tranche traceability

This tranche ports the deterministic family-focus contract into a compiled GnuCOBOL runtime.

| Family group | COBOL path | Source reference | Parity class |
| --- | --- | --- | --- |
| classic-six | src/stakeholder.cob | Rust and Java deterministic family registry and normalized output contract | dedicated |
| modern-core | src/stakeholder.cob | Rust and Java deterministic family registry and normalized output contract | dedicated |
| later families | src/stakeholder.cob | canonical grouped fallback policy | grouped fallback |
| CLI contract | src/stakeholder.cob, tests/test_cli.sh | stakeholder-core CLI and normalized JSON contract | deterministic |
| experimental provider | src/stakeholder.cob, tests/test_cli.sh | canonical provider isolation policy | explicit fail-fast |

Rust and Java remain canonical behavioral anchors. Native and Docker GitHub jobs validate this committed COBOL tranche.
