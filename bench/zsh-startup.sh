#!/usr/bin/env bash
# Start an interactive zsh with the full .zshrc (Oh My Zsh, plugins, theme)
# and exit immediately. Run bench/prepare.sh first.
set -euo pipefail

BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"

HOME="$BENCH_HOME" DISABLE_AUTO_UPDATE=true exec zsh -i -c exit
