export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
SAVEHIST=100000
HISTSIZE=1000
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom
plugins=(git vagrant composer cp common-aliases sublime sudo z calc debian svn zsh-syntax-highlighting)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=~/bin:$PATH
export PATH="/usr/local/heroku/bin:$PATH"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='vim'

if [ -d ~/.nvm ]; then
    source ~/.nvm/nvm.sh
    nvm use stable > /dev/null 2>&1
fi

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
