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


Bad:

```markdown
## Rendering

To run this you'll need a VM with `ffmpeg` and `xyzzy` installed. Set `XYZZY_MODE=foo`
and turn on the settings that let you frobnicate the doohickey, then `make render`.
```

Good:

A `Vagrantfile` committed next to the `Makefile`:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.provision "shell", inline: <<~SHELL
    apt-get update -qq
    apt-get install -y ffmpeg xyzzy
    install -m 0644 /vagrant/xyzzy.conf /etc/xyzzy.conf
  SHELL
end
```

`xyzzy.conf` already says `mode = foo` and `frobnicate = true`, so nobody has to be told:

```bash
vagrant up && vagrant ssh -c 'make render'
```

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


Bad:

```bash
#!/usr/bin/env bash
set -euo pipefail

ffprobe -show_format -print_format json "$1" 2>/dev/null > probe.json
jq -r '.format.duration' probe.json
```

- sourced into a dev shell, the first bad path takes the shell down with it
- `2>/dev/null` throws away the one sentence ffprobe wrote about what went wrong
- on a box with no ffmpeg the reader gets `jq: error: Invalid numeric literal`, which accuses the wrong binary

Good:

```bash
#!/usr/bin/env bash

need() {
  command -v "$1" >/dev/null && return 0
  printf 'devex: %s not found -- install it with: %s\n' "$1" "$2" >&2
  return 127
}

duration() {
  need ffprobe 'apt-get install ffmpeg' || return
  need jq 'apt-get install jq' || return
  ffprobe -v error -show_format -print_format json "$1" | jq -r '.format.duration'
}

duration "$@"
```

- no strict mode, so sourcing it cannot end the session
- `-v error` keeps ffprobe's own diagnostics on the terminal
- the missing-binary message names the binary and the fix, and returns 127 like the shell would

### Markdown code snippet blocks must be favored over vague instructions

Still on the topics of determinism and fool-proofness:

Bad:

```markdown
Query your version of ffmpeg and multiply it by your number of cores to pick `-threads`.
```

Good:

```bash
ffmpeg -version | head -n 1
nproc --all                    # lscpu -p=cpu | grep -cv '^#' where nproc is missing
ffmpeg -threads "$(nproc --all)" -i in.mkv out.mp4
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
