export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:$XDG_DATA_HOME/go/bin"
export PATH="$PATH:$XDG_DATA_HOME/bazelisk/bin"
export PATH="$PATH:$XDG_DATA_HOME/cargo/bin"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PATH="$PATH:$XDG_DATA_HOME/google-cloud-sdk/bin"
source "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export GOPATH="$XDG_DATA_HOME/go"
