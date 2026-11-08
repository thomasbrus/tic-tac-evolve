# 2026-11-08 Setup and history composition

- **Type:** implementation
- **Status:** succeeded
- **Question or problem:** Can setup/history move from small feature-specific Phlex wrappers to Rails-native Haml partials while preserving behavior and using existing shared UI?
- **Hypothesis:** Existing Kit primitives and ordinary Haml partials are sufficient; no new component API or framework change is needed.
- **Approach:** After phase 1 approval, added explicit partial inputs for setup fields, history heading, repeated history records, and pagination. Reused existing typography/heading primitives, moved partial-specific translations, removed superseded components, and replaced CSS-class test hooks with semantic selectors.
- **Evaluation criteria:** Preserve setup defaults and invalid-response rendering; render empty, active, completed, and paginated history; maintain accessible labels, routes, and presentation; pass focused tests, Tailwind build, and autoload checks.
- **Evidence:**
  - Baseline: `bin/rails test test/controllers/matches_controller_test.rb test/helpers/application_helper_test.rb test/components` passed with 79 tests and 414 assertions.
  - Final: the same focused command passed with 81 tests and 425 assertions.
  - `bin/rails tailwindcss:build` passed.
  - `bin/rails zeitwerk:check` passed after removing the feature components.
  - `git diff --check` passed; search found no remaining `history-list`, `state-label`, or removed component references in app, tests, or config.
  - Request tests verify page-one/page-two pagination boundaries, empty history, active/completed links, form defaults, and invalid setup re-rendering. No browser checks were performed.
  - Code-quality review found no unresolved issues in the migrated slice.
- **Findings:** Existing `Typography`, `Heading`, and `Eyebrow` APIs were sufficient. Relative translations render correctly from the new partials. The former history/status marker classes were only used by tests, so tests now assert list structure and visible text without those hooks.
- **Conclusion:** Phase 1 meets its acceptance criteria without a shared UI API change or behavior change.
- **Implications and follow-up:** Phase 1 is complete. Phases 2–3 remain outside the approved scope; request approval before migrating the play view/layout. The user will provide additional Haml-convention feedback later.
- **Related decisions:** None.
