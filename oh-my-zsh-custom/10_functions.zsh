# List all files, long format, colorized, permissions in octal
function lo(){
    ls -hl  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

# switch back to vim with ctrl-z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Start a PHP server from a directory, optionally specifying the port
# # (Requires PHP 5.4.0+.)
function phpserver() {
    local port="${1:-4000}";
    php -S "localhost:${port}";
}

# Syntax-highlight JSON strings or files
# # Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
        python -mjson.tool | pygmentize -l javascript;
    fi;
}

#
#
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

function sd () {
    echo "$1";
    svn diff --diff-cmd colordiff -x "-u -w -p" "$1" | less -NR;
}

#
#
# `agvim` allows you to search for a pattern with `ag` and open the given file
# directly with `vim`. If there are multiple files you can choose which one
# you want to open
function agvim() {
    local pattern="${1}";
    local ag_results=$(ag ${pattern} -l)
    local ag_results_count=$(echo ${ag_results} | wc -l)
    if [ ${ag_results_count} -lt 1 ]; then
        echo "pattern not found"
    elif [ ${ag_results_count} -eq 1 ]; then
        vim $(ag ${pattern} -l)
    elif [ ${ag_results_count} -gt 1 ]; then
        echo "${ag_results_count} files found, choose one:"
        IFS=$'\n' results=($(echo ${ag_results}))
        ITER=1
        for i in "${results[@]}"; do
            echo "\t[${ITER}]: ${i}"
            let ITER=${ITER}+1
        done
        read fileIndex
        vim ${results[$fileIndex]}
    fi;
}

if [ -f ~/bin/functions.zsh ]; then
    source ~/bin/functions.zsh
fi
