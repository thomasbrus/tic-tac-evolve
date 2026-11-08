# Plan

## Outcome and scope

- Replace styling-dependent controller HTML assertions with accessible Capybara selectors and literal, dashed data hooks.
- Preserve HTTP behavior, accessibility, markup semantics, form contracts, and the CLI.
- Leave existing helper/component assertions unchanged. Add focused tests for the new helper contract.

## Approval

- Status: approved for implementation; results await user review.
- Agreed direction: data attributes, controller tests and required markup only.
- Execution policy: resumed implementation on 2026-11-08. The user approved [literal hooks without naming helpers](history/decisions/2026-11-08-literal-test-hooks.md) and uncached response parsing.
- This initiative plan is the persistent multi-phase roadmap; do not create a duplicate plan.

## Workstreams

### Controller assertions

- Objective: provide and adopt one reliable response assertion interface.
- Status: implemented and verified.
- Details: [workstream](workstreams/controller-assertions.md).
- Contract: literal `data-test-id` names, configured Capybara test IDs, and uncached response parsing.

## Phases

### 1. Establish the shared interface with one vertical slice

- Status: complete.
- Depends on: none.
- Deliverables:
  - Agree on the locator contract before implementation.
  - Add test-only Capybara and a pinned compatible accessible-selectors dependency.
  - Introduce `ControllerTest < ActionDispatch::IntegrationTest`, include Capybara Minitest assertions, and expose response HTML through `page`.
  - Configure Capybara's `test_id` attribute and use literal hooks where needed.
  - Migrate a layout assertion such as the edition text and a labeled control assertion.
- Acceptance criteria:
  - Literal names match rendered data attributes and Capybara can locate controls through the configured test-ID attribute.
  - Repeated records can share a hook for counts and scoping without disturbing existing IDs/classes; links retain record-specific accessible labels and URLs.
  - Successive requests assert against the current response, including changed bodies on the same response object.
  - Accessible selector assertions work with parsed HTML, without a browser.
- Verification:
  - Focused base-class tests for configured test IDs and response freshness.
  - `bin/rails test test/helpers/application_helper_test.rb test/controllers`
- Results: passed; see [implementation evidence](evidence/2026-11-08-implementation.md).

### 2. Migrate controller coverage completely

- Status: complete.
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
- Results: passed. No controller `assert_select` calls or styling-dependent locators remain; existing helper assertions stay unchanged. Board color coverage moved to a focused rendering assertion.

### 3. Verify and document the convention

- Status: complete.
- Depends on: phase 2.
- Deliverables:
  - Document literal hook usage and the preference for accessible selectors.
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
- Results: checks passed and code-quality review found no unresolved issues. See [implementation evidence](evidence/2026-11-08-implementation.md).

## Cross-workstream dependencies

None. Application and controller changes stay coordinated within one workstream.

## Migration and recovery

No database schema or data migration is required. Prepare the test database if required by the existing test setup; do not reset it. Add the assertion interface and migrate consumers together because Capybara's Minitest integration shadows Rails' `assert_select`. Keep public IDs, CSS utilities, and Stimulus hooks intact. Recovery is a coordinated reversal of the assertions, markup, and test dependency changes.

## Outcome verification

- Baseline: [initial source findings](evidence/2026-11-08-baseline.md).
- Quality gates: phase 3 commands and code-quality review.
- Desired outcome: all controller HTML assertions use the new interface without coupling to presentation classes.
- Browser checks: outside this initiative's agreed scope.

## Resume point

Review the verified implementation. All planned phases are implemented; accept or request changes before committing.
