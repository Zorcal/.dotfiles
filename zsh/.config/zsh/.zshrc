#!/bin/zsh

source "$ZDOTDIR/history.zsh"
source "$ZDOTDIR/prompt.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/keybinds.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/work.zsh"


# bun completions
[ -s "/Users/johanronkko/.bun/_bun" ] && source "/Users/johanronkko/.bun/_bun"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/johanronkko/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
