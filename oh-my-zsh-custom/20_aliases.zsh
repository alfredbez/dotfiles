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
alias tmux='tmux -2'
alias cat='bat'
alias vi='nvim'
alias vim='nvim'
alias vif='vi $(fzf)'
alias dc='docker-compose'
alias dcmysql='docker-compose exec php bash -c "mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h db $MYSQL_DATABASE"'
alias lg='lazygit'
alias pu='vendor/bin/phpunit'
alias stan='docker run --user 1000:1000 -it --rm --memory=8g -v $(pwd):$(pwd) -w $(pwd) spryker/php:7.4 vendor/bin/phpstan analyse --memory-limit=-1'
alias cs='docker run -it --rm --memory=8g -v $(pwd):/app -w /app spryker/php:7.4 vendor/bin/phpcs --standard=config/ruleset.xml'
alias cbf='docker run --user 1000:1000 -it --rm --memory=8g -v $(pwd):/app -w /app spryker/php:7.4 vendor/bin/phpcbf --standard=config/ruleset.xml'
alias gs='gss'
alias gbb='git --no-pager branch --sort=-committerdate | head'
alias ls='lsd'
alias gcho='git -c core.hooksPath=/dev/null checkout'
alias ds='docker/sdk'

if [ $(uname -s) = "Linux" ]; then
    alias open="gnome-open"
else
    alias vim='mvim'
fi

if is_ubuntu; then
    alias open="nautilus"
fi

if is_macos; then
    ###################################################
    # determine versions of PHP installed with HomeBrew
    ###################################################
    #
    # source: https://localheinz.com/blog/2020/05/05/switching-between-php-versions-when-using-homebrew/

    installedPhpVersions=($(brew ls --versions | ggrep -E 'php(@.*)?\s' | ggrep -oP '(?<=\s)\d\.\d' | uniq | sort))

    # create alias for every version of PHP installed with HomeBrew
    for phpVersion in ${installedPhpVersions[*]}; do
        value="{"

        for otherPhpVersion in ${installedPhpVersions[*]}; do
            if [ "${otherPhpVersion}" = "${phpVersion}" ]; then
                continue
            fi

            # unlink other PHP version
            value="${value} brew unlink php@${otherPhpVersion};"
        done

        # link desired PHP version
        value="${value} brew link php@${phpVersion} --force --overwrite; } &> /dev/null && php -v"

        alias "${phpVersion}"="${value}"
    done
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
