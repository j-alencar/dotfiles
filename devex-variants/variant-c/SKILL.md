---
name: devex
description: Build wrappers, setup scripts, and developer glue-code that are deterministic, idempotent, and debuggable.
---

# DevEx

For wrappers and developer glue-code.

Writing something new: follow the principles, lift the code from
[references/snippets.md](references/snippets.md). Reviewing something that exists: run the
[review checklist](#review-checklist).

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

| Bad | Good |
| --- | --- |
| "you'll need a VM with ffmpeg and xyzzy set to foo, with settings that allow you to frobnicate the doohickey" | a `Vagrantfile` that installs ffmpeg and drops a committed `xyzzy.conf`, plus `vagrant up && vagrant ssh -c 'make render'` |
| a Prerequisites list naming four tools and their versions | a `mise.toml` `[tools]` table and one `mise run render` |
| "export `XYZZY_MODE=foo` before you start" | the value in `mise.toml` `[env]`, or in `compose.yaml` |
| "start the daemon on :7777" | a compose service with the port bound |

Full files for the first two rows: [references/snippets.md](references/snippets.md).

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

### Bash scripts must be considerate

Things that hurt debugging:

- Killing shells on non-0 exits by using strict mode
- Not allowing the caller to see std out/err when running pipeline-less
- Not failing fast upon missing external binaries in scripts that pass their outputs around (think: if someone ran this on Debian and `foo` was not installed, would the error that came out be helpful?)

| Bad | Good | Why |
| --- | --- | --- |
| `set -euo pipefail` at the top of anything someone may `source` | explicit `\|\| return` on the calls that matter | a sourced `set -e` closes the reader's shell on the first bad path |
| `out="$(cmd 2>&1)"; echo "$out" \| tail -5` | `exec cmd "$@"` | capture kills progress, colour and `Ctrl-C`; `exec` passes streams and exit code through |
| `cmd 2>/dev/null` | `cmd -v error`, or no redirect at all | the discarded line was the only diagnostic |
| calling `jq` with no check that `jq` exists | `need jq 'apt-get install jq'` before the call | otherwise Debian reports `jq: error: Invalid numeric literal` and accuses the wrong binary |
| `pytest -q` hardcoded in a wrapper | `pytest "$@"` | `-k`, `-x` and `--pdb` stay reachable |

The `need` guard and the `exec` wrapper: [references/snippets.md](references/snippets.md).

### Markdown code snippet blocks must be favored over vague instructions

Still on the topics of determinism and fool-proofness:

| Bad | Good |
| --- | --- |
| "query your version of `foo` and multiply by your number of cores" | `foo --version` and `echo "jobs=$(( $(nproc --all) * 2 ))"`, with the arithmetic written out |
| "make sure your ffmpeg is recent enough" | `ffmpeg -version \| awk 'NR == 1 { print $3 }'   # want 7.0 or newer` |
| "install the dependencies" | the exact `apt-get install`/`mise install` line |
| "point it at your cluster" | the `kubectl config use-context` command, with the context name |

If a value cannot be written down because it differs per machine, write down the command that
prints it. Readers paste commands; they do not perform arithmetic.

## Review checklist

Each check is a grep over the diff or the repo. A hit is a question, not a verdict.

- `rg -n 'set -e' -g '*.sh'` -- can this file be sourced? then the strict mode is a trap
- `rg -n '2>/dev/null|&>/dev/null|2>&1 >' -g '*.sh'` -- which diagnostic did that hide?
- `rg -n '\$\(.*\)\"?$' -g '*.sh'` on wrappers -- is a long-running command being captured instead of `exec`ed?
- `rg -n 'command -v|type -p' -g '*.sh'` -- empty, while the script shells out? no fail-fast
- `rg -n '"\$@"' -g '*.sh'` -- missing from a wrapper's final line? extensibility is gone
- `rg -in "you'?ll need|make sure you have|prerequisite|first, install" -g '*.md'` -- candidates for a setup script
- `rg -n 'python3 -c|subprocess' -g '*.sh'` -- a world hop; can bash reach the binary directly?
- heredocs longer than ~10 lines -- move the body into a committed file

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
