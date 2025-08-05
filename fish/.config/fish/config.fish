if not set -q TMUX
    source ~/.config/fish/start_ssh_agent.fish
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

fish_vi_key_bindings

zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end


