---
name: mise-tasks
description: Orchestrate multi-step project workflows using mise tasks with dependencies, arguments, and file tracking.
license: MIT
compatibility: opencode
metadata:
  source: terrylica/cc-skills (adapted)
  upstream: https://skills.sh/terrylica/cc-skills/mise-tasks
---

## When to use

Use this skill when working with `mise` task automation, including:

- creating or updating `[tasks]` in `.mise.toml`
- defining task dependencies (`depends`, `depends_post`)
- adding task arguments with `usage`
- improving repeatable local CI-style workflows

## Core task pattern

```toml
[tasks.lint]
description = "Run static checks and fail on issues."
run = "ruff check ."

[tasks.test]
description = "Run the test suite."
run = "pytest -q"

[tasks.ci]
description = "Run lint and tests in sequence."
depends = ["lint", "test"]
run = "echo done"
```

## Useful task properties

- `description`: required for discoverability by humans and agents
- `depends`: run prerequisites before a task
- `depends_post`: run follow-up tasks after success
- `dir`: execute task from a subdirectory
- `env`: task-scoped environment variables
- `sources` + `outputs`: skip work when outputs are up-to-date
- `usage`: structured argument spec for task inputs

## Common commands

```bash
mise tasks
mise run <task>
mise run <task1> <task2>
mise run <task1> ::: <task2>
```

## Guidance for agents

- Prefer small composable tasks over large monolithic scripts.
- Keep release or deploy tasks dependency-driven so prerequisites always run.
- Use precise `description` fields that explain purpose, inputs, and expected result.
