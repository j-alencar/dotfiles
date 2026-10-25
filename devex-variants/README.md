# devex skill -- three filled variants

`dot_claude/skills/devex/SKILL.md` had six `//TODO: this` markers: three Bad/Good example pairs,
one per principle. Each directory here is a complete, standalone replacement for that file with
all six filled. `baseline-SKILL.md` is the original, kept for diffing.

To adopt one:

```bash
cp -r devex-variants/variant-b/. dot_claude/skills/devex/
rm -rf devex-variants
```

All three add YAML frontmatter (`name`, `description`), which the original lacked. Without it the
skill never appears in the skills list, so no agent can load it.

| | variant-a | variant-b | variant-c |
| --- | --- | --- | --- |
| Shape | identical to baseline | identical to baseline | tables + `references/snippets.md` + review checklist |
| Examples from | the TODO comments as written (ffmpeg/Vagrant, lscpu) | the tools the skill recommends (mise, uv, compose) | both, compressed into rows |
| Length | shortest | longest | short SKILL.md, code in a reference file |
| Each Bad is | a short snippet | a realistic file, with the failure modes listed under it | one table cell |
| Also usable as | reading material | templates to copy | a lint pass over a diff |

## variant-a -- surgical

Fills the six slots and changes nothing else. The examples follow the hint comments literally:
the prose-vs-Vagrantfile pair, an `ffprobe | jq` script that hides its own errors versus one with
a `need` guard, and the ffmpeg-version-times-cores snippet. Pick this if the skill is already
saying what you want it to say.

## variant-b -- toolchain-native

Same structure, but every Good example is built from `mise`, `uv` and `docker compose`, so the
blocks are copy-pasteable into a real repo instead of being illustrations. Each Bad is a whole
file followed by a bullet list naming what it costs the reader. Also spells out the
"Required toolchain" section that the CAUTION block asks for, since that is the part people get
wrong. Pick this if you want the skill to hand an agent working configuration.

## variant-c -- rules and a checklist

SKILL.md holds one table per principle -- short claims, scannable -- and the code lives in
`references/snippets.md`, loaded only when something is being written. Adds a `## Review
checklist` of `rg` commands (`set -e` in a sourceable file, `2>/dev/null`, a wrapper with no
`"$@"`, a README saying "you'll need") so the skill applies to existing code, not just new code.
Pick this if the skill will mostly run over diffs.
