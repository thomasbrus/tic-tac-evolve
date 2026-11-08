# Current State

- **Objective:** Make Rails primitives the default for feature composition while using shared components for recurring UI.
- **Current position:** Initiative created. Baseline investigated; migration and contributor rules remain proposed. No application code changed.
- **Established:** Five match-specific Phlex components render small history/setup fragments. Their typography is handwritten despite existing shared primitives. Haml owns the setup form and board. See the [baseline investigation](history/experiments/2026-11-08-view-construction-baseline.md).
- **Uncertain:** Which shared component APIs need extension; the best remaining boundary for the board; rendered and visual parity after extraction.
- **Blockers:** Implementation approval is pending. No technical blocker established.
- **Current focus:** Review the [composition guide](composition-guide.md) and [phase sequence](PLAN.md).
- **Suggested next step:** Approve or revise the direction, then establish focused test coverage and migrate setup/history as the first slice.
- **Verification:** Source, writing, and relative-link review completed. Scoped whitespace/conflict-marker checks were clean; editor diagnostics reported no errors. No application tests or browser checks run in this session.
- **Updated:** 2026-11-08
