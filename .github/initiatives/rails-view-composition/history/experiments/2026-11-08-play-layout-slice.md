# 2026-11-08 Play and layout composition

- **Type:** implementation
- **Status:** succeeded
- **Question or problem:** Can the play view and shared application header follow the approved Rails composition direction while preserving match behavior and appearance?
- **Hypothesis:** Existing shared typography primitives and an explicit-local Haml board partial can cover this slice without a new component API or feature component.
- **Approach:** Replaced match heading and metadata style declarations with `Eyebrow` and `Typography`; extracted board rendering into `_board` with a `match` local and moved its labels to the partial-relative locale scope. Reused `Typography` for application-header labels. Kept `button_to`, move parameters, styling classes, and accessibility labels unchanged.
- **Evaluation criteria:** Preserve active and completed board rendering, accessible square labels, move positions and revisions, state styling, error feedback, and application-header content; pass focused controller and component tests and rebuild Tailwind.
- **Evidence:**
  - `bin/rails test test/controllers/matches_controller_test.rb test/components/design_system/typography_test.rb test/components/design_system/eyebrow_test.rb`: passed, 23 tests and 172 assertions.
  - `bin/rails tailwindcss:build`: passed.
  - `git diff --check`: passed.
  - No browser check was performed.
- **Findings:** The current shared typography API supports the migrated page and layout. The board's loop and Rails form wiring are a useful partial boundary, while no feature-specific component or API extension is needed. Tests verify all nine active move forms, submitted positions and current revision, completed-board labels and styling, and disabled move controls.
- **Conclusion:** Phase 2 meets its acceptance criteria without a behavior or styling change.
- **Implications and follow-up:** Proceed with phase 3 to consolidate the implemented composition rules into contributor guidance and run the full cross-phase checks.
- **Related decisions:** None.
