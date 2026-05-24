# Docker validation is intentionally deferred for this M1-safe local COBOL tranche.
# The native validation lane uses Homebrew GnuCOBOL on macOS.
FROM alpine:3.20
CMD ["sh", "-c", "echo 'Docker validation deferred for cobol-stakeholder'; exit 1"]
