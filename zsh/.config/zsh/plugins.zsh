#!/bin/zsh

export _Z_CMD="j"
export _Z_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/z

function zsh_source_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    local plugin_name="${1##*/}"
    local plugin_dir="$ZDOTDIR/plugins/$plugin_name"
    local plugin_file

    if [[ ! -d "$plugin_dir" ]]; then
        git clone --depth=1 "https://github.com/$1.git" "$plugin_dir"  # shallow clone
    fi

    # try .plugin.zsh first, then .zsh
    for plugin_file in \
        "$plugin_dir/$plugin_name.plugin.zsh" \
        "$plugin_dir/$plugin_name.zsh"; do
        [[ -f "$plugin_file" ]] && { source "$plugin_file"; return }
    done
}

zsh_add_plugin "agkozak/zsh-z"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
