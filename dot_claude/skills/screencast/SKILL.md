---
name: screencast
description: Record human-paced video evidence of terminal, TUI or browser work for a PR or issue.
---

# Screencast

A **take** is one recording of a tmux stage, driven at human speed with the `screencast` CLI (`screencast CMD --help`).
Work in `./.evidence/<topic>/`, which git ignores globally; paths below are relative to it.
When a browser is in the shot, also read [BROWSER.md](BROWSER.md).

## Steps

1. **Shot list.** Write `timeline.yaml`: one segment per beat, each with a caption, bounded by mark labels.
   Cover, in order:
   - intent: the input as it is before, e.g. the file to convert
   - each decision the operator makes, with the selector visibly moving
   - the result, as a before/after diff of the changed files
   - the happy path, then every designed sad path the spec or issue names: conflicts, failed checks, refusals

   Done when every sad path in the spec has its own segment.

   ```yaml
   output: out/walkthrough.mp4
   terminal: take/term
   segments:
     - {from: intent, to: questions, caption: "The Compose file the wizard converts"}
     - {from: questions, to: sync, caption: "The operator picks the migration task"}
     - {from: sync, to: synced, speed: 8, caption: "Cluster sync"}
   ```

   Several takes cut into one video go under `parts:`, each with its own `terminal` and `segments`.

2. **Stage.** `eval "$(screencast stage one Operator)"`, or `stage three` with three titles.
   Each title becomes a variable holding its pane id. Do setup off camera, before recording.

3. **Record** in the background: `screencast record take/term &`.

4. **Drive** the real program through its real prompts. Evidence is the program running; a script that prints canned output is a mock-up.
   - `screencast run "$Operator" 'cat compose.yml'` for shell commands; it waits for the prompt first.
   - `screencast wait PANE REGEX` before each answer, then `say` to type or `keys PANE Down Down Enter` for selectors.
   - `screencast mark take/term LABEL` at each beat boundary of the shot list.
   - `sleep 5` to `sleep 10` after output the viewer must read: files, diffs, summaries, errors.

5. **End**: `screencast end "$Operator"; wait`.

6. **Edit**: `screencast edit timeline.yaml`.
   Use `speed:` only on waits (installs, syncs); the video badges them. Actions and reading stay at 1x.

7. **Check**: `screencast check out/walkthrough.mp4 --timeline timeline.yaml`, then read the contact sheet it prints.
   Done when the check passes and every caption and terminal line on the sheet is legible.
   Small text: re-record with a larger `--font-size`.

8. **Attach**: `gh pr comment N --body-file comment.md --attach out/walkthrough.mp4`.
   The comment lists the beats and how the environment was brought up.
   Recordings stay in `.evidence/`, out of git.
   If `gh` rejects the size, split the shot list into several takes, one video per comment.
