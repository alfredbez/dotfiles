[core]
    excludesfile = ~/.gitignore_global
    attributesfile = ~/.gitattributes_global
    pager = delta
    ignorecase = false
	untrackedCache = true
	fsmonitor = true
[help]
    autocorrect = 10
[merge]
    conflictstyle = zdiff3
[rebase]
	instructionFormat = (%an <%ae>) %s
    autosquash = true
[fetch]
	writeCommitGraph = true
    fsckobjects = true
[transfer]
    fsckObjects = true
[receive]
    fsckObjects = true
[delta]
    navigate = true
    #features = side-by-side line-numbers decorations
    features = line-numbers decorations
    syntax-theme = "Catppuccin-mocha"
[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = cyan box ul
[delta "line-numbers"]
    line-numbers-left-style = cyan
    line-numbers-right-style = cyan
    line-numbers-minus-style = 124
    line-numbers-plus-style = 28
[interactive]
    diffFilter = delta --color-only
[alias]
    l = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
[push]
    default = current
    autoSetupRemote = true
[pull]
    rebase = true
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
    #diffFilter = diff-so-fancy --patch
[commit]
    verbose = true
[diff]
    algorithm = histogram
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
[rerere]
    enabled = true
[protocol "file"]
    allow = always
[alias]
    set-upstream = \
       !git branch \
           --set-upstream-to=origin/`git symbolic-ref --short HEAD`
