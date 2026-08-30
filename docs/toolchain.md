# Toolchain

COBOL validation uses GnuCOBOL.

## Sources

- macOS native feedback: Homebrew gnucobol.
- GitHub native and SAST: Ubuntu 24.04 gnucobol3.
- Portable runtime gate: Ubuntu 24.04 multi-stage Docker build with libcob4 in the non-root final image.
- Nix: repository development-shell policy only; GitHub and Docker remain the release evidence.

## Commands

- cobc --version
- make analyze
- make test
- docker build -t cobol-stakeholder .
- docker run --rm cobol-stakeholder --list-values
