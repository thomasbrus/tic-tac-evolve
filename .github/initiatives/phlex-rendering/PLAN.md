# Plan

> Approved: adopt the previous project's `Components` Kit, collapsed grouping directories, and helper inclusion; keep Haml. The user separately approved upgrading only phlex-rails to 1.2.2 while retaining Phlex 1.x.

## Approved phases

### 1. Align component loading and namespaces
- Status: complete
- Depends on: none
- Deliverables: initializer, collapsed component directories, `Components` class namespaces, helper inclusion, and updated references.
- Acceptance criteria: components autoload under `Components`; component tests and Zeitwerk pass.
- Verification: `bin/rails test test/components`; `bin/rails zeitwerk:check`.
- Results: 67 tests, 334 assertions passed; Zeitwerk passed. Haml still had six rendering errors with phlex-rails 0.1.0.
- Recovery: revert only this migration's edits if requested; no database changes.

### 2. Complete Rails rendering integration
- Status: complete
- Depends on: phase 1
- Deliverables: diagnose the remaining integration mismatch using online guidance, then implement an approved fix and document the final API.
- Acceptance criteria: exact Haml Kit calls render and escape text; full tests, Tailwind build, and Zeitwerk pass.
- Verification: focused helper/request tests, then required cross-module checks.
- Constraint: phlex-rails 1.2.2 upgrade approved; do not invent a custom rendering bridge or upgrade Phlex to 2.x.
- Results: exact Haml calls and escaping verified. Full suite passed with 102 tests and 6719 assertions; database preparation, Tailwind build, and Zeitwerk passed. Code-quality review found no unresolved change-related issues.

## Workstreams

### Rendering integration
- Objective: Establish a supported component API for match views.
- Status: complete
- Depends on: user agreement before implementation.
- Milestones and deliverables:
  1. Completed: inspect application setup and consult online Kits/rendering documentation.
  2. Completed: user selected Haml with a `DesignSystem` Kit included in `ApplicationHelper`.
  3. Completed: adopt `Components` with collapsed directories and upgrade the approved Rails adapter.
  4. Completed: update current design-system guidance.
  5. Completed: verify actual template rendering and escaped error messages.
- Open questions and risks:
  - Current online Kits documentation differs from the verified Phlex 1.x Haml behavior; preserve the version-specific tests when upgrading.
  - Collapsed grouping directories share one namespace: component filenames must be unique and match their constants.
- Details: [Rendering integration](workstreams/rendering-integration.md).

## Cross-workstream dependencies
- None currently identified.

## Outcome verification
- Baseline: Focused request/component tests passed: 12 tests, 93 assertions. The initial spike had errors in 6 of 14 focused tests; these are now resolved. See the [spike](history/experiments/2026-11-08-haml-kit-spike.md).
- Quality gates: Relevant request/component tests and code-quality review. If dependencies or cross-module behavior change, also run database preparation where relevant, the full application suite, Tailwind build, and Zeitwerk check.
- Desired outcome: The chosen syntax renders real Haml or Phlex views without raw HTML plumbing, preserves alerts, and escapes message content. Include empty-argument Kit calls if Kits are adopted.
- Final result: All criteria met; see the [implementation record](history/experiments/2026-11-08-components-integration.md).
- Browser testing: Not performed; agree on scenarios before any browser checks.

## Next planning checkpoint
- Revisit version compatibility before a future Phlex upgrade.
