---
name: tdd
description: Implement behavior through strict red-green-refactor loops using tests on public interfaces.
---

## When to use

Use this skill when implementing a defined slice of functionality and you want fast feedback with low regression risk.

## Core rule

Test behavior through public interfaces.
Do not couple tests to implementation details.

## Red-green-refactor loop

Work one behavior at a time:

1. Red: add one failing test for a single behavior.
2. Green: implement the minimal change to pass.
3. Refactor: improve design while keeping tests green.

Repeat for the next behavior.

## Avoid horizontal TDD

Do not write a batch of tests up front and then implement all at once.
Always complete each behavior loop before starting the next.

## Test quality checks

- test names read like specifications
- assertions verify observable outcomes
- no private-method testing
- no mocks of internal collaborators unless unavoidable

## Implementation constraints

- prefer smallest change that satisfies current failing test
- defer speculative abstractions
- refactor only with green tests

## Output requirements

For each behavior, report:

- failing test introduced
- change made to pass
- refactor performed, if any

Stop after each completed behavior and confirm the next one.
