#!/usr/bin/env bash
# Prepare an isolated HOME used by the CodSpeed benchmarks in codspeed.yml.
# Installs a pinned Oh My Zsh and links the dotfiles into it with install.sh,
# then starts zsh once so completion caches exist before measuring.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_HOME="${DOTFILES_BENCH_HOME:-${TMPDIR:-/tmp}/dotfiles-bench-home}"
OH_MY_ZSH_REF="${OH_MY_ZSH_REF:-17a2b4c3a5855524ad4772a17ada0dc474e2fdf3}"

rm -rf "$BENCH_HOME"
mkdir -p "$BENCH_HOME"

git init --quiet "$BENCH_HOME/.oh-my-zsh"
git -C "$BENCH_HOME/.oh-my-zsh" fetch --quiet --depth=1 \
    https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_REF"
git -C "$BENCH_HOME/.oh-my-zsh" checkout --quiet FETCH_HEAD

HOME="$BENCH_HOME" SHELL="$(command -v zsh)" "$DOTFILES_DIR/install.sh" >/dev/null

# Warm up compinit's dump file and Oh My Zsh caches.
"$DOTFILES_DIR/bench/zsh-startup.sh"
"$DOTFILES_DIR/bench/zsh-startup.sh"

echo "Benchmark HOME ready at $BENCH_HOME"
