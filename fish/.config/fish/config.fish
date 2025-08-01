# Start keychain with all ed25519 SSH keys
set ssh_keys (find ~/.ssh -maxdepth 1 -type f -name 'id_ed25519*' \
    ! -name '*.pub' \
    ! -name '*_old*' \
    ! -name '*.bak*')
if test (count $ssh_keys) -gt 0
    keychain --quiet $ssh_keys
    # Source keychain variables, but keep them local to the session
    if test -f ~/.keychain/fedora-fish
        string replace -r ' -U' '' <  ~/.keychain/(hostname)-fish | source
    end
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

fish_vi_key_bindings

zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end


