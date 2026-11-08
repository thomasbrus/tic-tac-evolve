# Feature composition

## Objective

Use Rails views, partials, and helpers to make match pages readable without turning every fragment into a component.

## Status

Phases 1–2 are complete. Phase 3 is paused pending verification.

## Deliverables

- [x] Setup/history slice uses explicit partial inputs, collection rendering where appropriate, and shared typography.
- [x] No new formatting helper was needed; existing presentation remains clear without one.
- [x] Play/layout slice follows the same rules while preserving Rails forms and all DOM behavior hooks.
- [x] Partial translation paths and removed wrapper callers/tests are migrated together.

## Dependencies

The shared UI workstream contributes within each approved [phase](../PLAN.md).

## Progress

- 2026-11-08: [Baseline investigation](../history/experiments/2026-11-08-view-construction-baseline.md) identified five small feature wrappers and an integration test coupled to one of them.
- 2026-11-08: [Phase 1 implementation](../history/experiments/2026-11-08-setup-history-slice.md) replaced the setup/history wrappers with Haml partial composition and verified request behavior.
- 2026-11-08: [Phase 2 implementation](../history/experiments/2026-11-08-play-layout-slice.md) extracted the board partial and applied shared typography to the play page and application header.

## Open questions and risks

- Keep each fragment useful; splitting every element into a partial would reproduce the current abstraction problem.
- The board's loop and Rails form wiring are a useful partial boundary; no feature component is needed.
- Do not retain non-styling classes solely for request-test selectors; assert semantic structure and rendered content.

## References

- [Index view](../../../../app/views/matches/index.html.haml)
- [Play view](../../../../app/views/matches/show.html.haml)
- [Request tests](../../../../test/controllers/matches_controller_test.rb)
- [Kit helper tests](../../../../test/helpers/application_helper_test.rb)
