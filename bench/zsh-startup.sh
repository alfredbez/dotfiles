#!/usr/bin/env bash
# Time an interactive login shell running the actual committed .zshrc.
set -euo pipefail
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
HOME="$BENCH_HOME" ZDOTDIR="$BENCH_HOME" DISABLE_AUTO_UPDATE=true exec /bin/zsh -l -i -c exit
