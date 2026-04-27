---
name: otel-instrumentation
description: Implement high-quality OpenTelemetry tracing, metrics, and logs with practical SDK and validation guidance.
license: MIT
compatibility: opencode
metadata:
  source: dash0hq/agent-skills (adapted, vendor-neutral)
  upstream: https://skills.sh/dash0hq/agent-skills/otel-instrumentation
---

## When to use

Use this skill for OpenTelemetry instrumentation design and implementation across application services.

## Signal quality rules

- Emit telemetry that helps detect, localize, or explain issues.
- Avoid high-cardinality attributes unless clearly justified.
- Keep naming consistent and aligned with semantic conventions.
- Correlate logs with traces where possible.
- Redact or avoid sensitive data (PII, secrets, tokens).

## Instrumentation workflow

1. Set resource attributes (`service.name`, environment, version).
2. Start with baseline auto-instrumentation where available.
3. Add manual spans for important business or external boundaries.
4. Add metrics for throughput, error rate, and latency.
5. Validate emitted telemetry in local and deployed environments.

## Sampling guidance

- Prefer configuring sampling in the telemetry pipeline or collector for centralized control.
- Keep SDK behavior simple and predictable unless there is a strong reason to override defaults.

## References

- https://opentelemetry.io/docs/
- https://opentelemetry.io/docs/specs/semconv/
