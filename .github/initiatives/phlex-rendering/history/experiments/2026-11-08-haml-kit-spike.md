# 2026-11-08 Haml Kit spike

- **Type:** technical spike
- **Status:** failed
- **Question or problem:** Does making `DesignSystem` a Kit and including it in `ApplicationHelper` enable the exact `ErrorMessage(message: ...)` call in Haml with current dependencies?
- **Hypothesis:** The user's previous-project pattern also works here.
- **Approach:** With user approval, define the reloadable Kit in `app/components/design_system.rb`, include it in the helper, replace both error-message view calls, and add focused Haml rendering and escaping tests.
- **Evaluation criteria:** Actual Haml and request rendering succeeds, alerts render once, and message text remains escaped.

## Evidence

- Baseline: `bin/rails test test/controllers/matches_controller_test.rb test/components/design_system/error_message_test.rb` passed with 12 tests and 93 assertions.
- Spike: `bin/rails test test/helpers/application_helper_test.rb test/controllers/matches_controller_test.rb test/components/design_system/error_message_test.rb` ran 14 tests with 69 assertions, 0 failures, and 6 errors.
- Error: Rails reports the `DesignSystem::ErrorMessage` instance "is not an ActiveModel-compatible object. It must implement #to_partial_path."
- Both real error views and both direct Haml helper tests encounter the same rendering error.

## Findings

The capitalized Kit method resolves and constructs the expected component in Haml. This contradicts treating the current documentation's Phlex-context warning as proof that helper inclusion cannot resolve these methods with installed versions.

The remaining failure is Rails component rendering. Current components inherit from `Phlex::HTML`; the installed integration does not make this attempt render successfully through ActionView.

## Conclusion

The exact setup is insufficient here, but the observed failure is not a missing Kit method. Investigate the Rails integration before rejecting the user's pattern.

## Implications and follow-up

The user approved this bounded spike, not a dependency upgrade or broad migration. Report the actual failure and obtain direction before expanding scope. The application changes remain an uncommitted, failing spike until fixed or explicitly removed.

The user subsequently paused the initiative and selected committing only initiative records. The failing application spike is deliberately retained uncommitted for continuation.

## Related decisions

No broader integration decision accepted.
