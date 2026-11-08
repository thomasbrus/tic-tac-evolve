# Phlex rendering integration

## Original problem
Haml templates render components with `raw(Component.new(...).call)`. This obscures the component API and bypasses framework-level rendering.

## Motivation
Use the library's documented integration rather than manual HTML rendering.

## Desired outcome
Understand whether `ErrorMessage(message: @match.errors.full_messages.to_sentence)` can replace the current construction, and establish a supported rendering pattern.

## Scope
- Included: Phlex setup, Kits, Rails integration, and component calls in match views.
- Excluded: UI redesign, game behavior changes, and unrelated component refactoring.

## Constraints
- Preserve Haml unless the user approves a change.
- Use online documentation as the library reference, not installed gem source.
- Confirm consequential dependency and rendering choices before implementation.

## Success criteria
- Explain the Kit and Rails rendering requirements with documentation references.
- Verify the chosen syntax in its actual rendering context, including escaped error text.
- Preserve request behavior, accessibility, translations, and the CLI.

## Initial assumptions
- The previous project's `Components` Kit and helper inclusion may offer a reusable pattern. Compatibility with this application's Haml context is not established.
- Current online documentation may differ from the installed library versions.

## References
- Plan: [PLAN.md](PLAN.md)
- Current state: [STATE.md](STATE.md)
- Investigation: [Kits and Haml](history/experiments/2026-11-08-kits-and-haml.md)
