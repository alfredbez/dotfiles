#!/usr/bin/env bash
# Measure the current alias setup, including PHP version discovery.
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
case "${1:-}" in
    ''|versions|aliases) ;;
    *) echo 'Usage: php-aliases.sh [versions|aliases]' >&2; exit 1 ;;
esac
export DOTFILES_BENCH_ALIASES="$DOTFILES_DIR/oh-my-zsh-custom/20_aliases.zsh"
export DOTFILES_BENCH_OUTPUT="${1:-}"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_CELLAR="${HOMEBREW_CELLAR:-$(brew --cellar)}"
HOME="$BENCH_HOME" ZDOTDIR="$BENCH_HOME" exec /bin/zsh -f -c '
    is_macos() { [[ $(uname -s) == Darwin ]] }
    is_ubuntu() { return 1 }
    source "$DOTFILES_BENCH_ALIASES"
    if [[ $DOTFILES_BENCH_OUTPUT == versions ]]; then
        print -r -- ${(j:,:)installedPhpVersions}
    elif [[ $DOTFILES_BENCH_OUTPUT == aliases ]]; then
        for version in $installedPhpVersions; do
            alias "$version" || exit 1
        done
    fi
'
