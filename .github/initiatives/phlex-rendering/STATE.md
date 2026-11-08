# Current State

- **Objective:** Replace manual component rendering with a documented integration and, if supported, capitalized component calls.
- **Current position:** Paused at the user's request. Initiative records are selected for commit; the failing application spike is deliberately left uncommitted for later.
- **Established:** Including the `DesignSystem` Kit in `ApplicationHelper` resolves `ErrorMessage(...)` from Haml. Rails then rejects the component as a partial instead of rendering it. See the [spike](history/experiments/2026-11-08-haml-kit-spike.md), which qualifies the earlier [docs investigation](history/experiments/2026-11-08-kits-and-haml.md).
- **Uncertain:** Which version-compatible Rails integration enables ActionView rendering for current components.
- **Blockers:** Six focused rendering tests error; no dependency change is approved.
- **Current focus:** Preserve the Kit spike and actual failure evidence without further implementation.
- **Suggested next step:** When resumed, investigate version-compatible Rails integration using online guidance. Do not assume the current error views work or that a dependency upgrade is approved.
- **Updated:** 2026-11-08
