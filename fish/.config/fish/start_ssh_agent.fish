if test -S "$SSH_AUTH_SOCK"
    # The agent is already running and the socket exists.
else
    # This should only be run once per system login.

    eval (ssh-agent -c)

    set ssh_keys (find ~/.ssh -maxdepth 1 -type f -name 'id_ed25519*' \
        ! -name '*.pub' \
        ! -name '*_old*' \
        ! -name '*.bak*')
    for key in $ssh_keys
        ssh-add $key
    end
end
