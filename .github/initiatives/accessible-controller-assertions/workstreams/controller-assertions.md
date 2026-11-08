# Controller assertions

## Objective

Give controller tests a shared response page and stable locators while preserving their HTTP-level coverage.

## Deliverables

- [ ] `test_id` and `test_class` helpers based on Rails record identifiers, used for data attributes in both app and tests.
- [ ] Shared `ControllerTest` with Capybara Minitest assertions and a current-response `page`.
- [ ] Compatible, pinned accessible-selectors dependency.
- [ ] Complete controller HTML assertion migration.
- [ ] Contract documentation, code-quality review, and recorded passing checks.

## Dependencies

No other initiative is a prerequisite. Coordinate documentation with the existing [composition guide](../../rails-view-composition/composition-guide.md).

## Progress

- 2026-11-08: Inspected controller tests, test setup, helper tests, and representative layout, board, setup, history, and component rendering code.
- User selected data attributes rather than HTML IDs/classes and excluded migration of existing helper/component assertions.
- User requested initiative and plan creation only. No application or dependency changes were made.

## Open questions and risks

- Rails `dom_id`/`dom_class` target records or model classes. Define how helpers handle static names such as edition text, optional prefixes, and unsaved records.
- The suggested `response.hash` cache key needs verification. Object identity or hash alone may not detect a changed response body; avoid stale pages, collisions, and unbounded retention.
- Decide whether a simple uncached parsed page is sufficient or a single body-aware cache is justified.
- Capybara visibility rules differ from `assert_select`. Explicitly cover hidden inputs and head metadata, including text in non-visible elements.
- `Capybara.string` provides static HTML assertions, not JavaScript execution or browser interaction.
- Preserve color-contract coverage where intentional without making request assertions depend on Tailwind classes. Existing component tests remain unchanged.
- Confirm supported accessible selectors and dependency loading against the installed versions before migration.

## References

- [Plan](../PLAN.md)
- [Baseline evidence](../evidence/2026-11-08-baseline.md)
- [Controller tests](../../../../test/controllers/matches_controller_test.rb)
- [Application helper](../../../../app/helpers/application_helper.rb)
- [Accessible selectors upstream](https://github.com/citizensadvice/capybara_accessible_selectors)
