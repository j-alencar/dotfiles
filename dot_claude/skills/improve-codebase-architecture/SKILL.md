---
name: improve-codebase-architecture
description: Identify architecture deepening opportunities that improve locality, testability, and agent navigation.
---

## When to use

Use this skill after delivery, review, or planning sessions reveal friction in understanding or changing the codebase.

## Architecture vocabulary

Use these terms precisely:

- Module: a unit with interface and implementation
- Interface: what callers must know
- Implementation: internal code and decisions
- Depth: leverage provided by the interface
- Seam: a place behavior can change without invasive edits
- Adapter: a concrete implementation behind a seam
- Locality: related knowledge and change staying together

## What to look for

Find places where:

- understanding one concept requires hopping across many files
- tests rely on internals instead of public behavior
- extracted helpers did not reduce change complexity
- agents repeatedly edit the wrong locations
- changes are correct but error-prone to produce

## Analysis workflow

1. Read domain glossary and ADRs first.
2. Map relevant modules and their interfaces.
3. Identify shallow modules and weak seams.
4. Propose numbered deepening opportunities.

For each proposal, include:

- modules involved
- current friction
- concrete change
- impact on locality, leverage, and testability

## Decision rules

- Prefer focused deepening over broad rewrites.
- Keep boundaries explicit and stable.
- Improve interfaces so common tasks require less internal knowledge.
- Introduce adapters at seams where variation is expected.

## Deliverable format

Return a prioritized list with:

- title
- scope size (small/medium/large)
- expected risk
- validation plan

Then ask which single candidate to execute first.
