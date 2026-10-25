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
//TODO: this
// "to run this you'll need a  vm containing ffmpeg and xyzzy set to foo with settingss that allow u to frobnicate the doohickey"

Good:
//TODO: this
// heres a  frickin vagrantfile, run it with this"

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
//TODO: this

Good:
//TODO: this

### Markdown code snippet blocks must be favored over vague instructions

Still on the topics of determinism and fool-proofness:

Bad:
//TODO: this
// "query your version of <foo> and multiply by your number of cores"

Good:
//TODO: this
// "just a bash block of whatever queries the version of <foo> times lscpu"

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
