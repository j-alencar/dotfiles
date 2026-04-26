---
name: azure-container-registry
description: Troubleshoot and operate Azure Container Registry auth, pull/push, repository/tag inspection, and access controls from Linux/WSL environments.
license: MIT
compatibility: opencode
metadata:
  source: microsoftdocs/agent-skills
  upstream: https://skills.sh/microsoftdocs/agent-skills/azure-container-registry
---

## When to use

Use this skill for ACR problems and operations such as:

- `docker pull/push` auth failures
- verifying repo/tag existence
- diagnosing role and network access issues
- WSL/Linux toolchain mismatches (`az` vs `docker` context)

## Quick triage flow

1. Validate Azure auth:
   - `az account show`
2. Validate ACR visibility:
   - `az acr show -n <acr>`
3. Validate registry login path:
   - default: `az acr login -n <acr>`
   - token fallback: use `--expose-token` + `docker login --password-stdin`
4. Validate artifact existence:
   - `az acr repository show-tags -n <acr> --repository <repo> -o table`
5. Validate local tool alignment in WSL:
   - `type -a az`
   - `type -a docker`
   - `docker context show`

## Useful commands

```bash
az acr repository list -n <acr> -o table
az acr repository show-tags -n <acr> --repository <repo> -o table
az acr check-health -n <acr>
docker pull <acr>.azurecr.io/<repo>:<tag>
```

## Notes for agents

- `az acr login --expose-token` does not perform Docker login by itself.
- If Docker auth errors claim tag missing, verify auth before concluding image absence.
- In WSL contexts, explicitly check for Windows binary/tooling leakage.
