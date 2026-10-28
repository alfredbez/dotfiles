#!/usr/bin/env bash
# Prepare an isolated benchmark home without touching an existing directory.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
OH_MY_ZSH_REF="${OH_MY_ZSH_REF:-17a2b4c3a5855524ad4772a17ada0dc474e2fdf3}"

if [ -e "$BENCH_HOME" ] || [ -L "$BENCH_HOME" ]; then
    echo "Refusing to overwrite existing benchmark home: $BENCH_HOME" >&2
    exit 1
fi
if [ "$(uname -s)" != Darwin ]; then
    echo "These benchmarks require macOS and Homebrew." >&2
    exit 1
fi
for cmd in brew git zsh python3; do
    command -v "$cmd" >/dev/null || { echo "Missing required command: $cmd" >&2; exit 1; }
done
export HOMEBREW_CELLAR="${HOMEBREW_CELLAR:-$(brew --cellar)}"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

mkdir -p "$(dirname "$BENCH_HOME")"
mkdir "$BENCH_HOME"
BENCH_HOME="$(cd "$BENCH_HOME" && pwd -P)"
git init --quiet "$BENCH_HOME/.oh-my-zsh"
git -C "$BENCH_HOME/.oh-my-zsh" fetch --quiet --depth=1 \
    https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_REF"
git -C "$BENCH_HOME/.oh-my-zsh" checkout --quiet FETCH_HEAD
ln -s "$DOTFILES_DIR/.zshrc" "$BENCH_HOME/.zshrc"

# Like the real local configuration, initialize Homebrew before Oh My Zsh.
# This supplies HOMEBREW_CELLAR to the production alias code.
# shellcheck disable=SC2016 # The command substitution belongs in the generated file.
printf 'eval "$(%q shellenv)"\n' "$(command -v brew)" > "$BENCH_HOME/.zshrc.local"

# Confirm the current code discovers at least three PHP versions and creates
# an alias for each one, without invoking those aliases.
versions="$(DOTFILES_BENCH_HOME="$BENCH_HOME" "$DOTFILES_DIR/bench/php-aliases.sh" versions)"
count="$(printf '%s\n' "$versions" | awk -F, '{ print NF }')"
if [ -z "$versions" ] || [ "$count" -lt 3 ]; then
    echo "Need at least three distinct Homebrew PHP versions; found: $versions" >&2
    exit 1
fi
printf 'PHP versions discovered: %s\n' "$versions"
DOTFILES_BENCH_HOME="$BENCH_HOME" "$DOTFILES_DIR/bench/php-aliases.sh" aliases >/dev/null

# Warm the real Zsh completion cache before timing.
DOTFILES_BENCH_HOME="$BENCH_HOME" "$DOTFILES_DIR/bench/zsh-startup.sh"
DOTFILES_BENCH_HOME="$BENCH_HOME" "$DOTFILES_DIR/bench/zsh-startup.sh"
echo "Benchmark HOME ready at $BENCH_HOME"
