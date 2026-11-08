# Engineering Initiatives

Persistent, repository-backed context for multi-session engineering work. The `/initiative` prompt is the single entry point; it selects or creates an initiative and loads only the relevant records. See the [workflow skill](../skills/initiative-workflow/SKILL.md) for operating rules and reusable [templates](../skills/initiative-workflow/templates/).

## Initiative index

| Initiative | Status | Current focus | State |
| --- | --- | --- | --- |
| [Phlex rendering integration](phlex-rendering/README.md) | paused | Kit method resolves in Haml; failing application spike left uncommitted | [STATE.md](phlex-rendering/STATE.md) |

Use one row per initiative. Link its overview and `STATE.md`; keep status and focus current. Suggested statuses are `proposed`, `active`, `blocked`, `paused`, and `complete`. Multiple initiatives can be active; select using the user's request and each initiative's current state, and ask only when the choice is genuinely ambiguous.

## Directory structure

Each initiative directory contains:

- `README.md`: original problem, motivation, desired outcome, scope, constraints, and success criteria.
- `PLAN.md`: the current, revisable roadmap.
- `STATE.md`: a short resume snapshot, kept current after meaningful changes.
- `workstreams/`: area-specific deliverables, dependencies, progress, and questions.
- `history/experiments/`: dated investigations and attempts, including failed and inconclusive outcomes.
- `history/decisions/`: dated decisions; accepted decisions are superseded by new records, never silently rewritten.
- `history/plan-changes/`: rationale for material roadmap changes when not already captured by a decision.
- `evidence/`: concise, traceable verification and measurements; retain command/source references and objective output where practical.

Create history subdirectories as needed. Do not create empty records or duplicate complete command logs without a reason. Keep the stable objective, current direction, historical reasoning, and actual progress distinct.
