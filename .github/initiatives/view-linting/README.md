# Haml view linting

## Original problem
Views and partials lack a repeatable check for consistent Haml and embedded Ruby style.

## Motivation
Make the preferred syntax easy to follow and catch drift before finishing work.

## Desired outcome
Consistent views with simple lint checks used locally, by agents, and in CI.

## Scope
- Included: all Haml views and partials, embedded Ruby, strict locals, lint configuration, and related instructions/examples.
- Excluded: linting or reformatting standalone Ruby files, UI redesign, and browser testing.

## Constraints
- Use haml-lint with RuboCop for embedded Ruby.
- Prefer single-quoted Ruby strings and parentheses on calls with arguments.
- Prefer class shorthand, then HTML-style attributes, then Ruby hashes when needed.
- Declare strict locals on every partial, including an empty signature for no-input partials.
- Preserve rendering, classes, translations, forms, and collection rendering.
- Keep configuration focused; avoid custom linters unless a required rule cannot be enforced otherwise.

## Success criteria
- All current Haml templates pass the shared lint command.
- Partial signatures work with the installed Rails/Haml handler.
- CI and finishing-work instructions use the same command.
- Rendering tests, the full non-browser suite, Tailwind build, and Rails loading check pass.

## Initial assumptions
- Built-in linters were expected to cover the requested conventions. Verification found that the full class fallback hierarchy needs manual review; basic shorthand, quotes, parentheses, and strict locals are linted.

## References
- Plan: [PLAN.md](PLAN.md)
- Current state: [STATE.md](STATE.md)
- Workstream: [View conventions and checks](workstreams/view-conventions.md)
- Verification: [Lint and rendering checks](evidence/2026-11-08-checks.md)
