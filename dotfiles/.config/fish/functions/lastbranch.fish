function lastbranch
    set --local format (string join '' \
        '%(HEAD) %(color:yellow)%(refname:short)%(color:reset)' \
        ' - %(color:red)%(objectname:short)%(color:reset)' \
        ' - %(contents:subject) - %(authorname)' \
        ' (%(color:green)%(committerdate:relative)%(color:reset))')

    git for-each-ref \
        --sort=committerdate \
        --format=$format \
        refs/heads/
end
