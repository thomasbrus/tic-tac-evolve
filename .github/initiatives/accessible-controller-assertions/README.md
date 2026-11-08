# Accessible controller assertions

## Original problem

Controller tests depend on markup and styling selectors such as `header span.edition`. Changes to presentation can break assertions without changing the behavior being tested.

## Motivation

Tests should describe accessible behavior and use explicit, shared hooks when an element has no suitable semantic locator.

## Desired outcome

Controller tests use Capybara assertions and accessible selectors instead of `assert_select`. Where semantic locators are insufficient, application markup and tests share literal, dashed `data-test-id` names.

## Scope

- Included: a shared `ControllerTest` base, controller HTML assertions, required application markup, helper contract tests, and directly related documentation.
- Excluded: migration of existing helper/component assertions, browser automation, application behavior changes, and CLI changes.

## Constraints

- The initial proposal used `data-test-id` and `data-test-class`, not test-only HTML IDs or CSS classes. The [accepted decision](history/decisions/2026-11-08-literal-test-hooks.md) superseded this with literal `data-test-id` hooks only.
- Prefer accessible selectors for labeled controls and roles. Use hooks where semantic locators are insufficient.
- Integrate [capybara_accessible_selectors](https://github.com/citizensadvice/capybara_accessible_selectors).
- Preserve labels, form parameters, default selections, response statuses, redirects, pagination, and existing appearance.
- Keep Rails integration requests. Capybara parses their responses without starting a browser.
- Do not remove Rails' transitive `rails-dom-testing` dependency. The migration replaces controller assertions, not Rails internals.

## Success criteria

- All controller test classes inherit from `ControllerTest` and use Capybara for HTML assertions.
- Controller tests have no `assert_select` calls or styling-dependent locators.
- Literal hook names agree between application markup and tests. No naming helpers or `data-test-class` attributes are needed.
- The base includes `Capybara::Minitest::Assertions` and exposes the current response as `page`.
- Assertions remain correct across successive responses, including negative assertions and non-visible metadata or hidden form fields.
- Existing controller behavior coverage remains intact and required checks pass.

## Scope history

- The user agreed to the data-attribute contract and controller-only migration on 2026-11-08.
- Initial planning deferred implementation and left helper signatures unresolved.
- On resuming, the user approved implementation and uncached response parsing, then replaced the helper-based proposal with literal hooks. See the [accepted contract decision](history/decisions/2026-11-08-literal-test-hooks.md).

## References

- Plan: [PLAN.md](PLAN.md)
- Current state: [STATE.md](STATE.md)
- Workstream: [Controller assertions](workstreams/controller-assertions.md)
- Initial evidence: [Repository and upstream findings](evidence/2026-11-08-baseline.md)
