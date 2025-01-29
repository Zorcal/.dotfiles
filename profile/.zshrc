# Programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="flatpak run com.google.Chrome"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Config
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/gimp"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export LESSHISTFILE="$XDG_CONFIG_HOME/less/lesshst"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export DOOMDIR="$XDG_CONFIG_HOME/doom"

# Data
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GEM_HOME="$XDG_DATA_HOME/gem"
export HISTFILE="$XDG_DATA_HOME/history"

# Cache
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"

# Runtime
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Path
export PATH="$PATH:/usr/bin"
export PATH="$PATH:$XDG_CONFIG_HOME/emacs/bin"
export PATH="$PATH:$XDG_DATA_HOME/go/bin"
# Download Zig version from https://ziglang.org/download/, move it to
# XDG_DATA_HOME and symlink version to XDG_DATA_HOME/zig. For example:
#   tar -xvf zig-linux-x86_64-0.13.0.tar.xz
#   mv zig-linux-x86_64-0.13.0 $XDG_DATA_HOME/
#   ln -s $XDG_DATA_HOME/zig-linux-x86_64-0.13.0 $XDG_DATA_HOME/zig
export PATH="$PATH:$XDG_DATA_HOME/zig"
export PATH="$PATH:$XDG_DATA_HOME/zls/bin"
export PATH="$PATH:$XDG_DATA_HOME/bazelisk/bin"
export PATH="$PATH:$XDG_DATA_HOME/cargo/bin"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PATH="$PATH:$XDG_DATA_HOME/lua-language-server/bin"
export PATH="$PATH:$XDG_DATA_HOME/scripts"
export PATH="$PATH:$XDG_DATA_HOME/google-cloud-sdk/bin"
export PATH="$PATH:$HOME/.local/bin"

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

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# fbr - checkout git branch, sorted by most recent commit, limit 30 last branches
fbr() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# zsh-z config
export _Z_CMD="j"
export _Z_DATA="$XDG_DATA_HOME/z"
export ZSHZ_TILDE=1
export ZSHZ_NO_RESOLVE_SYMLINKS=1

# Custom plugin manager
function zsh_source_file() {
	[ -f "$1" ] && source "$1"
}
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$XDG_DATA_HOME/zshplugins/$PLUGIN_NAME" ]; then
		# For plugins
		zsh_source_file "$XDG_DATA_HOME/zshplugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
		zsh_source_file "$XDG_DATA_HOME/zshplugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
	else
		git clone "https://github.com/$1.git" "$XDG_DATA_HOME/zshplugins/$PLUGIN_NAME"
	fi
}

# Load plugins
zsh_add_plugin "agkozak/zsh-z"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "qoomon/zsh-lazyload"

[[ -f "$HOME/.zshprivate" ]] && source "$HOME/.zshprivate"
[[ -f "$HOME/.zshwork" ]] && source "$HOME/.zshwork"

if [ "$SSH_AUTH_SOCK" = "" -a -x /usr/bin/ssh-agent ]; then
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
fi

. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

source '/home/j/.local/share/pop/shell_init/zsh/init.zsh' # added by pop

# Use modern completion system
autoload -Uz compinit; compinit
zmodload zsh/zpty

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/j/.local/share/go/bin/projectadmin projectadmin

[ -f "/home/j/.ghcup/env" ] && . "/home/j/.ghcup/env" # ghcup-env

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

function chfmt() {
  clickhouse-format
}
