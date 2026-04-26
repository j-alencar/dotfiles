---
name: azure-devops-cli
description: Use Azure DevOps CLI for repos, pull requests, pipelines, and project automation with reliable defaults and scriptable output.
license: MIT
compatibility: opencode
metadata:
  source: github/awesome-copilot
  upstream: https://skills.sh/github/awesome-copilot/azure-devops-cli
---

## When to use

Use this skill when automating or troubleshooting Azure DevOps operations via `az`:

- Repos and pull requests
- Pipelines and builds
- Work items and boards
- Project/team/repo metadata lookups

## Baseline setup

```bash
az extension add --name azure-devops
az login
az devops configure --defaults organization=https://dev.azure.com/<org> project=<project>
az devops configure --list
```

## Practical patterns

- Always test auth first:
  - `az account show`
  - `az repos list --query "[0].name" -o tsv`
- Prefer `--query` + `-o tsv/json` for script-safe outputs.
- Avoid hardcoding organization/project repeatedly once defaults are set.

## Useful commands

```bash
az repos list -o table
az repos show --repository <repo> -o yaml
az repos pr list --status active -o table
az pipelines list -o table
az pipelines runs list --top 10 -o table
```

## Notes for agents

- If `az repos` fails with login hints, surface a precise remediation command.
- Prefer non-interactive CLI flows for automation contexts.
