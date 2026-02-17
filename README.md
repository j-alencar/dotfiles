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

# Verification

```sh
chezmoi apply --dry-run --verbose
```