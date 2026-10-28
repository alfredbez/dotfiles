#!/usr/bin/env bash
# Source only the custom functions and aliases, without Oh My Zsh.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

exec zsh -f -i -c "
source '$DOTFILES_DIR/oh-my-zsh-custom/10_functions.zsh'
source '$DOTFILES_DIR/oh-my-zsh-custom/20_aliases.zsh'
"
