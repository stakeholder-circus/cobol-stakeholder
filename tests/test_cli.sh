#!/bin/sh
set -eu
BIN=${BIN:-bin/stakeholder}
TMP_DIR=${TMPDIR:-/tmp}/cobol-stakeholder-tests.$$
mkdir -p "$TMP_DIR"
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM
assert_contains() { file=$1; needle=$2; if ! grep -F "$needle" "$file" >/dev/null 2>&1; then echo "expected '$needle' in $file" >&2; cat "$file" >&2; exit 1; fi; }
"$BIN" --list-values > "$TMP_DIR/list-values.json"
assert_contains "$TMP_DIR/list-values.json" '"generatorFamilies"'
assert_contains "$TMP_DIR/list-values.json" '"code-analyzer"'
assert_contains "$TMP_DIR/list-values.json" '"platform-engineering"'
assert_contains "$TMP_DIR/list-values.json" '"knowledge-retrieval"'
assert_contains "$TMP_DIR/list-values.json" '"service-mesh-rpc-ops"'
assert_contains "$TMP_DIR/list-values.json" '"experimental-provider"'
"$BIN" --output-format json --focus-family code_analyzer --seed 123 > "$TMP_DIR/code.json"
assert_contains "$TMP_DIR/code.json" '"family":"code_analyzer"'
assert_contains "$TMP_DIR/code.json" '"rendererKey":"classic-six.code_analyzer"'
assert_contains "$TMP_DIR/code.json" '"sourceRepo":"cobol-stakeholder"'
"$BIN" --output-format json --focus-family platform-engineering --seed 8675309 > "$TMP_DIR/seed-a.json"
"$BIN" --output-format json --focus-family platform-engineering --seed 8675309 > "$TMP_DIR/seed-b.json"
diff -u "$TMP_DIR/seed-a.json" "$TMP_DIR/seed-b.json"
assert_contains "$TMP_DIR/seed-a.json" '"family":"platform_engineering"'
assert_contains "$TMP_DIR/seed-a.json" '"tranche":"modern-core"'
"$BIN" --focus-family metrics --seed 7 > "$TMP_DIR/text.txt"
assert_contains "$TMP_DIR/text.txt" 'family: metrics'
assert_contains "$TMP_DIR/text.txt" 'renderer: classic-six.metrics'
if "$BIN" --output-format yaml > "$TMP_DIR/invalid.out" 2> "$TMP_DIR/invalid.err"; then echo "invalid output format unexpectedly succeeded" >&2; exit 1; fi
assert_contains "$TMP_DIR/invalid.err" 'invalid --output-format'
if "$BIN" --experimental-provider openai > "$TMP_DIR/provider.out" 2> "$TMP_DIR/provider.err"; then echo "experimental provider unexpectedly succeeded" >&2; exit 1; fi
assert_contains "$TMP_DIR/provider.err" 'experimental provider'
echo "cli tests passed"
