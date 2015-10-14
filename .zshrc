export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom
plugins=(git cp common-aliases sublime sudo z calc debian zsh-syntax-highlighting)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=~/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export LC_ALL=C
if [ $(uname -s) = "Linux" ]; then
    export EDITOR='vim'
else
    export EDITOR='mvim'
fi
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi
if [ -d ~/.nvm ]; then
	source ~/.nvm/nvm.sh
	nvm use 0.10 > /dev/null 2>&1
fi

export PATH="/usr/local/heroku/bin:$PATH"
