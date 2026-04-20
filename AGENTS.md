# Agent Context

Dotfiles repo managed with [chezmoi](https://chezmoi.io).

Known targets: Manjaro Linux (currently running KDE desktop) and Windows 11 (with WSL running Oracle Linux inside).

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

## Key files

| File | Purpose |
|------|---------|
| `run_once_before_install-packages.sh.tmpl` | Core package installation for all Linux distros |
| `run_once_before_install-packages_windows_.ps1.tmpl` | Windows package installation |
| `run_once_after_rice-setup.sh.tmpl` | KDE theming |
| `run_onchange_after_kde-settings.sh.tmpl` | KDE shortcuts reload (on config file change) |
| `run_once_after_docker-setup.sh.tmpl` | Docker |
| `run_once_after_ssh-setup.sh.tmpl` | SSH key generation + GH/Azure DevOps registration |
| `run_once_after_configure-npm.sh.tmpl` | npm prefix setup + global packages |
| `run_onchange_after_firefox-userjs.sh.tmpl` | Deploy Firefox user.js to profile |
| `dot_config/zsh/` | Modular zsh config  |
| `dot_config/wezterm/wezterm.lua.tmpl` | WezTerm config  |
| `dot_config/tmux/tmux.conf` | Tmux config  |
| `dot_config/opencode/` | OpenCode AI assistant config |

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
- **Plugins**: zinit
- **Prompt**: starship
- **History**: atuin (replaces Ctrl+R and ↑)
- **Directory jump**: zoxide (replaces `cd`)
- **Node**: nvm
- **Python**: uv + virtualenv per project
- **Rust**: rustup

## On adding/updating with new shiny stuff

Prefer composability over chunky glue-scripts. Glue is not forbidden, but try always to use small simple tools that can easily be linked together. This can mean installing new packages and working with them, as long as they're not ultra-obscure or difficult.

## Commit style

Per-task commits, don't coauthor.
