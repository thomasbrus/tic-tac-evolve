# Plan

## Workstreams

### [View conventions and checks](workstreams/view-conventions.md)
- Objective: enforce the requested Haml and embedded Ruby conventions without expanding to standalone Ruby.
- Status: complete
- Depends on: none; user approved the plan on 2026-11-08.
- Milestones and deliverables:
  1. Complete: configure haml-lint/RuboCop and one local/CI lint command.
  2. Complete: normalize views, declare strict locals, and update instructions and current composition examples.
  3. Complete: manual class fallback review, full verification, and code-quality review.
- Open questions and risks: none. The full class fallback hierarchy remains a manual review rule to avoid custom tooling; collection rendering works with strict locals.
- Verification: lint checks, focused request tests, dependency-level Rails checks, and scoped whitespace/link review.

## Cross-workstream dependencies
- None.

## Outcome verification
- Baseline: nine Haml templates, six partials, no existing lint configuration; current bundle was initially satisfied.
- Quality gates: shared lint command, `bin/rails test test`, `bin/rails tailwindcss:build`, `bin/rails zeitwerk:check`.
- Desired outcome: all templates follow the requested conventions without changing user-visible behavior.

## Closure
- All deliverables and success criteria are complete. See [verification evidence](evidence/2026-11-08-checks.md).
