---
name: chezmoi-workflows
description: Manage dotfiles with chezmoi workflows for tracking, syncing, templating, and drift resolution.
license: MIT
compatibility: opencode
metadata:
  source: terrylica/cc-skills (adapted)
  upstream: https://skills.sh/terrylica/cc-skills/chezmoi-workflows
---

## When to use

Use this skill for day-to-day chezmoi operations and troubleshooting in dotfiles repositories.

## Common workflows

- Track edits to managed files and push updates.
- Add new files to chezmoi source.
- Pull from remote and safely apply changes.
- Handle template rendering and OS-specific conditionals.
- Resolve drift between source and target.

## Practical commands

```bash
chezmoi status
chezmoi diff
chezmoi add ~/.zshrc
chezmoi re-add
chezmoi git -- status
chezmoi git -- push
chezmoi apply --dry-run --verbose
chezmoi apply
```

## Safety guidance

- Prefer `chezmoi diff` and dry-run before large applies.
- Keep secrets out of plain files; use template-based secret providers when possible.
- After sync operations, verify clean state with `chezmoi status` and `chezmoi verify`.

## References

- https://www.chezmoi.io/reference/
