---
name: multi-phase
description: "Plan and execute multi-phase features, architectural migrations, and staged application evolution. Use for dependent milestones, acceptance criteria, compatibility checks, and work that must resume across sessions."
argument-hint: "Goal or existing plan path; specify plan-only to defer implementation"
user-invocable: true
---

# Multi-phase delivery

Carry a substantial goal through approved, independently verifiable phases. Keep progress durable without imposing this workflow on small changes.

## Establish the goal

1. Read applicable repository instructions and project learnings. Inspect the concrete implementation anchor and nearest tests, keeping investigation local to a testable first phase.
2. Identify the outcome, existing behavior to preserve, exclusions, and constraints. Ask only questions that materially affect scope, architecture, or acceptance.
3. Distinguish brainstorming, plan-only requests, and implementation. Discussing an idea does not approve implementation.

## Write and approve the plan

1. Reuse a named existing plan or create `.github/plans/<descriptive-name>.md` using the structure below. Preserve unrelated plans and user changes.
2. Order phases by dependencies. Prefer small vertical slices with observable outcomes over isolated layers that cannot yet be exercised. Defer later implementation details until their phase begins.
3. Give each phase concrete acceptance criteria and the smallest checks that establish them. Include compatibility and failure cases, not just successful paths.
4. For migrations, identify source and target state, compatibility requirements, data validation, deployment order, and recovery. State when rollback is impossible; never assume destructive changes are authorized.
5. Present the plan and request approval before feature implementation. Record the approved scope and phase sequence. In plan-only mode, stop after delivering the plan.
6. Once approved, continue through phases without routine approval pauses. Ask again before material scope changes, destructive operations, or changes to explicit constraints. Respect subsequent instructions to pause or require phase-by-phase approval.

## Execute each phase

1. Mark the current phase `in_progress`. Start it only when its dependencies are complete.
2. Before editing, state a local hypothesis, its controlling code path, and a cheap check that could disprove it. Make the smallest grounded change, then immediately run the focused check. Repair local failures before widening scope.
3. Reuse existing domain logic, tests, and utilities. Preserve behavior unless its change belongs to the approved plan. Keep adjacent changes limited to the current phase's acceptance criteria.
4. Follow repository-required code-quality review and verification gates. Prefer existing tests or simple commands. Do not run inline custom verification scripts; if a one-off script is necessary, put it in a readable temporary file, show its purpose and path, obtain approval before running it, and explicitly remove it afterward, including on failure.
5. Before browser-based verification, ask which scenarios the user wants tested. Combine those scenarios with applicable required checks.
6. Record commands and outcomes as checks run. Mark a phase complete only when its acceptance criteria and required gates have passed. Unrun, inconclusive, and failing checks are not passes.
7. Update the plan and briefly report the phase's outcome, then proceed to the next approved phase.

## Handle discoveries and blockers

- Adjust implementation details within approved scope when evidence warrants it. Record meaningful decisions and their reasons.
- If a discovery changes scope, dependencies, acceptance criteria, or migration safety, propose the plan change and obtain approval before executing affected work. Never weaken criteria just to make a phase pass.
- For a blocker, record evidence, attempted remedies, affected phase, and the exact action needed to continue. Mark the phase `blocked`, not complete.
- Continue independent approved work only when it does not depend on the blocked phase. Do not invent unrelated work.
- This skill does not authorize commits, delegation, or destructive operations. Follow user authorization and applicable instructions.

## Resume and close

1. Read the plan and newest request. Confirm recorded approval still covers the requested work.
2. Check the current worktree and relevant implementation before trusting recorded progress. Preserve user changes. Rerun checks when intervening changes or missing evidence make prior results unreliable.
3. Resume the first unblocked, incomplete phase with satisfied dependencies. Do not restart completed phases or silently replace the plan.
4. At completion, run the agreed cross-phase checks and update final status. Summarize delivered behavior, verification, and unresolved limitations. Do not declare the overall goal complete while required criteria remain unmet.

## Plan structure

Keep the document concise and update it in place. Repeat the phase section for each milestone.

```markdown
# <Goal>

## Outcome and scope
- Outcome:
- Preserve:
- Excluded:
- Constraints:

## Approval
- Status: proposed | approved
- Approved scope and phase sequence:
- Execution policy: continue through approved phases

## Phases
### 1. <Observable milestone>
- Status: pending | in_progress | blocked | complete
- Depends on: none
- Deliverables:
- Acceptance criteria:
- Verification commands or agreed manual checks:
- Results: not run

## Migration and recovery
- Compatibility, data safety, deployment order, recovery: <details or not applicable>

## Decisions and blockers
- <Decision and reason, or blocker evidence and required action>

## Resume point
- Next action:

## Final verification
- Cross-phase checks and outcomes: not run
```
