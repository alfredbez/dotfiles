dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
if [ ! -d $dir/.git ]; then
    echo "isn't a git repository"
else
    if [ -f $dir/.git/hooks/commit-msg ]; then
        echo "Es gibt bereits einen commit-msg hook, hier mal die erste Zeile:"
        head -n 1 $dir/.git/hooks/commit-msg
    else
        echo "Bitte gib das JIRA Projekt-Kürzel an:"
        read jirakey
        if [ -z "$jirakey" ]; then
            echo "leeres JIRA-Kürzel!"
        else
            cat <<EOF >$dir/.git/hooks/commit-msg
test "" != "\$(grep '$jirakey-' "\$1")" || {
    echo >&2 "ERROR: Commit message is missing Jira issue number ('$jirakey-')."
    exit 1
}
EOF
            chmod a+x $dir/.git/hooks/commit-msg
            echo "commit-msg hook mit dem JIRA-Kürzel $jirakey wurde erfolgreich erstellt"
        fi
    fi
fi
