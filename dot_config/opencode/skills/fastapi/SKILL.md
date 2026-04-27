---
name: fastapi
description: Follow modern FastAPI conventions for type-safe, high-performance API development.
license: MIT
compatibility: opencode
metadata:
  source: fastapi/fastapi
  upstream: https://skills.sh/fastapi/fastapi/fastapi
---

## When to use

Use this skill when building or reviewing FastAPI routes, dependencies, models, and runtime patterns.

## Core conventions

- Prefer `Annotated[...]` for parameters and dependencies.
- Declare return types or `response_model` for filtering and docs.
- Use `async def` only for async I/O; use `def` for blocking work.
- Keep one HTTP operation per route function.
- Prefer router-level organization with `APIRouter` metadata.

## Runtime guidance

- Use `fastapi dev` for local development.
- Use `fastapi run` for production-style execution.
- Configure a `tool.fastapi.entrypoint` in `pyproject.toml` when practical.

## References

- https://fastapi.tiangolo.com/
- https://fastapi.tiangolo.com/tutorial/
