---
name: triage
description: Triage backlog issues with a strict label state machine and prepare clear next actions for humans or agents.
---

## When to use

Use this skill when you need to process GitHub issues, Jira tickets, or any backlog items into a consistent lifecycle.

## Label model

Assign exactly one category label and exactly one state label per item.

### Category labels

- `bug`: something is broken
- `enhancement`: new feature or improvement

### State labels

- `needs-triage`: maintainer review is required
- `needs-info`: waiting on reporter details
- `ready-for-agent`: fully specified for implementation by an agent
- `ready-for-human`: requires human implementation
- `wontfix`: not being actioned

Never apply multiple state labels at once.

## Triage workflow

1. Gather open items missing category/state labels.
2. Apply initial category and set state to `needs-triage`.
3. For each item, decide:
   - Is the report actionable now?
   - Is more information required?
   - Is the request out of scope or rejected?
4. Move each item to exactly one target state.

## Readiness criteria

Move an item to `ready-for-agent` only when it includes:

- a clear problem statement or desired outcome
- concrete acceptance criteria
- constraints, edge cases, and known non-goals
- references to related files, docs, or prior decisions

If any of these are missing, keep it in `needs-triage` or `needs-info`.

## Out-of-scope validation

Check project decision records and scope documents before accepting enhancements.
If an item conflicts with explicit non-goals or prior decisions, close or label `wontfix` with a short rationale.

## Bug handling

For bug reports, prefer reproducing the issue instead of relying solely on reporter assumptions.
Capture:

- reproduction steps
- expected vs actual behavior
- probable root cause
- confidence level

When confirmed, prepare an implementation brief for `ready-for-agent`.

## Output requirements

For each triaged item, provide:

- final category label
- final state label
- one-paragraph rationale
- explicit next action

If moved to `ready-for-agent`, include a concise agent brief with task scope, constraints, and done criteria.
