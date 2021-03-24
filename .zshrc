export ZSH=$HOME/.oh-my-zsh
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
SAVEHIST=100000
HISTSIZE=1000
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom
plugins=(git vagrant composer cp common-aliases sublime sudo z debian async zsh-syntax-highlighting git-flow-avh zsh-autosuggestions)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=~/bin:$PATH
export PATH=~/.config/composer/vendor/bin:$PATH
export PATH="/snap/bin:$PATH"

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

export TERM=xterm-256color
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PHP_IDE_CONFIG="serverName=localhost"
export XDEBUG_CONFIG="idekey=PHPSTORM"

SPACESHIP_PHP_SYMBOL="🐘  "
SPACESHIP_PHP_PREFIX="PHP-Version "

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
fpath=($fpath "/home/abez/.zfunctions")
