#!/usr/bin/env bash
# Re-run install.sh against the already prepared HOME. Every link already
# exists, so this measures the idempotent (no-op) installer path.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"

HOME="$BENCH_HOME" SHELL="$(command -v zsh)" "$DOTFILES_DIR/install.sh" >/dev/null
