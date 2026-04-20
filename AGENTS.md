# Agent Context

Dotfiles repo managed with [chezmoi](https://chezmoi.io). Targets: Manjaro Linux (currently running KDE desktop) and Windows 11 (WezTerm + GlazeWM, with WSL running Oracle Linux inside).

## Source conventions

| Pattern | Meaning |
|---------|---------|
| `dot_foo` | Deploys to `~/foo` |
| `run_once_before_*.sh.tmpl` | Runs once, before file application |
| `run_once_after_*.sh.tmpl` | Runs once, after file application |
| `run_onchange_after_*.sh.tmpl` | Runs when hash of tracked files changes |
| `_windows_.ps1.tmpl` | Windows-only script (OS modifier) |
| `*.tmpl` | Processed as Go template before deployment |

## Key template variables

| Variable | Values |
|----------|--------|
| `.chezmoi.os` | `"linux"`, `"windows"`, `"darwin"` |
| `.chezmoi.osRelease.id` | `"arch"`, `"ubuntu"`, `"debian"`, `"ol"` |
| `.chezmoi.kernel.osrelease` | Contains `"microsoft"` when running in WSL |

**WSL detection in scripts:**
```bash
IS_WSL=false
[[ -f /proc/version ]] && grep -qi microsoft /proc/version && IS_WSL=true
```

**WSL detection in templates:**
```
{{ if and (eq .chezmoi.os "linux") (not (contains "microsoft" .chezmoi.kernel.osrelease)) }}
```

## Distro support matrix

| Feature | Arch | Ubuntu/Debian | OracleLinux (WSL) |
|---------|------|---------------|-------------------|
| Package manager | pacman + yay (AUR) | apt | dnf + EPEL |
| KDE theming | ✓ | — | — |
| Desktop packages | ✓ (non-WSL) | ✓ (non-WSL) | — |
| Docker | ✓ | ✓ | ✓ |
| Fingerprint | ✓ | ✓ | — |

## Key files

| File | Purpose |
|------|---------|
| `run_once_before_install-packages.sh.tmpl` | Core package installation for all Linux distros |
| `run_once_before_install-packages_windows_.ps1.tmpl` | Windows package installation via Chocolatey |
| `run_once_after_rice-setup.sh.tmpl` | KDE theming (Arch only, non-WSL) |
| `run_onchange_after_kde-settings.sh.tmpl` | KDE shortcuts reload (on config file change) |
| `run_once_after_docker-setup.sh.tmpl` | Docker install, daemon enable, prune timer |
| `run_once_after_ssh-setup.sh.tmpl` | SSH key generation + GitHub/Azure DevOps registration |
| `run_once_after_configure-npm.sh.tmpl` | npm prefix setup + global packages |
| `run_onchange_after_firefox-userjs.sh.tmpl` | Deploy Firefox user.js to profile |
| `dot_config/zsh/` | Modular zsh config (sourced alphabetically) |
| `dot_config/wezterm/wezterm.lua.tmpl` | WezTerm config (WSL default, PowerShell fallback) |
| `dot_config/tmux/tmux.conf` | Tmux config (Gruvbox, Ctrl+Space prefix, vi copy) |
| `dot_config/opencode/` | OpenCode AI assistant config (Linux only) |

## Testing workflow

Force re-run of all scripts:
```bash
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

Re-init config (needed after `.chezmoi.toml.tmpl` changes):
```bash
chezmoi init j-alencar/dotfiles
chezmoi apply
```

Preview changes without applying:
```bash
chezmoi diff
chezmoi apply --dry-run --verbose
```

## Shell stack

- **Shell**: zsh, emacs mode (`bindkey -e` after all plugins)
- **Plugins**: zinit → zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, fzf-tab
- **Prompt**: starship
- **History**: atuin (replaces Ctrl+R and ↑)
- **Directory jump**: zoxide (replaces `cd`)
- **Node**: nvm (lazy-loaded)
- **Python**: uv + virtualenv per project
- **Rust**: rustup

## Commit style

Per-task commits. Don't coauthor.

## On adding new shiny stuff

Prefer composability over chunky glue-scripts. Glue is not forbidden, but try always to use small simple tools that can easily be linked together. This can mean installing new packages and working with them, as long as they're not ultra-obscure or difficult.
