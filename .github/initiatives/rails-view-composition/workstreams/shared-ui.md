# Shared UI and contributor guidance

## Objective

Make recurring visual and semantic contracts reusable while leaving feature layout and Rails submission behavior at their natural boundaries.

## Deliverables

- [ ] Reuse existing typography and other applicable primitives in each migrated slice.
- [ ] Demonstrate and test any necessary API extension, including attribute forwarding and Haml block rendering.
- [ ] Document why any feature-specific component remains.
- [ ] Promote approved, verified composition rules into the owning frontend instructions and update examples to match the final code.

## Dependencies

Direction approval and concrete needs from the [feature composition workstream](feature-composition.md). Guidance finalization depends on both migrated slices.

## Progress

- 2026-11-08: Existing Typography, Heading, Eyebrow, Button, and Base APIs inspected. Current feature wrappers mostly bypass these primitives. No shared API changes made.

## Open questions and risks

- Typography and Heading overlap but have different APIs. Reuse what fits before proposing consolidation.
- A shared Button renders a button element, not a Rails form. Control reuse must preserve the form-builder and `button_to` contracts.
- Avoid caller-level appearance overrides and speculative variants.

## References

- [Proposed composition guide](../composition-guide.md)
- [Typography](../../../../app/components/design_system/typography.rb)
- [Heading](../../../../app/components/design_system/heading.rb)
- [Button](../../../../app/components/design_system/button.rb)
- [Tailwind tokens](../../../../app/assets/tailwind/application.css)
