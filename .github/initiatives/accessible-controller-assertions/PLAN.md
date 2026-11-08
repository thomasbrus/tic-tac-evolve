# Plan

## Outcome and scope

- Replace styling-dependent controller HTML assertions with accessible Capybara selectors and shared data hooks.
- Preserve HTTP behavior, accessibility, markup semantics, form contracts, and the CLI.
- Leave existing helper/component assertions unchanged. Add focused tests for the new helper contract.

## Approval

- Status: proposed.
- Agreed direction: data attributes, controller tests and required markup only.
- Execution policy: plan only for this session. Obtain implementation approval before starting phases.
- This initiative plan is the persistent multi-phase roadmap; do not create a duplicate plan.

## Workstreams

### Controller assertions

- Objective: provide and adopt one reliable response assertion interface.
- Status: proposed.
- Details: [workstream](workstreams/controller-assertions.md).
- Open questions: exact helper API, static hook names, and safe response caching.

## Phases

### 1. Establish the shared interface with one vertical slice

- Status: pending.
- Depends on: none.
- Deliverables:
  - Agree on helper signatures and static/record naming before implementation.
  - Add test-only Capybara and a pinned compatible accessible-selectors dependency.
  - Introduce `ControllerTest < ActionDispatch::IntegrationTest`, include Capybara Minitest assertions, and expose response HTML through `page`.
  - Make the helpers available to both rendering code and controller tests.
  - Migrate a layout assertion such as the edition text and a labeled control assertion.
- Acceptance criteria:
  - Shared helper output matches the rendered data attributes.
  - Distinct elements and repeated records receive appropriate hooks without disturbing existing IDs/classes.
  - Successive requests assert against the current response, including changed bodies on the same response object.
  - Accessible selector assertions work with parsed HTML, without a browser.
- Verification:
  - Focused helper and base-class tests for naming and response freshness.
  - `bin/rails test test/helpers/application_helper_test.rb test/controllers`
- Results: not run.

### 2. Migrate controller coverage completely

- Status: pending.
- Depends on: phase 1.
- Deliverables:
  - Convert all controller HTML assertions.
  - Use accessible labels and selector types for controls, links, fieldsets, and status/alert content.
  - Use shared data hooks for non-semantic elements and repeated-record scoping.
  - Keep narrowly scoped structural assertions for actual contracts, such as form action and hidden position/revision fields, rather than adding unnecessary hooks.
- Acceptance criteria:
  - No controller `assert_select` calls or styling-dependent selectors remain.
  - Preserve title/meta assertions, selected defaults, all nine square labels, hidden parameters, error responses, history links, and pagination counts.
  - Negative assertions, exact counts, and non-visible elements retain their intended meaning under Capybara.
  - No existing helper/component assertions are migrated.
- Verification:
  - `bin/rails test test/controllers`
  - Scoped source review for legacy assertions and styling selectors.
- Results: not run.

### 3. Verify and document the convention

- Status: pending.
- Depends on: phase 2.
- Deliverables:
  - Document helper usage and the preference for accessible selectors.
  - Clarify the composition guide's existing prohibition on test-only CSS classes: dedicated data hooks are allowed.
  - Review changed code with the code-quality skill and record actual verification evidence.
- Acceptance criteria:
  - No visual, accessibility, request behavior, or CLI regressions are introduced.
  - Documentation agrees with the implemented contract.
  - All required checks pass, with pre-existing failures reported separately.
- Verification:
  - `bin/rails test test`
  - `bin/rails tailwindcss:build`
  - `bin/rails zeitwerk:check`
  - `bundle exec haml-lint`
  - Existing Ruby lint command for changed Ruby files.
  - `git diff --check`
- Results: not run.

## Cross-workstream dependencies

None. Application and controller changes stay coordinated within one workstream.

## Migration and recovery

No database schema or data migration is required. Prepare the test database if required by the existing test setup; do not reset it. Add the assertion interface before migrating consumers. Keep public IDs, CSS utilities, and Stimulus hooks intact. Recovery is a coordinated reversal of the assertion, helper, markup, and test dependency changes.

## Outcome verification

- Baseline: [initial source findings](evidence/2026-11-08-baseline.md). Application tests have not been run during planning.
- Quality gates: phase 3 commands and code-quality review.
- Desired outcome: all controller HTML assertions use the new interface without coupling to presentation classes.
- Browser checks: outside this initiative's agreed scope.

## Next planning checkpoint

Before phase 1, resolve helper signatures and naming, confirm dependency compatibility, and obtain implementation approval.

## Resume point

Review the helper contract and start phase 1 only after approval.
