# Feature composition

## Objective

Use Rails views, partials, and helpers to make match pages readable without turning every fragment into a component.

## Deliverables

- [ ] Setup/history slice uses explicit partial inputs, collection rendering where appropriate, and shared typography.
- [ ] Formatting helpers are feature-prefixed, limited to presentation, and tested when introduced.
- [ ] Play/layout slice follows the same rules while preserving Rails forms and all DOM behavior hooks.
- [ ] Partial translation paths and removed wrapper callers/tests are migrated together.

## Dependencies

Direction approval, then the shared UI workstream's contributions within each [phase](../PLAN.md).

## Progress

- 2026-11-08: [Baseline investigation](../history/experiments/2026-11-08-view-construction-baseline.md) identified five small feature wrappers and an integration test coupled to one of them. No migration started.

## Open questions and risks

- Keep each fragment useful; splitting every element into a partial would reproduce the current abstraction problem.
- Decide the board boundary after inspecting its rendering needs during phase 2.
- Preserve styling hooks currently used by request tests, even when they are not needed for Tailwind styling.

## References

- [Index view](../../../../app/views/matches/index.html.haml)
- [Play view](../../../../app/views/matches/show.html.haml)
- [Request tests](../../../../test/controllers/matches_controller_test.rb)
- [Kit helper tests](../../../../test/helpers/application_helper_test.rb)
