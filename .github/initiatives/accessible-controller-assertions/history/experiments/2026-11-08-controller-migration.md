# 2026-11-08 Controller assertion migration

- **Type:** implementation
- **Status:** succeeded
- **Question or problem:** Can Rails controller requests use accessible Capybara assertions without browser automation or presentation-dependent selectors?
- **Approach:** Introduce a parsed-response base, migrate all controller HTML assertions, and test response freshness, configured data IDs, negative assertions, metadata, and hidden fields. Add only edition and repeated-history hooks.
- **Evaluation criteria:** Preserve HTTP tests, form contracts, labels, defaults, pagination, and appearance coverage. Remove controller `assert_select` calls and styling selectors. Pass required checks.
- **Evidence:** [Commands and results](../../evidence/2026-11-08-implementation.md), [controller base](../../../../../test/controller_test.rb), [base contract tests](../../../../../test/controllers/controller_test_test.rb), [match tests](../../../../../test/controllers/matches_controller_test.rb).
- **Findings:** The initial slice failed with 11 failures and 9 errors. Capybara shadowed legacy `assert_select`; public helper names were discovered as tests; the helper tests used an unavailable receiver; and the board was incorrectly assumed to have a region role. Literal hooks and complete migration removed these problems.
- **Conclusion:** Static HTML responses support the required assertions. No cache, naming helper, browser driver, or application behavior change is needed.
- **Implications and follow-up:** Review and accept the implementation. Retain Rails' transitive DOM-testing dependency and existing helper/component assertions.
- **Related decisions:** [Literal test hooks](../decisions/2026-11-08-literal-test-hooks.md).
