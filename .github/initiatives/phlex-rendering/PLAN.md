# Plan

> Paused at the user's request. Commit initiative records only; leave the failing application spike uncommitted. Broader integration changes require agreement.

## Workstreams

### Rendering integration
- Objective: Establish a supported component API for match views.
- Status: paused
- Depends on: user agreement before implementation.
- Milestones and deliverables:
  1. Completed: inspect application setup and consult online Kits/rendering documentation.
  2. Completed: user selected Haml with a `DesignSystem` Kit included in `ApplicationHelper`.
  3. In progress: exact spike resolves the Kit method but fails Rails rendering; choose the next integration investigation.
  4. After a successful integration, update current design-system guidance.
  5. Verify actual template rendering and escaped error messages.
- Open questions and risks:
  - Native Kits require a Phlex context; including a Kit in a Rails helper is not documented as an ActionView bridge.
  - A `Components` Kit does not automatically encompass the existing top-level `DesignSystem` and `Matches` namespaces.
  - Current documentation alone does not establish installed-version compatibility.
- Details: [Rendering integration](workstreams/rendering-integration.md).

## Cross-workstream dependencies
- None currently identified.

## Outcome verification
- Baseline: Focused request/component tests passed: 12 tests, 93 assertions. Exact spike currently errors in 6 of 14 focused tests; see the [spike](history/experiments/2026-11-08-haml-kit-spike.md).
- Quality gates: Relevant request/component tests and code-quality review. If dependencies or cross-module behavior change, also run database preparation where relevant, the full application suite, Tailwind build, and Zeitwerk check.
- Desired outcome: The chosen syntax renders real Haml or Phlex views without raw HTML plumbing, preserves alerts, and escapes message content. Include empty-argument Kit calls if Kits are adopted.
- Browser testing: Not performed; agree on scenarios before any browser checks.

## Next planning checkpoint
- After the user chooses a direction, confirm the bounded implementation scope.
