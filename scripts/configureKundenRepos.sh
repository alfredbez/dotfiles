for d in ~/Kunden/*/repos/*/ ; do
    echo "$d"
    cd $d
    . ~/dotfiles/scripts/setBitbucketUser.sh
    . ~/dotfiles/scripts/createCommitMsgHook.sh
    sed -i -e 's/https:\/\/alfredbez@bitbucket\.org\//git@bitbucket\.org:/g' .git/config
    sed -i -e 's/https:\/\/bitbucket@bitbucket\.org\//git@bitbucket\.org:/g' .git/config
    echo "\nprüfen, ob username & email gesetzt wurde:"
    tail -n 2 .git/config
    echo "\nprüfen, ob commit-msg hook erstellt wurde:"
    find .git/hooks -name "commit-msg" | wc -l
    echo "----------------"
done

