# First time on a fresh setup

`chezmoi init <user>` clones from `github.com/<user>/dotfiles`. Upon the first run you'll be prompted for name/email.

**Linux**
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <user>
```

**Windows**
```sh
winget install twpayne.chezmoi
chezmoi init <user> --apply
```

# To update something

```sh
chezmoi edit ~/.config/some-tool.toml
chezmoi cd # enter source dir
git add -A && git commit -m "update some-tool" && git push
```

# Pull changes on another machine

```sh
chezmoi update # does git pull + apply
```

# Add a new file to management

```sh
chezmoi add ~/.config/some-tool/config.toml
chezmoi cd && git add -A && git commit -m "add some-tool" && git push
```

# Preview changes

```sh
chezmoi diff
chezmoi status
```

# SSH keys runbook

The `run_once_after_ssh-setup.sh` script handles initial SSH key setup automatically.
If you need to redo it on an existing machine (e.g. new key, new account):

**Generate a new key and register with GitHub**
```sh
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/gh -N ""
gh auth login          # if not already authenticated
gh ssh-key add ~/.ssh/gh.pub --title "$(uname -n)"
```

**Generate an Azure DevOps key and register it**
```sh
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/ado -N ""
az login               # browser-based SSO/SAML login
az devops security credentials create \
  --org https://dev.azure.com/<your-org> \
  --public-key "$(cat ~/.ssh/ado.pub)"
```
Or add manually at: `https://dev.azure.com/<your-org>/_usersSettings/keys`

The key is registered once at the account level and works across all orgs/projects/repos your account has access to. SSH remote URLs follow this format:
```
git@ssh.dev.azure.com:v3/<org>/<project>/<repo>
```

Clone via SSH:
```sh
git clone git@ssh.dev.azure.com:v3/<org>/<project>/<repo>
```

Switch an existing repo from HTTPS to SSH:
```sh
git remote set-url origin git@ssh.dev.azure.com:v3/<org>/<project>/<repo>
```

**Add SSH config entries (if not already present)**
```sh
cat >> ~/.ssh/config << 'EOF'

Host github.com
    IdentityFile ~/.ssh/gh
    AddKeysToAgent yes

Host ssh.dev.azure.com
    IdentityFile ~/.ssh/ado
    AddKeysToAgent yes
EOF
```

**Force re-run of the setup script via chezmoi**
```sh
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

# Verification

```sh
chezmoi apply --dry-run --verbose
```