# Rails view composition

## Original problem

The UI has both Haml templates and a growing component library, but their responsibilities are not clear. Small match-specific components reproduce typography styles instead of composing shared primitives. Templates still carry repeated styling and presentation details.

## Motivation

Feature markup should be easy to find and change without introducing a Ruby class for every fragment. Shared UI should stay consistent without repeating its visual rules across pages.

## Desired outcome

Use Rails views, partials, and helpers for ordinary feature composition. Use shared components for typography and other recurring UI elements. Introduce a feature-specific component only when its behavior or presentation complexity warrants that boundary.

## Scope

- Included: match setup, history, play view, and shared layout composition; necessary shared UI API improvements; related translations, tests, and contributor guidance.
- Excluded: redesign, game rules, persistence changes, CLI changes, new frontend frameworks, replacing Phlex, or rebuilding every existing component.
- This session creates the initiative and proposed plan only. Application implementation needs approval.

## Constraints

- Keep Haml, Tailwind CSS 4, Hotwire, Literal::Properties, and the existing Phlex Kit integration.
- Preserve intentional defaults, forms, routes, validation responses, move revisions, accessible labels, and keyboard behavior.
- Keep template-specific translations relative to their template or partial. Preserve shared model translations.
- Use the supplied internal guide only as background. These records contain original repository-specific guidance and examples, not a copy of that document.

## Success criteria

- Match templates visibly compose ordinary feature fragments through Rails primitives, with explicit inputs to extracted partials.
- Repeated typography and supported recurring controls use shared UI APIs rather than restating their visual styles.
- Shared components own appearance and semantics; callers own placement. Feature-specific components have a documented reason to exist.
- Existing match workflows and failure states remain covered by request tests. Component and helper tests cover the boundaries introduced by the migration.
- Tailwind build and autoload checks pass for the changed implementation. Visual checks are performed only if the user approves scenarios.
- Contributor guidance explains the boundary with examples matching the implemented APIs.

## Initial assumptions

- The existing match-specific components are candidates for partials, not evidence that Phlex itself should be removed.
- Reusing existing primitives will usually be enough. API gaps must be demonstrated in a migrated slice before extending the library.
- Preserve the current look. Any intentional visual or semantic correction needs separate agreement.

## References

- Plan: [PLAN.md](PLAN.md)
- Current state: [STATE.md](STATE.md)
- Proposed guidance and original examples: [Composition guide](composition-guide.md)
- Baseline: [Initial investigation](history/experiments/2026-11-08-view-construction-baseline.md)
- Existing integration: [Phlex rendering initiative](../phlex-rendering/README.md)
