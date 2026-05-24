---
name: grill-with-docs
description: Run rigorous design grilling while refining shared domain language and documenting decisions in context files.
---

## When to use

Use this skill when shaping features in an existing codebase and you need aligned language before implementation.

## Primary objective

Drive toward precise, shared domain language across:

- code
- developers
- domain experts

Use that language to make design decisions explicit and implementation-ready.

## Required artifacts

- `CONTEXT.md` for bounded-context terminology
- ADR files for non-obvious, consequential decisions

If artifacts are missing, create them.

## Session workflow

1. Read existing context documents and glossary terms.
2. Ask focused, dependency-ordered questions.
3. Surface ambiguities, collisions, and edge cases.
4. Propose concrete options with trade-offs.
5. Record decisions immediately in docs.

## Question quality bar

Prioritize questions that force explicit decisions on:

- cardinality and relationships
- naming and term collisions
- lifecycle/status semantics
- deletion and archival behavior
- nullability and required fields

Prefer concrete scenarios over abstract wording.

## Language refinement rules

- Challenge fuzzy phrasing.
- Reuse established terms when valid.
- Introduce new terms only when they reduce ambiguity.
- Keep definitions orthogonal where possible.

## ADR trigger

Create an ADR only when the decision is:

- hard to reverse
- surprising without context
- based on meaningful trade-offs

## Output requirements

At each checkpoint, produce:

- decisions made
- open questions
- exact doc updates applied

Before finishing, ensure `CONTEXT.md` reflects final terminology and relationships.
