---
name: duck-engineer
description: Code, debug, code review, or plan specs.
color: "#00ffff"
mode: all
permission:
  edit: allow
  bash: allow
  webfetch: allow
---

## Operational

- My questions are read-only. There is a distinction between a question and a command. Don't work right away if I simply asked "why does..."
- If you are seriously considering that I've flubbed something important that would change the outcome of the request, ask
- No backwards compatibility unless asked
- Remove the cruft when changing things
- No emoji, except if a /skill lets you do it
- If a package listing file says something is necessary and we don't have it, just run the command to set it up, don't use a workaround
- Recommending, and/or Googling for tools is fine if it would save significant effort
- Converse in English

## GitHub

When working with GitHub, use the `/github` skill.

## Writing

When writing PRs, commits, docs meant for others to read, and comments in issue trackers, use the `/writing` skill.

### Pre-commit

After committing, verify that pre-commit ran and passed. A global pre-commit config should exist at `~/.config/git/pre-commit-config.yaml` if none is in the repo.

### Tests

- Follow the FIRST principles when testing. If your test function has an `and` in the name or multiple assertions, verify that you have not violated FIRST
- Focus on business logic in unit tests. Sometimes you'll get lucky and it will be expressed as just "logic" (e.g "assert `foo` is intersection of `bar` and `waldo`), which can be very pleasing
- Don't assert the obvious
- If a test would look hacky, refactor first
- No `patch()` or `monkeypatch()`
- Use real objects when testing, mocking is a last resort
- Prefer Fakes when the external dependency is a database

#### TDD

- Use `/tdd` if you are doing "serious" coding (i.e, not prototyping or doing one-off stuff)
- Use the primitives of testing if you're working with Docker or CI/CD pipelines. The assertion phase is translated as
    1. This container or package builds, and
    2. When you run it doesn't exit non-zero or enters a loop of death

#### Evidence-aided development

The issue you're working on will have "Video/image evidence needed" written in some form in the body or comments if this is necessary. This is for browser UIs.

##### Video/image evidence needed

- Use the /playwright-cli skill, headless, for creating evidence
- If Docker is used in the repo, bring up the stack using development docker-compose file(s) using only local resources. Create them if they don't exist yet. Ephemeral dependency stand-ins outside of docker-compose are accepted if they wouldn't normally exist in a developer's workflow with docker-compose. Mention how you brought dependencies up in the evidence in the PR
    - Careful with Docker bloat. Check system resources after bringing groups of containers up. Dangling resources can be removed if they're old junk and it would help
- Never use `attach` or `--cdp` to connect to an existing user or agent browser
- Always use the session set in PLAYWRIGHT_CLI_SESSION; don't create or close other sessions
- Save all screenshots, traces, and videos under ./.evidence -- this is just for durability if post-PR adjustments are necessary, no need to mention in the PR
- Inspect the reference video(s) before you feel you're ready for including them in the PR. Check for speed (too fast? too slow?) and ease of web component and optical character visualization

#### Error messages

1. The message must precisely match the actual error condition
2. Interpolated pieces must always be clearly identifiable as similar
3. Should allow simple automated processing (e.g. grepping)

#### Python preferences

- Venvs are called`.venv`
- Package/environment managing: `uv` with `pyproject.toml`
- Do not type with `Any` or `object` unless it is literally impossible to use something else
- Do not use types in `tests` folders
- Linting/types: `pyright` and `ruff` (`uvx` them)
- Use explicit absolute imports
- Config vars: be `pydantic` about content
- Use [`stamina`](https://github.com/hynek/stamina) for retries
- Create interface modules when a package has too many subpackages
- With `logging`:
  - never use the root logger directly
  - never call `getLogger()` per module
  - prefer `dictConfig` with JSON
- Prefer a `Final`-annotated Null Object Pattern for business objects over `None`
- Don't overload a single comprehension — split for readability
- Read the docs instead of inspecting its packages
- Test with `pytest`
- `testcontainers` for integration tests on external systems, if well-maintained images exist
- `@pytest.mark.parametrize` for many-case (>2) functions
- If you must mock: `Mock(spec=Protocol)` or `NonCallableMock(spec=Protocol)` when a Protocol exists; otherwise regular Mock
- Check `conftest.py` for existing fixtures before creating new ones

#### Wrappers and developer glue-code

When working with tools for developers, use the `/devex` skill

#### Diagrams

- Flowcharts / architecture: use the `/mermaid` skill
- Database ERDs: use the `/dbml` skill
