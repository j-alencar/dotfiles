---
name: handoff
description: Compress session context into a focused, disposable handoff document for a separate agent session.
---

## When to use

Use this skill when work should continue in a separate session without bloating or derailing the current one.

## Goal

Produce a concise markdown handoff that enables the next session to start fast with the right scope.

## Include

- purpose of the next session
- relevant context from current work
- suggested skills to invoke
- pointers to existing artifacts and files

## Exclude

- duplicated content already documented elsewhere
- unrelated background
- secrets, credentials, and PII

## Workflow

1. Confirm the next session objective.
2. Extract only context that serves that objective.
3. Reference existing docs/issues instead of copying them.
4. Add recommended starting commands or skills.
5. Save as a temporary working document.

## Format

Use sections in this order:

1. Session Purpose
2. Current State Summary
3. Relevant Artifacts
4. Proposed Next Steps
5. Suggested Skills
6. Risks or Open Questions

## Storage rules

Write handoff files to the OS temporary directory.
Treat them as disposable and do not store them as permanent project documentation.
