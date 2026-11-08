# Current State

- **Objective:** Replace styling-dependent controller assertions with accessible Capybara selectors and shared data hooks.
- **Current position:** Complete. All three phases verified; user accepted the implementation on 2026-11-08. Implementation committed as `089a512`.
- **Established:** Both controller test classes inherit from `ControllerTest`. HTML assertions use Capybara with accessible selectors and literal data hooks. `page` reparses the current response; freshness, negative assertions, hidden inputs, and head metadata have contract tests.
- **Contract:** Use dashed literal `data-test-id` names; no `test_id`/`test_class` helpers or `data-test-class`. See the [accepted decision](history/decisions/2026-11-08-literal-test-hooks.md).
- **Verification:** Full suite passed with 111 tests before the final appearance-only test addition; the final affected tests passed with 22 tests and 149 assertions. Build, autoload, Haml lint, Ruby lint, and whitespace checks passed. See [evidence](evidence/2026-11-08-implementation.md).
- **Uncertain:** No observed compatibility failures. The upstream `v0.12.0` tag reports gem version `0.11.0`; the lockfile pins its exact revision.
- **Blockers:** None. Browser testing remains outside scope.
- **Current focus:** Closed and accepted.
- **Suggested next step:** None within this initiative. Use the established assertion convention for future controller tests.
- **Updated:** 2026-11-08
