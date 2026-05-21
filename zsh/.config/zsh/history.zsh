#!/bin/zsh

# Set history size limits.
export HISTSIZE=10000000
export SAVEHIST=10000000

# Store history in XDG data directory.
export HISTFILE="$XDG_DATA_HOME/history"

# Append to history file instead of overwriting it.
setopt APPEND_HISTORY

# Share history across all sessions.
setopt SHARE_HISTORY

# Remove duplicate history entries.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Ignore commands prefixed with a space.
setopt HIST_IGNORE_SPACE

# Remove superfluous blanks before saving history.
setopt HIST_REDUCE_BLANKS

# Save timestamps in history.
setopt EXTENDED_HISTORY
