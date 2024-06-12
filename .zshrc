export ZSH=$HOME/.oh-my-zsh
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
SAVEHIST=100000
HISTSIZE=1000
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom
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
export PATH="/home/abez/.local/bin:$PATH"
export PATH="/Users/bez/.local/bin:$PATH"

if [ -f ~/.zprofile ]; then
    source ~/.zprofile
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

if [ -d ~/.nvm ]; then
    source ~/.nvm/nvm.sh
    nvm use stable > /dev/null 2>&1
fi

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

RPROMPT='!%!'
fpath=($fpath "/home/abez/.zfunctions")
eval "$(mcfly init zsh)"

export TERM=screen-256color
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PHP_IDE_CONFIG="serverName=localhost"
export XDEBUG_CONFIG="idekey=PHPSTORM"
export FZF_DEFAULT_COMMAND='fd -L -I -t f -t l'
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
