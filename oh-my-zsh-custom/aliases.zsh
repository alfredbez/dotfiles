alias rs='rsync -chavzP --stats'
alias spider='wget --spider -r -nd -nv -H -w 2'
alias t='trash'
alias cs='clocker start -t'
alias ce='clocker stop'
alias ca='clocker archive'
alias cl='clocker list'
alias ack='ack-grep'
alias copy='xclip -sel clip <'
alias up='sudo apt-get update'
alias inst='sudo apt-get install'
alias selenium='java -jar ~/.selenium-server-standalone-2.45.0.jar'
alias createCommitMsgHook='. ~/dotfiles/scripts/createCommitMsgHook.sh'
alias serve='python -m SimpleHTTPServer'

if [ $(uname -s) = "Linux" ]; then
    alias open="gnome-open"
else
    alias vim='mvim'
fi

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias kd="cd ~/Kunden"
alias dev="cd ~/dev"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
