# Toolchain

COBOL native validation uses GnuCOBOL on arm64 macOS.

## Proven commands

- `cobc --version`
- `cobc -x -free -o bin/stakeholder src/stakeholder.cob`
- `make compiler-proof`
- `make test`

Toolchain source: Homebrew bottled `gnucobol` 3.2_1 plus `berkeley-db` and `json-c`. Docker, Nix, and COBOL package managers are not required for the current deterministic first tranche.
