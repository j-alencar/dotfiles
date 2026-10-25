---
name: devex
description: Build wrappers, setup scripts, and developer glue-code that are deterministic, idempotent, and debuggable.
---

# DevEx

For wrappers and developer glue-code.

## Principles

Follow these guiding principles.

### The setup script is mightier than the pen

Developer tooling setups meant for other people to follow must be:

- deterministic
- idempotent
- encapsulated
- open for extension
- fool-proof*

Avoid at all times verbosely describing steps in prose files in an attempt to avoid "you're holding it wrong" scenarios. People generally only ever read the manual when they've already held the thing wrong. To truly solve this, use technology, a few words, and be slightly pessimistic.

(*) note that this does NOT mean establishing a dictatorship of allowed tool calls and shells

#### Analogy and example

Take the cilinder of a diesel pump: it is thinner than the one in a gas pump and thus could fit
in a gas tank hole and ruin the day of someone who made a mistake -- and in many vehicles in the
past it did. As time passed, new fool-proof technology introduced a safety mechanism that
actually *needed* the girth of the gas pump in order for the tank to receive the liquid at all.
The manual is embedded in the system and there is immediate feedback.


Bad -- a README that holds the whole setup:

```markdown
## Prerequisites

- Python 3.12 (3.13 breaks our wheels)
- Node 20
- ffmpeg 7 or newer
- the `xyzzy` daemon running on :7777

Export `XYZZY_MODE=foo`, run `pip install -r requirements.txt`, then `python -m render`.
```

Every line is a chance to drift: the reader has some other Python, installs into the system
interpreter, forgets the export, and reports that rendering is broken.

Good -- the same setup as committed configuration:

`mise.toml`:

```toml
[tools]
python = "3.12"
node = "20"
ffmpeg = "7"

[env]
XYZZY_MODE = "foo"

[tasks.up]
run = "docker compose up -d xyzzy"

[tasks.render]
depends = ["up"]
run = "uv run python -m render"
```

The README keeps one block:

```bash
mise trust && mise run render
```

`mise install` resolves the versions, compose owns the daemon and its port, the env var ships
with the repo, and `uv run` builds the venv on first use. Extension stays open: `mise run render`
forwards extra arguments, and `mise run up` works on its own when someone wants the daemon only.

>[!CAUTION]
>We might run into things that are exempt to this reasoning due to flakiness.
>
>One example is having Docker as part a dev toolchain: its installation has more benefits when done the way that Docker, Inc. recommends than it would with a bespoke wrapper in some rando's repo.
>The same goes for system package managers.
>
>For cases like these, a "Required toolchain" section with
>
>- bullet points like this
>
>[for each tool, hyperlinking to the installation part of the docs](https://docs.docker.com/engine/install/), should be enough. If you wish you could lockfile it due to known issues, specify a version by prose.

So the example above still owes the reader a short list, and nothing more:

```markdown
## Required toolchain

- [Docker Engine](https://docs.docker.com/engine/install/)
- [mise](https://mise.jdx.dev/getting-started.html)
```

### Bash scripts must be considerate

Things that hurt debugging:

- Killing shells on non-0 exits by using strict mode
- Not allowing the caller to see std out/err when running pipeline-less
- Not failing fast upon missing external binaries in scripts that pass their outputs around (think: if someone ran this on Debian and `foo` was not installed, would the error that came out be helpful?)


Bad -- `scripts/test.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

out="$(python3 -c "import subprocess; subprocess.run(['pytest', '-q'], check=True)" 2>&1)"
echo "$out" | tail -n 5
```

- it goes `bash` -> `python3` -> `subprocess` to reach a binary that bash can call directly
- the capture turns a live run into five lines after the fact: no progress, no colour, no way to
  read the failure while it happens
- `-q` is hardcoded and `"$@"` is dropped, so `-k`, `-x` and `--pdb` are gone
- `set -e` ends the session for anyone who sources it to pick up the helper functions

Good:

```bash
#!/usr/bin/env bash

if ! command -v uv >/dev/null; then
  printf 'devex: uv not found -- see https://docs.astral.sh/uv/getting-started/installation/\n' >&2
  exit 127
fi

exec uv run pytest "$@"
```

- one world, no hops
- `exec` hands the terminal, both streams and the exit code straight to pytest, so `Ctrl-C`
  and `--pdb` behave
- `"$@"` keeps every pytest flag reachable
- the guard fires before pytest can fail with a confusing `ModuleNotFoundError`

The same guard, when a script needs more than one binary:

```bash
#!/usr/bin/env bash

need() {
  command -v "$1" >/dev/null && return 0
  printf 'devex: %s not found -- install it with: %s\n' "$1" "$2" >&2
  return 127
}

need docker 'https://docs.docker.com/engine/install/' || exit
need mise 'curl https://mise.run | sh' || exit

exec mise run "$@"
```

### Markdown code snippet blocks must be favored over vague instructions

Still on the topics of determinism and fool-proofness:

Bad:

```markdown
Make sure your ffmpeg is recent enough, and set the worker count to something
sensible for your machine.
```

Good:

```bash
ffmpeg -version | awk 'NR == 1 { print $3 }'   # want 7.0 or newer
echo "workers=$(( $(nproc --all) / 2 ))"
```

Better, where the repo already standardizes its tool-calling -- `mise run doctor` prints the
numbers and nobody computes anything by hand:

```toml
[tasks.doctor]
run = "./scripts/doctor.sh"
```

```bash
#!/usr/bin/env bash
# scripts/doctor.sh

if ! command -v ffmpeg >/dev/null; then
  printf 'devex: ffmpeg not found -- mise install ffmpeg@7\n' >&2
  exit 127
fi

printf 'ffmpeg=%s workers=%s\n' \
  "$(ffmpeg -version | awk 'NR == 1 { print $3 }')" \
  "$(( $(nproc --all) / 2 ))"
```

## Standards

- Heredocs should be small
- Preserve the original command's extensibility in any wrapper
- Wrappers should not hop between worlds too much with no good reason, e.g going `bash` -> `python3` -> `subprocess` when you could just go `bash` or `python3` -> `subprocess`
- When creating CLIs, make shorthand names available for the callable itself and "dash" flags as more ergonomic options

## Tools

- If Python creating a CLI tool, use `argparse` if simple, `click` if not
- If Python wrapping a CLI tool, use `doit` or `fabric`
- If standardizing developer environment and tool-calling in one place (like you would with `make`):
  - When already in the codebase, or no devtooling yet, use [`mise`](https://mise.jdx.dev/) and the `/mise-tasks` skill
  - If the codebase already uses `make`, or `just`, continue using them.
