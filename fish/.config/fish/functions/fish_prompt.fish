function fish_prompt
    set -l cwd (prompt_pwd)
    set -l git_branch ''
    set -l git_unstaged ''
    set -l git_staged ''

    if git rev-parse --is-inside-work-tree > /dev/null 2>&1
        set git_branch (git symbolic-ref --short HEAD 2> /dev/null)
        if test -z "$git_branch"
            set git_branch (git rev-parse --short HEAD 2> /dev/null)
        end
        if not git diff --quiet 2> /dev/null
            set git_unstaged '*'
        end
        if not git diff --cached --quiet 2> /dev/null
            set git_staged '+'
        end
    end

    if test -n "$git_branch"
        set git_info "($git_branch$git_staged$git_unstaged)"
    else
        set git_info ''
    end

    set_color normal
    printf '%s ' $cwd
    if test -n "$git_info"
        set_color blue
        printf '%s ' $git_info
        set_color normal
    end
    printf '> '
end
