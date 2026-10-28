"""Measure the real shell commands with CodSpeed's pytest integration."""

import os
from pathlib import Path
import subprocess

import pytest


BENCH_DIR = Path(__file__).resolve().parent


@pytest.fixture(scope="session", autouse=True)
def benchmark_environment():
    home = Path(os.environ["DOTFILES_BENCH_HOME"])
    if not (home / ".zshrc").is_file():
        pytest.fail("Run bench/prepare.sh with DOTFILES_BENCH_HOME first")
    if not os.environ.get("HOMEBREW_CELLAR"):
        pytest.fail("Set HOMEBREW_CELLAR before running the benchmarks")


def run_command(*command):
    subprocess.run(
        [str(BENCH_DIR / command[0]), *command[1:]],
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
    )


def test_zsh_startup(benchmark):
    benchmark(run_command, "zsh-startup.sh")


def test_zsh_custom(benchmark):
    benchmark(run_command, "zsh-custom.sh")


def test_php_aliases_current(benchmark):
    benchmark(run_command, "php-aliases.sh")
