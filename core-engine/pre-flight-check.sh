#!/usr/bin/env bash
set -Eeuo pipefail

# Scan a target tree for common unsafe patterns. This is a signal generator,
# not a substitute for domain-specific tests, audits, or official tooling.
TARGET="${1:-.}"
if [[ ! -d "$TARGET" ]]; then
  printf 'error: target directory does not exist: %s\n' "$TARGET" >&2
  exit 2
fi

if ! command -v grep >/dev/null 2>&1; then
  printf 'error: grep is required\n' >&2
  exit 2
fi

failures=0
scan() {
  local label="$1"
  local pattern="$2"
  if grep -RInE --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=vendor -- "$pattern" "$TARGET" >/tmp/nexus-core-scan.$$ 2>/dev/null; then
    printf 'FAIL [%s]\n' "$label"
    cat /tmp/nexus-core-scan.$$
    failures=$((failures + 1))
  else
    printf 'PASS [%s]\n' "$label"
  fi
}

trap 'rm -f /tmp/nexus-core-scan.$$' EXIT

scan 'hard-coded secrets' '(^|[^A-Za-z])(PRIVATE_KEY|SECRET|API_KEY|PASSWORD)[[:space:]]*[:=][[:space:]]*["'"']?[^"'"'[:space:]]+'
scan 'Solidity unchecked call' '\.call\{value:|\.delegatecall\(|\.send\('
scan 'Solidity tx.origin' '\btx\.origin\b'
scan 'unsafe innerHTML' '\.innerHTML[[:space:]]*='
scan 'unbounded timers/listeners' 'setInterval\(|addEventListener\('
scan 'wildcard CORS' 'Access-Control-Allow-Origin["'"' ]*:["'"' ]*\*|cors\([^)]*origin["'"' ]*:["'"' ]*["'"' ]*\*["'"' ]*'
scan 'insecure HTTP URLs' 'http://[^[:space:]"'"'<>]+'
scan 'unverified dependency install' 'npm install|yarn add|pnpm add|pip install'

if [[ "$failures" -gt 0 ]]; then
  printf '\nPre-flight failed with %d finding group(s). Review each match and rerun.\n' "$failures" >&2
  exit 1
fi
printf '\nPre-flight passed: no banned pattern groups detected.\n'
