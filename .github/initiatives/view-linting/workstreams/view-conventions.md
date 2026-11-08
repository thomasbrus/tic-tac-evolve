# View conventions and checks

## Objective
Make the requested style consistent across Haml templates and keep it checked at completion.

## Deliverables
- [x] Focused haml-lint/RuboCop configuration and one local/CI command.
- [x] Single-quoted Ruby strings, parenthesized calls, preferred class syntax, and strict partial locals.
- [x] Updated view instructions, finishing checks, and current composition examples.
- [x] Passing lint and rendering checks with concise evidence.

## Dependencies
- Approved plan and Ruby-compatible lint dependencies; both satisfied.

## Progress
- 2026-11-08: inspected templates and existing instructions; confirmed Haml-only scope with the user.
- Plan approved; implementation and checks completed. Paused at the user's request before acceptance review.

## Open questions and risks
- Full class fallback enforcement is manual; built-in shorthand lint is limited to simple class values.
- No-input and collection partials render successfully; missing and unexpected locals are rejected.

## References
- [Plan](../PLAN.md)
- [View instructions](../../../instructions/views.instructions.md)
- [Templates](../../../../app/views/)
- [Verification evidence](../evidence/2026-11-08-checks.md)
