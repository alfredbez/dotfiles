[core]
    excludesfile = ~/.gitignore_global
    pager = diff-so-fancy | less --tabs=4 -RFX
    hooksPath = /home/abez/.dotfiles/global-git-hooks
[alias]
    l = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
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
[diff "minjs"]
    textconv = js-beautify
    cachetextconv = true
[diff "mincss"]
    textconv = js-beautify --css
    cachetextconv = true
[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true
