---
name: prometheus-configuration
description: Configure Prometheus scraping, recording rules, and alerting for reliable metrics collection.
license: MIT
compatibility: opencode
metadata:
  source: wshobson/agents
  upstream: https://skills.sh/wshobson/agents/prometheus-configuration
---

## When to use

Use this skill when setting up or tuning Prometheus configs, rules, and alerts.

## Configuration checklist

1. Define global `scrape_interval` and `evaluation_interval`.
2. Configure scrape jobs (static or service discovery).
3. Normalize labels with relabeling where needed.
4. Add recording rules for expensive or frequently-used queries.
5. Add alerting rules with severity labels and actionable annotations.
6. Validate with `promtool` before deploy.

## Good defaults

- Keep scrape intervals practical (often 15s to 60s).
- Use recording rules for rate/error/latency aggregates.
- Alert on symptoms first (availability, latency, saturation), then causes.

## Validation commands

```bash
promtool check config prometheus.yml
promtool check rules rules/*.yml
```

## References

- https://prometheus.io/docs/prometheus/latest/configuration/configuration/
- https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/
- https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
