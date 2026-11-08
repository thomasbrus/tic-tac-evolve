# 2026-11-08 Components integration

- **Type:** implementation
- **Status:** succeeded
- **Question or problem:** Can the previous project's loading structure and a compatible Rails adapter support Kit calls directly in Haml?
- **Hypothesis:** Missing namespace setup and the obsolete Rails adapter account for the original integration limitations.
- **Approach:** Adopt the user-approved initializer and namespace layout, then upgrade only phlex-rails after separate approval. Replace every match-view manual component call and add Haml rendering tests.
- **Evaluation criteria:** Autoloading passes; real Haml renders alerts and history; message text is escaped without escaping component markup; existing application and CLI behavior remain tested.

## Evidence

- [Installation docs](https://www.phlex.fun/introduction/getting-started) describe the `Components` namespace and install generator.
- [Published phlex-rails 1.2.2 metadata](https://rubygems.org/api/v2/rubygems/phlex-rails/versions/1.2.2.json) declares Phlex `>= 1.10, < 2` and railties `>= 6.1, < 9`.
- [Initializer](../../../../../config/initializers/phlex.rb) registers the Kit namespace and collapses grouping directories.
- [Helper](../../../../../app/helpers/application_helper.rb) includes the Kit.
- [Haml tests](../../../../../test/helpers/application_helper_test.rb) cover keyword calls, no-argument calls, and escaping.
- [Request tests](../../../../../test/controllers/matches_controller_test.rb) cover actual match views, error alerts, history, and pagination.
- Namespace migration alone: `bin/rails test test/components` passed with 67 tests and 334 assertions; `bin/rails zeitwerk:check` passed.
- Before the adapter upgrade: `bin/rails test test/helpers/application_helper_test.rb test/controllers/matches_controller_test.rb` had 6 rendering errors in 11 tests. The error remained `to_partial_path`.
- `bundle update phlex-rails --conservative` upgraded only phlex-rails from 0.1.0 to 1.2.2; Phlex remained 1.11.1.
- After upgrading: `bin/rails test test/helpers/application_helper_test.rb test/controllers/matches_controller_test.rb test/components` passed with 78 tests and 413 assertions.
- Final: `bin/rails db:prepare && bin/rails test test && bin/rails tailwindcss:build && bin/rails zeitwerk:check` passed. Suite: 102 tests, 6719 assertions, no failures, errors, or skips.
- Code-quality review examined namespace changes, initializer, helper, view calls, tests, and lockfile scope. No unresolved change-related issues.
- Browser checks were not performed.

## Findings

The collapsed structure loads components under `Components` without their grouping folder names. The user clarified that the previous project's `button.rb` / `Badge` mismatch was a typo: filenames still match constants.

The original rendering failure persisted after namespace migration and disappeared after the compatible adapter upgrade. Haml now supports `ErrorMessage(message: ...)` and `MatchSetupSection()` without `raw`, `.new`, or `.call`.

The current online Kits warning is not an accurate prediction of this verified Phlex 1.x / Rails adapter combination. Preserve tests rather than extrapolating across versions.

## Conclusion

The original setup omitted the intended namespace configuration and used an obsolete Rails adapter. The requested syntax works with the corrected integration; no custom rendering helper or Phlex view migration was required.

## Implications and follow-up

Current usage guidance is in the [design-system documentation](../../../../design-system/README.md). Changes remain uncommitted pending user review.

## Related decisions

- [Components Kit and compatible Rails adapter](../decisions/2026-11-08-components-kit.md)
