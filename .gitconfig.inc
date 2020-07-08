[core]
    excludesfile = ~/.gitignore_global
    pager = diff-so-fancy | less --tabs=4 -RFX
    hooksPath = /home/abez/.dotfiles/global-git-hooks
[push]
    default = current
[color]
    ui = true
[color "diff-highlight"]
    oldNormal = red bold
    oldHighlight = red bold 52
    newNormal = green bold
    newHighlight = green bold 22
[color "diff"]
    meta = yellow
    frag = magenta bold
    commit = yellow bold
    old = red bold
    new = green bold
    whitespace = red reverse
[pager]
    diff = diff-so-fancy | less --tabs=4 -RFX --pattern '^(Date|added|deleted|modified): '
[commit]
    verbose = true
