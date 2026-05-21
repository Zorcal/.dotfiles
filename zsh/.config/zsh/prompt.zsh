#!/bin/zsh

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

# vcs_info styles — same as before
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Async state
_vcs_async_result=''
_vcs_async_pid=0

# Signal handler: fires when background job finishes
TRAPUSR1() {
  _vcs_async_result=$(cat /tmp/zsh_vcs_info_$$ 2>/dev/null)
  rm -f /tmp/zsh_vcs_info_$$
  zle && zle reset-prompt
}

# precmd: launch vcs_info in background, kill previous if still running
_vcs_info_async() {
  (( _vcs_async_pid )) && kill -0 $_vcs_async_pid 2>/dev/null && kill $_vcs_async_pid 2>/dev/null
  {
    vcs_info
    print -r -- "${vcs_info_msg_0_}" > /tmp/zsh_vcs_info_$$
    kill -USR1 $$
  } &!
  _vcs_async_pid=$!
}

add-zsh-hook precmd _vcs_info_async

# Prompt reads from async result instead of vcs_info_msg_0_ directly
PROMPT='%(5~|%-1~/…/%3~|%4~) %F{blue}${_vcs_async_result}%f %# '
