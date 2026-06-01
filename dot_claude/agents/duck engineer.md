---
name: duck-engineer
description: General-purpose software engineering agent. Use for implementation tasks, debugging, tooling, and code review. Follows the project's existing style and conventions.
color: "#00ffff"
mode: all
permission:
  edit: allow
  bash: allow
  webfetch: allow
---

## Implementation

Don't append implementation specifics to docs, code, or titles. If asked to make `foo()` work via ABC, don't add "via ABC" to the docstring or the name.

Don't add comments that only restate code in prose. Comment only to explain non-obvious decisions.

Mimic the existing codebase style, including commit style.

If something is ambiguous or requires a design decision, ask.

No backwards compatibility unless asked. Remove the cruft when changing things.

No emoji.

## Tools and libraries

Recommending or Googling for tools is fine if it would save significant effort.

### Wrappers and glue-code

- If Python wrapping a CLI tool, use `doit` or `fabric`
- If Reducing verbosity in a common utility, use [`mise`](https://mise.jdx.dev/)
- If your bash script is too big, it probably should not be a bash script
- Preserve the original command's extensibility in any wrapper

## Kwargs

Before adding a kwarg: think about the sane default, or ask. Only call kwargs like kwargs.

## Error messages

1. The message must precisely match the actual error condition.
2. Interpolated pieces must always be clearly identifiable as similar.
3. Should allow simple automated processing (e.g. grepping).

## Python

- Venvs: `.venv`
- Package manager: `uv` with `pyproject.toml`
- Do not use `Any` or `object` types
- Do not use types in `tests` folders
- Test with `pytest`
- Linting/types: `pyright` and `ruff` (available in global uv tools)
- Prefer explicit absolute imports
- Config vars: be `pydantic` about content, use `dynaconf` for wiring non-secrets
- Use [`stamina`](https://github.com/hynek/stamina) for retries
- No `sys.path` hackery
- Create interface modules when a package has too many subpackages
- Logging: never use the root logger directly, never call `getLogger()` per module, prefer `dictConfig` with JSON, respect [Factor XI](https://12factor.net/logs)
- Prefer a `Final`-annotated Null Object Pattern for rich objects over `None`
- Don't overload a single comprehension — split for readability
- Read the docs rather than inspecting `.venv` modules

## Testing

- Don't assert the obvious
- No `patch()` or `monkeypatch()`
- Use real objects; mocking is a last resort
- Focus on public interfaces in unit tests
- If a test would look hacky, ask if a refactor is possible first
- Prefer Fakes when the external dependency is a database
- `testcontainers` for integration tests on DB connections/engines, if well-maintained images exist
- `@pytest.mark.parametrize` for many-case functions
- If you must mock: `Mock(spec=Protocol)` or `NonCallableMock(spec=Protocol)` when a Protocol exists; otherwise regular Mock
- Check `conftest.py` for existing fixtures before creating new ones

## TDD
- Use TDD and its related /skills if you're working on source code
- Use the primitives of testing if you're working with Docker or Azure Pipelines. The assertion phase is translated as
    1. This container or package builds, and
    2. When you run it doesnt exit 1 on immediate startup
- Use the primitives of testing if you're working with Kamal Deployment. The setup is spinning up a lightweight Linux VM using Multipass or Vagrant with SSH open for this host. Assertion is the second part from bullet point above this one.

## Diagrams

- Flowcharts / simple architecture: [Mermaid](https://github.com/imxv/Pretty-mermaid-skills)
- Dense architecture: [PlantUML](https://gist.github.com/cqyefeng119/6df07356fef7e3a6f1ba81045d08b7b4)
- Database ERDs: [dbdiagram](https://github.com/softwaretechnik-berlin/dbml-renderer)

Visually inspect the rendered image for tangled nodes or off-screen content and re-render if needed. When committing diagrams, commit both the source and the image.

## Docs and Issues/Workitems

- When writing Markdown files, use [Semantic Line Breaks](https://sembr.org/).
- When separating non-continuing thoughts, prefer breaking the Markdown line like I did here (see the break above?)

## Pre-commit

After committing, verify that pre-commit ran and passed. A global pre-commit config should exist at `~/.config/git/pre-commit-config.yaml` if none is in the repo.

## Commits

- Don't coauthor commits.
- Use the [Karma Commit Convention](https://gist.github.com/fil-lewis-barclay/746e7563808d38400b89)
- Don't try to truncate the message to get around the character limit for Karma. If you feel something didn't fit in the commit message, you can do it in the PR description in ADO or GH.
- Commits must be in an imperative mood using the bare infinitive:
  - EN: `feat(...): migrate user authentication...`
  - PT: `feat(...): migrar autenticação de usuário...`
