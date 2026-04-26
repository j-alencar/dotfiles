---
name: kamal-deployment
description: Deploy and operate containerized services with Kamal 2 across Linux servers, including hooks, rollbacks, accessories, and zero-downtime updates.
license: MIT
compatibility: opencode
metadata:
  source: faqndo97/ai-skills (adapted)
  upstream: https://skills.sh/faqndo97/ai-skills/kamal-deployment
---

## Scope

This is a Kamal 2 operations skill adapted for non-Rails repos.

- No Rails-specific assumptions
- No required `/up` endpoint naming
- No framework-specific production config requirements

## When to use

Use this skill when performing deployment tasks with Kamal:

- first-time setup and bootstrap
- standard deploy / redeploy / rollback
- troubleshooting hooks, proxy, and container lifecycle
- managing accessories (databases, caches, sidecars)

## Baseline workflow

```bash
# Initial
kamal setup

# Day-to-day
kamal deploy
kamal deploy --skip-push
kamal deploy --version=<version>
```

## Health checks (framework-agnostic)

- Ensure the application exposes a health endpoint compatible with Kamal proxy checks.
- Endpoint path is project-defined (not fixed to `/up`).
- Health responses should be fast and not depend on heavy startup work.

## Hook troubleshooting

If deploy fails in a hook (example: `pre-connect` permission denied):

1. Check executable bit:
   - `ls -l .kamal/hooks`
2. Fix locally:
   - `chmod +x .kamal/hooks/*`
3. Persist in git mode bits:
   - `git update-index --chmod=+x .kamal/hooks/<hook>`

Non-zero hook exits abort deploy by design.

## Accessories

```bash
kamal accessory boot all
kamal accessory boot <name>
kamal accessory logs <name>
kamal accessory details <name>
kamal accessory reboot <name>
kamal accessory remove <name>
```

## Useful operations

```bash
kamal app logs
kamal app logs -f
kamal app exec --reuse bash
kamal app containers
kamal rollback [VERSION]
kamal lock status
kamal lock release
kamal details
kamal prune
```

## Common gotchas

- Kamal 2 provides its own private `kamal` network.
- Deploy locks can block follow-up deploys after interrupted runs.
- On slower hosts, short timeouts can mimic app failures.
- Proxy and app health failures often look similar; inspect both logs.

## Notes for agents

- Keep framework guidance generic unless repo clearly uses that framework.
- Validate hooks and executable bits early when permission errors appear.
- Prefer incremental diagnosis: registry/auth -> image -> hooks -> health -> rollout.
