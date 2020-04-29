alias rs='rsync -chavzP --stats --exclude=.git --exclude=.svn'
alias spider='wget --spider -r -nd -nv -H -w 2'
alias dog='highlight -O ansi --force'
alias ack='ack-grep'
alias copy='xclip -sel clip <'
alias createCommitMsgHook='. ~/dotfiles/scripts/createCommitMsgHook.sh'
alias serve='python -m SimpleHTTPServer'
alias search='grep -nrw . -e'
alias less='less -N'
alias grs='git reset --soft HEAD~1'
alias vss='vagrant status'
alias vssh='vagrant ssh'
alias ag='ag --pager="less -XFR"'
alias phpstan='docker run -v $PWD:/app --rm phpstan/phpstan'
alias tmux='tmux -2'
alias cat='bat'
alias vi='nvim'
alias vif='vi $(fzf)'
alias dc='docker-compose'
alias dcmysql='docker-compose exec php bash -c "mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h db $MYSQL_DATABASE"'

if [ $(uname -s) = "Linux" ]; then
    alias open="gnome-open"
else
    alias vim='mvim'
fi

if is_ubuntu; then
    alias open="nautilus"
fi

# Shortcuts
alias dl="cd ~/Downloads"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

if [ -f ~/bin/aliases.zsh ]; then
    source ~/bin/aliases.zsh
fi
