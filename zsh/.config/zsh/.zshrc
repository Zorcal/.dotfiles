#!/bin/zsh

# Turn on profiling:
#zmodload zsh/zprof

[[ -f "$ZDOTDIR/.zshexports" ]] && . "$ZDOTDIR/.zshexports"

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# Only display short path in prompt.
PROMPT='%(5~|%-1~/…/%3~|%4~) %F{blue}${vcs_info_msg_0_}%f %# '

# Make completion menues nicer.
zstyle ':completion:*' menu select
zmodload zsh/complist

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Use vim keys in tab complete menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Enable vi mode.
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e.
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

export _Z_CMD="j"
export _Z_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/z
export ZSHZ_TILDE=1
export ZSHZ_NO_RESOLVE_SYMLINKS=1

function zsh_source_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

alias emacs="emacsclient -c --alternate-editor=''"

zsh_add_plugin "agkozak/zsh-z"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "qoomon/zsh-lazyload"

[[ -s "$NVM_DIR/nvm.sh" ]] && lazyload nvm -- "source $NVM_DIR/nvm.sh"

[[ -f "$ZDOTDIR/.zshfuncs" ]] && . "$ZDOTDIR/.zshfuncs"

[[ -f "$ZDOTDIR/.zshworkprofile" ]] && . "$ZDOTDIR/.zshworkprofile"

# Activate zsh completion system.
autoload -Uz +X compinit && compinit
zmodload zsh/zpty

# Turn off profiling:
#zprof

source '/home/j/.local/share/pop/shell_init/zsh/init.zsh' # added by pop
