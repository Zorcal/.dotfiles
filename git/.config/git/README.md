# Git configuration

Using complementary ~/.ssh/config:

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github_private
    IdentitiesOnly yes

Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github_work
    IdentitiesOnly yes
```

Make sure to `mkdir -p ~/Work` and `touch ~/Work/.gitconfig`. Edit `~/Work/.gitconfig` with something like the following:

```
[user]
    email = my-work-email@example.com
    name = my-work-user

[core]
    sshCommand = ssh -i ~/.ssh/id_ed25519_github_work

[url "git@github-work:my-organization/"]
    insteadOf = https://github.com/my-organization/
    insteadOf = git@github.com:my-organization/
```

Use `git clone git@github-work:my-organization/my-repo.git` to clone repos into ~/Work.
