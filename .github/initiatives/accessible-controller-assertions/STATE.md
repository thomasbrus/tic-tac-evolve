# Current State

- **Objective:** Replace styling-dependent controller assertions with accessible Capybara selectors and shared data hooks.
- **Current position:** Initiative created. Direction and scope agreed; phased implementation plan remains proposed.
- **Established:** Controller tests use Rails integration requests and `assert_select`. No Capybara dependency or shared test hooks currently exist. See [baseline evidence](evidence/2026-11-08-baseline.md).
- **Uncertain:** Exact helper signatures, static-name handling, dependency compatibility, and response-cache strategy.
- **Blockers:** None for planning. Implementation has not been authorized.
- **Current focus:** Plan-only setup, as requested.
- **Suggested next step:** Agree on the helper API and approve phase 1.
- **Updated:** 2026-11-08
