# Rendering integration

## Objective
Make component calls readable without bypassing Rails rendering or assuming unsupported Kit behavior.

## Deliverables
- [x] Inspect existing setup and consult the online documentation.
- [ ] Agree on Haml integration versus a Phlex rendering context.
- [ ] Verify compatibility and implement the agreed pattern.
- [ ] Test rendered output and escaping, then update design-system guidance.

## Dependencies
- User agreement on rendering context and any dependency changes.

## Progress
- 2026-11-08: Kits support capitalized calls inside Phlex. Documentation explicitly excludes ERB. Haml is also an ActionView template, not a Phlex component context; a helper inclusion alone is not a documented solution.
- Existing application calls manually render and mark component output safe. No explicit Kit initializer was found, and the application helper is empty.

## Open questions and risks
- Should Haml remain the caller, using Rails rendering or a small explicit helper?
- Is a Phlex view migration acceptable to obtain native Kit syntax?
- Which version-compatible Rails integration should be adopted?

## References
- [Investigation](../history/experiments/2026-11-08-kits-and-haml.md)
- [Existing design-system guidance](../../../design-system/README.md)
- [Historical design-system plan](../../../plans/design-system-phlex.md)
