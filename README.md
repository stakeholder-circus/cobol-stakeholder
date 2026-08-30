> [!NOTE]
> This repository is AI-assisted and manually reviewed. Copyright may subsist only in human-authored portions to the extent applicable.

# cobol-stakeholder

Compiled GnuCOBOL implementation of the stakeholder deterministic first tranche.

## Implemented

- Full dedicated classic-six + modern-core generator families.
- Grouped fallback for later generator families.
- Deterministic normalized JSON with same-seed stability.
- CLI support for list-values, focus-family, output-format, and seed.
- Explicit experimental-provider fail-fast.

## Validation

- python3 scripts/validate_scaffold.py
- make compiler-proof
- make analyze
- make test
- docker build -t cobol-stakeholder .
- docker run --rm cobol-stakeholder --list-values

GitHub CI is authoritative for Ubuntu native, Docker, compiler-warning SAST, dependency review, actionlint, and workflow-security gates.
