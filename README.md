# dotfiles

[![CodSpeed](https://img.shields.io/endpoint?url=https://codspeed.io/badge.json)](https://app.codspeed.io/alfredbez/dotfiles?utm_source=badge)

```sh
git clone --recursive https://github.com/alfredbez/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

## Machine-specific shell setup

Put machine-specific paths, tool initialization and private settings in
`~/.zshrc.local`. It is sourced before Oh My Zsh and is not tracked. For
example, configure Homebrew using the path appropriate for your Mac:

```sh
# Apple Silicon; use /usr/local/bin/brew on Intel Macs.
eval "$(/opt/homebrew/bin/brew shellenv)"
```

`pyenv`, `fnm`, McFly, Google Cloud SDK and OpenClaw integrations are optional.
Pyenv shims are available immediately; shell integration and rehashing run on
the first `pyenv` command or completion. Run `pyenv rehash` if a newly installed
Python executable needs a shim before then.

## Benchmarks

[CodSpeed](https://codspeed.io) tracks shell startup and PHP alias discovery
on a macOS runner. CI installs three Homebrew PHP versions and GNU grep. The
current implementation and the original `brew ls --versions` pipeline run
against the same installation; preparation verifies that both discover the same
versions and produce identical aliases. The full-shell benchmark measures
`zsh -l -i -c exit`, not an actual terminal's first prompt. Hosted-runner
walltime is noisy; compare trends rather than treating small differences as
regressions. The benchmarks use the pytest-codspeed integration because
CodSpeed's command exec-harness does not ship a macOS binary. Measured timings
include Python subprocess-launch overhead. Profiling is disabled.

To run locally on macOS, install at least three PHP versions, GNU grep and the
CodSpeed CLI and `pytest-codspeed==5.0.3`, then use a new, non-existing
temporary home:

```sh
export DOTFILES_BENCH_HOME="${TMPDIR:-/tmp}/dotfiles-bench-$$"
export HOMEBREW_CELLAR="$(brew --cellar)"
export CODSPEED_PROFILER_ENABLED=false
./bench/prepare.sh
codspeed run --mode walltime
```

Preparation refuses to overwrite an existing home. The fixture contains a
pinned Oh My Zsh and a minimal Homebrew `.zshrc.local`; it does not replicate
machine-specific tool setups, so it will not reproduce every cost of a real
desktop shell. Tools already available on the runner may still be detected. The
Homebrew formulas are currently `php`, `php@8.4` and `php@8.3`; update them as
supported versions change.
