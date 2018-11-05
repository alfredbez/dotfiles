export ZSH=$HOME/.oh-my-zsh
PURE_PROMPT_SYMBOL=→
ZSH_THEME="pure"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
SAVEHIST=100000
HISTSIZE=1000
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom
plugins=(git vagrant composer cp common-aliases sublime sudo z calc debian async zsh-syntax-highlighting git-flow-avh)

zle -N clear-screen prompt_pure_clear_screen

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=~/bin:$PATH
export PATH=~/.config/composer/vendor/bin:$PATH
export PATH="/snap/bin:$PATH"

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

RPROMPT='!%!'
