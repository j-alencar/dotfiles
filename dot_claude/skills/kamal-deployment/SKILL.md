---
name: kamal-deployment
description: Deploy and operate containerized services with Kamal 2 across Linux servers, including hooks, rollbacks, accessories, and zero-downtime updates.
license: MIT
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

- Kamal 2 creates its own kamal network - remove any custom private network from your config
- Always set config.assume_ssl = true in production.rb when using SSL
- Do NOT use your domain name as the VM hostname - it overrides /etc/resolv.conf
- Docker port exposure bypasses UFW - closing ports in UFW is not enough, Docker rules are higher in iptables
- Short deploy_timeout causes failures on underpowered servers - increase it if deploys fail
- Asset bridging must be explicitly configured with asset_path - it's not automatic
- Accessories must be removed before moving to a new destination
- Kamal 2 doesn't support ERB in config/deploy.yml (unlike Kamal 1)
- Set config.reload_routes = false in Devise initializer to fix ActionController::RoutingError

## Notes for agents

- Keep framework guidance generic unless repo clearly uses that framework.
- Validate hooks and executable bits early when permission errors appear.
- Prefer incremental diagnosis: registry/auth -> image -> hooks -> health -> rollout.
