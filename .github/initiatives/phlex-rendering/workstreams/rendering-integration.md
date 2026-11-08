# Rendering integration

## Objective
Make component calls readable without bypassing Rails rendering or assuming unsupported Kit behavior.

## Deliverables
- [x] Inspect existing setup and consult the online documentation.
- [x] Agree on Haml integration versus a Phlex rendering context.
- [x] Verify compatibility and implement the agreed pattern.
- [x] Test rendered output and escaping, then update design-system guidance.

## Dependencies
- User agreement on rendering context and any dependency changes.

## Progress
- 2026-11-08: Kits support capitalized calls inside Phlex. Documentation explicitly excludes ERB. Haml is also an ActionView template, not a Phlex component context; a helper inclusion alone is not a documented solution.
- Existing application calls manually render and mark component output safe. No explicit Kit initializer was found, and the application helper is empty.
- Later on 2026-11-08: The user approved the exact `DesignSystem` Kit/helper spike. The method resolves in Haml, but Rails component rendering fails. These are baseline observations above, not the current helper implementation. See the [spike](../history/experiments/2026-11-08-haml-kit-spike.md).
- Paused on 2026-11-08: The user selected committing initiative records only and retaining the failing application changes uncommitted for later.
- Resumed and completed on 2026-11-08: The user approved `Components` with collapsed grouping directories and then the focused phlex-rails 1.2.2 upgrade. All match-view component calls now render through Kits; full tests, Tailwind, and Zeitwerk pass. See the [implementation record](../history/experiments/2026-11-08-components-integration.md).

## Open questions and risks
- Resolved: retain Haml and use the compatible Rails adapter, without custom rendering helpers.
- Future risk: new components must have unique filenames/constants under the collapsed `Components` namespace.

## References
- [Investigation](../history/experiments/2026-11-08-kits-and-haml.md)
- [Existing design-system guidance](../../../design-system/README.md)
- [Historical design-system plan](../../../plans/design-system-phlex.md)
