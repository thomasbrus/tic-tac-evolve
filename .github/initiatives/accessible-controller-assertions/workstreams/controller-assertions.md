# Controller assertions

## Objective

Give controller tests a shared response page and stable locators while preserving their HTTP-level coverage.

## Deliverables

- [x] Literal dashed `data-test-id` hooks, replacing the initial naming-helper proposal by user agreement.
- [x] Shared `ControllerTest` with Capybara Minitest assertions and a current-response `page`.
- [x] Compatible, pinned accessible-selectors dependency.
- [x] Complete controller HTML assertion migration.
- [x] Contract documentation, code-quality review, and recorded passing checks.

## Dependencies

No other initiative is a prerequisite. Coordinate documentation with the existing [composition guide](../../rails-view-composition/composition-guide.md).

## Progress

- 2026-11-08: Inspected controller tests, test setup, helper tests, and representative layout, board, setup, history, and component rendering code.
- User selected data attributes rather than HTML IDs/classes and excluded migration of existing helper/component assertions.
- User requested initiative and plan creation only. No application or dependency changes were made.
- Resumed implementation later on 2026-11-08. The first vertical slice failed because of Minitest helper discovery, the `assert_select` collision, an unavailable helper-test receiver, and a mistaken region selector. See the [implementation record](../history/experiments/2026-11-08-controller-migration.md).
- The user approved literal hooks instead of both helpers. Full controller migration and focused response contract tests now pass; mark color checks remain in rendering tests rather than controller styling selectors.

## Open questions and risks

- Naming helpers and response caching are no longer needed under the accepted contract.
- Capybara visibility rules differ from `assert_select`. Metadata and hidden-field assertions explicitly use `visible: :all`; tests cover positive and negative behavior.
- `Capybara.string` provides static HTML assertions, not JavaScript execution or browser interaction.
- Color-contract coverage lives in a focused helper rendering test. Existing helper assertions and component tests remain unchanged.
- The upstream `v0.12.0` tag reports gem version `0.11.0`. Its revision is locked and runtime checks passed; do not assume the tag and internal version must match.

## References

- [Plan](../PLAN.md)
- [Baseline evidence](../evidence/2026-11-08-baseline.md)
- [Controller tests](../../../../test/controllers/matches_controller_test.rb)
- [Application helper](../../../../app/helpers/application_helper.rb)
- [Accessible selectors upstream](https://github.com/citizensadvice/capybara_accessible_selectors)
