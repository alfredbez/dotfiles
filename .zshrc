export DISABLE_AUTO_TITLE=true
export ZSH=$HOME/.oh-my-zsh
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
SAVEHIST=100000
HISTSIZE=1000
ZSH_CUSTOM="${${(%):-%N}:A:h}/oh-my-zsh-custom"
ZSH_THEME="spaceship"
BAT_THEME="Solarized (light)"
plugins=(git composer cp common-aliases sublime sudo z debian zsh-syntax-highlighting zsh-autosuggestions)

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=~/bin:$PATH
export PATH=~/.config/composer/vendor/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
export PATH="/snap/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

RPROMPT='!%!'
[ -d "$HOME/.zfunctions" ] && fpath=($fpath "$HOME/.zfunctions")
if command -v mcfly >/dev/null; then
    eval "$(mcfly init zsh)"
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PHP_IDE_CONFIG="serverName=localhost"
export XDEBUG_CONFIG="idekey=PHPSTORM"
export FZF_DEFAULT_COMMAND='fd -L -I -t f -t l'

# Go configuration
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# Make Python shims available immediately, but defer the relatively expensive
# pyenv shell integration and rehash until the first explicit pyenv command.
if (( $+commands[pyenv] )); then
    export PATH="$PYENV_ROOT/shims:$PATH"
    export PYENV_SHELL=zsh
    # Let the first completion request initialize pyenv's own completion too.
    _pyenv_lazy_completion() {
        pyenv --version >/dev/null || return
        _pyenv "$@"
    }
    compctl -K _pyenv_lazy_completion pyenv
    pyenv() {
        unfunction pyenv
        eval "$(command pyenv init - zsh)"
        pyenv "$@"
    }
fi

if command -v fnm >/dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# Google Cloud SDK and OpenClaw are optional and may not be installed.
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

# Keep locally installed CLI tools ahead of system and SDK binaries.
export PATH="$HOME/.local/bin:$PATH"
