---
name: grafana-dashboards
description: Design and maintain Grafana dashboards for application and infrastructure observability.
license: MIT
compatibility: opencode
metadata:
  source: wshobson/agents
  upstream: https://skills.sh/wshobson/agents/grafana-dashboards
---

## When to use

Use this skill when creating or improving dashboards for APIs, services, databases, and infrastructure.

## Dashboard design heuristics

- Top row: critical single-value indicators.
- Middle: trend panels (rate, errors, duration/latency).
- Bottom: diagnostic views (tables, heatmaps, breakdowns).
- Use consistent units, legends, and naming.
- Add useful template variables (env, namespace, service, instance).

## Core patterns

- RED for services: request rate, error rate, latency percentiles.
- USE for infrastructure: utilization, saturation, errors.
- Add links to runbooks or traces when possible.

## Provisioning options

- JSON dashboards versioned in git.
- File provisioning via Grafana providers YAML.
- Infrastructure as code (for example Terraform).

## References

- https://grafana.com/docs/grafana/latest/
- https://prometheus.io/docs/prometheus/latest/querying/basics/
