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

Shell startup time and the installer are tracked with
[CodSpeed](https://codspeed.io) using the benchmarks defined in `codspeed.yml`.
To run them locally:

```sh
./bench/prepare.sh            # creates an isolated HOME in $TMPDIR
codspeed run --mode walltime
```
