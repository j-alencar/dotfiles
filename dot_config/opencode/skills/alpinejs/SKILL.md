---
name: alpinejs
description: Apply Alpine.js best practices for lightweight reactive UI behavior with maintainable templates.
license: MIT
compatibility: opencode
metadata:
  source: brettatoms/agent-skills
  upstream: https://skills.sh/brettatoms/agent-skills/alpinejs
---

## When to use

Use this skill when adding small reactive behavior with Alpine.js in server-rendered or static HTML.

## Core conventions

- Keep inline expressions short and readable.
- Move complex logic out of attributes into named component functions.
- Use `Alpine.data()` for reusable components.
- Use `Alpine.store()` for shared global state.
- Add `x-cloak` where needed to avoid flash-of-unstyled-state.

## Directive quick list

- `x-data`, `x-init`, `x-show`, `x-if`, `x-for`
- `x-model`, `x-text`, `x-html`, `x-bind`, `x-on`
- `x-transition`, `x-ref`, `x-effect`

## References

- https://alpinejs.dev/start-here
- https://alpinejs.dev/directives
