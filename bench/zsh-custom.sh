#!/usr/bin/env bash
# Source only the custom functions and aliases, without Oh My Zsh.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
export DOTFILES_DIR
export HOMEBREW_CELLAR="${HOMEBREW_CELLAR:-$(brew --cellar)}"
HOME="$BENCH_HOME" ZDOTDIR="$BENCH_HOME" exec /bin/zsh -f -i -c '
    source "$DOTFILES_DIR/oh-my-zsh-custom/10_functions.zsh"
    source "$DOTFILES_DIR/oh-my-zsh-custom/20_aliases.zsh"
'
