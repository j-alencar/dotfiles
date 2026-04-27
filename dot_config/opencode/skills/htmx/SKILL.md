---
name: htmx
description: Build dynamic server-driven interfaces with HTMX using declarative HTML attributes and minimal JavaScript.
license: MIT
compatibility: opencode
metadata:
  source: mindrally/skills
  upstream: https://skills.sh/mindrally/skills/htmx
---

## When to use

Use this skill when implementing interactive UI behavior with server-rendered HTML fragments.

## Core HTMX patterns

- Request attributes: `hx-get`, `hx-post`, `hx-put`, `hx-patch`, `hx-delete`
- Target and swap: `hx-target`, `hx-swap`, `hx-select`
- Trigger control: `hx-trigger` for timing and event selection
- Navigation behavior: `hx-push-url`, `hx-replace-url`

## Practical guidance

- Return focused HTML fragments instead of full pages for partial updates.
- Keep endpoints idempotent and explicit about status codes.
- Add loading and error states in a way users can see immediately.
- Prefer declarative HTMX attributes over ad-hoc JavaScript handlers.

## References

- https://htmx.org/reference/
- https://htmx.org/docs/
