# Shared UI and contributor guidance

## Objective

Make recurring visual and semantic contracts reusable while leaving feature layout and Rails submission behavior at their natural boundaries.

## Status

Implementation and guidance are complete. Phase 3 is paused pending final verification.

## Deliverables

- [x] Reuse existing typography and other applicable primitives in each migrated slice.
- [x] Confirm no shared API extension is needed for the migrated slices.
- [x] No feature-specific component remains in the migrated scope.
- [x] Promote approved, verified composition rules into the owning frontend instructions and update examples to match the final code.

## Dependencies

Direction approval and concrete needs from the [feature composition workstream](feature-composition.md). Guidance finalization depends on both migrated slices.

## Progress

- 2026-11-08: Existing Typography, Heading, Eyebrow, Button, and Base APIs inspected. Both migrated slices reuse existing typography primitives without API changes. The play board remains a Haml partial and Rails `button_to` owns move submissions.
- 2026-11-08: Promoted the verified boundaries to the [frontend instructions](../../../instructions/views.instructions.md) and aligned the [composition guide](../composition-guide.md) with the final templates and APIs.

## Open questions and risks

- Typography and Heading overlap but have different APIs. Reuse what fits before proposing consolidation.
- A shared Button renders a button element, not a Rails form. Control reuse must preserve the form-builder and `button_to` contracts.
- Avoid caller-level appearance overrides and speculative variants.

## References

- [Composition guide](../composition-guide.md)
- [Typography](../../../../app/components/design_system/typography.rb)
- [Heading](../../../../app/components/design_system/heading.rb)
- [Button](../../../../app/components/design_system/button.rb)
- [Tailwind tokens](../../../../app/assets/tailwind/application.css)
