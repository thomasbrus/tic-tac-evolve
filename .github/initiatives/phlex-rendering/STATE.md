# Current State

- **Objective:** Replace manual component rendering with a documented integration and, if supported, capitalized component calls.
- **Current position:** Paused at documented findings at the user's request. No application changes made.
- **Established:** The [Kits documentation](https://www.phlex.fun/components/kits.html) limits shorthand to Phlex contexts. The current helper is empty, components use `DesignSystem` and `Matches` namespaces, and match views are Haml. See the [investigation](history/experiments/2026-11-08-kits-and-haml.md).
- **Uncertain:** Compatibility of current online APIs with installed Phlex 1.11.1 / phlex-rails 0.1.0; behavior of any proposed Haml helper bridge.
- **Blockers:** None for this investigation. Implementation is deferred.
- **Current focus:** Preserve findings for a future decision.
- **Suggested next step:** If resumed, choose a Haml rendering integration, an explicit shorthand helper, or a separately approved Phlex view migration.
- **Updated:** 2026-11-08
