# Copilot Instructions for tic-tac-evolve

## Working Principles

- Preserve user changes and intentional behavior, including the existing CLI during Rails work. Make the smallest complete change within the requested scope.
- Clarify consequential stack or compatibility choices before implementing them; use the scoped [Rails](instructions/rails.instructions.md) and [view](instructions/views.instructions.md) conventions.
- Reuse context and skill instructions already read unless they changed or context was lost. Keep searches and diff output bounded; batch independent operations.
- Use the [multi-phase skill](skills/multi-phase/SKILL.md) for substantial dependent milestones, not routine edits. Update plans at phase boundaries, material decisions, blockers, and pauses.
- After code changes, perform the [code-quality review](skills/code-quality/SKILL.md) before closing. Do not repeat completed reviews or checks without intervening changes that affect their results.

## Verification

Run a focused check after a meaningful edit, then the final checks required by its risks. Do not treat unrun or failing checks as passes. Report existing failures separately from failures caused by the change.

| Changed Surface | Default Checks |
| --- | --- |
| Documentation or agent configuration | Frontmatter/link review, editor diagnostics where available, and scoped whitespace checks. No application suite by default. |
| Views or locales | Relevant controller/request tests; rebuild Tailwind when utility classes or styles change. |
| Shared game logic | Relevant domain tests and affected Rails/CLI tests. |
| Database, dependencies, or cross-module behavior | Database preparation where relevant, `bin/rails test test`, `bin/rails tailwindcss:build`, and `bin/rails zeitwerk:check`. |
| Commits | Follow the [commit skill](skills/commit/SKILL.md), including exact staged-content verification when remaining work could affect results. |

Prefer existing tests and simple commands. Do not run inline custom verification scripts. If a one-off script is necessary, put it in a readable temporary file in the session workspace, show its path and purpose, obtain approval before running it, and explicitly remove that specific file afterward, including on failure. Prefer maintained tests/scripts for recurring checks.

Before browser-based checks, ask which scenarios the user wants tested; respect explicit deferral of browser testing.

## Learning

When corrected or given a durable preference, acknowledge it and follow the [self-reflection skill](skills/self-reflection/SKILL.md). For complex tasks, consult relevant [learnings](memory/learnings.md); do not repeatedly reread unchanged history. Keep current standards in instructions or the owning skill, and historical rationale in memory.

## Commit Messages

- Use an accurate past-tense subject such as `Fixed`, `Refactored`, or `Updated`; do not default to `Added`.
- Do not add a Copilot authorship or co-authorship trailer.
