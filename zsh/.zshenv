#!/bin/zsh

export ZDOTDIR="$HOME/.config/zsh"

# editors
export EDITOR=nvim
export VISUAL=nvim

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# tool locations
export NVM_DIR="$XDG_DATA_HOME/nvm"
export VOLTA_HOME="$HOME/.volta"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export BUN_INSTALL="$XDG_DATA_HOME/bun"

# config files
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# path
typeset -U path PATH

path=(
    "/usr/local/go/bin"
    "/opt/homebrew/share/google-cloud-sdk/bin"
    "$HOME/.local/bin"
    "$HOME/.local/bin/scripts"
    "$XDG_DATA_HOME/go/bin"
    "$XDG_DATA_HOME/bazelisk/bin"
    "$XDG_DATA_HOME/cargo/bin"
    "$XDG_DATA_HOME/npm/bin"
    "$VOLTA_HOME/bin"
    "$BUN_INSTALL/bin"
    $path
)

export PATH
