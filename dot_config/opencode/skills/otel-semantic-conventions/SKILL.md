---
name: otel-semantic-conventions
description: Apply OpenTelemetry semantic conventions for consistent span, metric, and log attributes across services.
license: MIT
compatibility: opencode
metadata:
  source: dash0hq/agent-skills (adapted, vendor-neutral)
  upstream: https://skills.sh/dash0hq/agent-skills/otel-semantic-conventions
---

## When to use

Use this skill when adding or reviewing telemetry attributes, naming spans, or migrating semantic convention versions.

## Core principles

- Registry first: check official semantic conventions before inventing custom fields.
- Prefer standard attributes and stable names to keep queries portable.
- Keep cardinality bounded in span names and metric labels.
- Put attributes at the correct level: resource, scope, span, metric datapoint, or log record.
- Keep placement consistent across services.

## Quick review checklist

1. Confirm `service.name`, `deployment.environment.name`, and `service.version` are set appropriately.
2. Verify HTTP, RPC, DB, messaging, and network attributes use current official keys.
3. Ensure variable values are attributes, not span names.
4. Check status mapping and error attributes are consistent.
5. Flag custom attributes and require justification.

## References

- https://opentelemetry.io/docs/specs/semconv/
- https://opentelemetry.io/docs/specs/semconv/registry/attributes/
- https://github.com/open-telemetry/semantic-conventions
