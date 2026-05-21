#!/bin/zsh

# Enable vi mode.
bindkey -v

# Reduce delay when switching modes.
export KEYTIMEOUT=1

# Improve backspace behavior.
bindkey -v '^?' backward-delete-char

# Edit command line in $EDITOR with ctrl-e.
autoload edit-command-line
zle -N edit-command-line

bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

# Fix delete key behavior in vi modes.
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M visual '^[[P' vi-delete

# Change cursor shape depending on vi mode.
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            echo -ne '\e[1 q' ;;      # block cursor
        viins|main)
            echo -ne '\e[5 q' ;;      # beam cursor
    esac
}

zle -N zle-keymap-select

# Start each shell in insert mode.
function zle-line-init() {
    zle -K viins
    echo -ne '\e[5 q'
}

zle -N zle-line-init

# Use beam cursor on shell startup.
echo -ne '\e[5 q'

# Restore beam cursor before commands execute.
preexec() {
    echo -ne '\e[5 q'
}
