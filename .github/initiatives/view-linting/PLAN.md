# Plan

## Workstreams

### [View conventions and checks](workstreams/view-conventions.md)
- Objective: enforce the requested Haml and embedded Ruby conventions without expanding to standalone Ruby.
- Status: paused
- Depends on: none; user approved the plan on 2026-11-08.
- Milestones and deliverables:
  1. Complete: configure haml-lint/RuboCop and one local/CI lint command.
  2. Complete: normalize views, declare strict locals, and update instructions and current composition examples.
  3. Checks and code-quality review complete; user acceptance pending.
- Open questions and risks: the full class fallback hierarchy remains a manual review rule to avoid custom tooling. Collection rendering works with strict locals.
- Verification: lint checks, focused request tests, dependency-level Rails checks, and scoped whitespace/link review.

## Cross-workstream dependencies
- None.

## Outcome verification
- Baseline: nine Haml templates, six partials, no existing lint configuration; current bundle was initially satisfied.
- Quality gates: shared lint command, `bin/rails test test`, `bin/rails tailwindcss:build`, `bin/rails zeitwerk:check`.
- Desired outcome: all templates follow the requested conventions without changing user-visible behavior.

## Next planning checkpoint
- Paused at the user's request. Resume with review of the implemented conventions and [verification evidence](evidence/2026-11-08-checks.md), not a new implementation phase.
