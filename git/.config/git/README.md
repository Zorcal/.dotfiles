# Git configuration

Using complementary ~/.ssh/config:

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_personal
    IdentitiesOnly yes

Host github-alias
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_other
    IdentitiesOnly yes
```
