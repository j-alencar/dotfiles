---
name: azure-virtual-machines
description: Troubleshoot and operate Azure VMs (Linux/Windows) for provisioning, networking, IMDS, SSH/RDP access, and lifecycle operations.
license: MIT
compatibility: opencode
metadata:
  source: microsoftdocs/agent-skills
  upstream: https://skills.sh/microsoftdocs/agent-skills/azure-virtual-machines
---

## When to use

Use this skill when working with Azure VM issues such as:

- VM provisioning or bootstrap failures
- SSH/RDP connectivity failures
- NSG and private/public IP reachability checks
- IMDS checks (`169.254.169.254`) and VM identity detection
- VM sizing, image, disk, or lifecycle decisions

## Quick triage flow

1. Confirm target context:
   - subscription
   - resource group
   - VM name
2. Validate Azure auth and defaults:
   - `az account show`
3. Check VM runtime state:
   - `az vm show -g <rg> -n <vm> -d --query "{power:powerState,privateIps:privateIps,publicIps:publicIps}" -o yaml`
4. Check network controls (NSG/effective rules, NIC, subnet)
5. Check guest-level access method:
   - SSH key/user for Linux
   - RDP/user/password/reset path for Windows
6. If on-VM debugging is possible, check IMDS:
   - `curl -fsS -H Metadata:true "http://169.254.169.254/metadata/instance/compute/name?api-version=2021-02-01&format=text"`

## Common commands

```bash
az vm list -d -o table
az vm show -g <rg> -n <vm> -d -o yaml
az vm list-ip-addresses -g <rg> -n <vm> -o yaml
az network nic list-effective-nsg --ids <nic-id> -o yaml
az network nsg rule list -g <rg> --nsg-name <nsg> -o table
```

## Notes for agents

- Prefer explicit `--query` filters to keep output concise.
- Do not assume IMDS reachability means Azure profile unless explicit profile settings are absent.
- If a deployment is intended to run only from a control node, validate current VM identity first.
