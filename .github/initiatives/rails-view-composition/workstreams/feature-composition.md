# Feature composition

## Objective

Use Rails views, partials, and helpers to make match pages readable without turning every fragment into a component.

## Status

Phase 1 is complete. Phase 2 awaits approval.

## Deliverables

- [x] Setup/history slice uses explicit partial inputs, collection rendering where appropriate, and shared typography.
- [ ] Formatting helpers are feature-prefixed, limited to presentation, and tested when introduced.
- [ ] Play/layout slice follows the same rules while preserving Rails forms and all DOM behavior hooks.
- [ ] Partial translation paths and removed wrapper callers/tests are migrated together.

## Dependencies

Direction approval, then the shared UI workstream's contributions within each [phase](../PLAN.md).

## Progress

- 2026-11-08: [Baseline investigation](../history/experiments/2026-11-08-view-construction-baseline.md) identified five small feature wrappers and an integration test coupled to one of them.
- 2026-11-08: [Phase 1 implementation](../history/experiments/2026-11-08-setup-history-slice.md) replaced the setup/history wrappers with Haml partial composition and verified request behavior.

## Open questions and risks

- Keep each fragment useful; splitting every element into a partial would reproduce the current abstraction problem.
- Decide the board boundary after inspecting its rendering needs during phase 2.
- Do not retain non-styling classes solely for request-test selectors; assert semantic structure and rendered content.

## References

- [Index view](../../../../app/views/matches/index.html.haml)
- [Play view](../../../../app/views/matches/show.html.haml)
- [Request tests](../../../../test/controllers/matches_controller_test.rb)
- [Kit helper tests](../../../../test/helpers/application_helper_test.rb)
