#!/usr/bin/env bash
# Source identical alias files, differing only in PHP version discovery.
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
case "${1:-}" in
    current) aliases="$DOTFILES_DIR/oh-my-zsh-custom/20_aliases.zsh" ;;
    legacy) aliases="$BENCH_HOME/legacy-aliases.zsh" ;;
    *) echo 'Usage: php-aliases.sh current|legacy [versions|aliases]' >&2; exit 1 ;;
esac
export DOTFILES_BENCH_ALIASES="$aliases"
export DOTFILES_BENCH_OUTPUT="${2:-}"
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
