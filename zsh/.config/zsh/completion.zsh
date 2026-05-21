#!/bin/zsh

# Activate zsh completion system.
autoload -Uz compinit
compinit -d "$ZDOTDIR/zcompdump"

# Make completion menus interactive.
zstyle ':completion:*' menu select
