function fbr
    # Get last 30 branches sorted by committer date
    set branches (git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)")

    if test (count $branches) -eq 0
        echo "No branches found."
        return 1
    end

    # Use fzf to select a branch
    set branch (printf "%s\n" $branches | fzf +m)

    if test -n "$branch"
        git checkout $branch
    end
end
