---
name: initiative
description: "Workflow for persistent engineering initiatives across sessions: select or create initiatives, explore, plan, execute, review, reorient, and maintain Markdown knowledge, decisions, experiments, and evidence."
argument-hint: "Optional natural-language request; leave blank to resume or check status"
user-invocable: true
---

# Initiative Workflow

Use this workflow when invoked as `/initiative` or when guiding a persistent engineering initiative. Treat text after `/initiative` as an optional natural-language request rather than requiring a fixed subcommand. If it is absent or ambiguous, reconstruct status and recommend a next step without beginning substantial implementation. Markdown and Git are the storage system; do not introduce a database, task manager, or metadata parser.

## Resume efficiently

1. Read `.github/initiatives/README.md` and identify the initiative most relevant to the request. If there is no clear match among multiple initiatives, ask the user to select one. Do not load every initiative's history.
2. Read the selected initiative's `README.md`, `STATE.md`, and `PLAN.md`. Verify important current-state claims against the implementation, tests, or other objective sources before relying on them.
3. Follow only the relevant workstream, decision, experiment, and evidence references. Treat recorded state as a useful snapshot, not proof that the repository has not changed.
4. Infer the workflow from natural language and context. Ask concise clarifying questions only when missing information materially affects initiative selection, scope, architecture, success criteria, or safety.

## Choose a workflow

### Explore

- Investigate the existing code, technology, or question. State what is known, what remains uncertain, and what evidence supports each finding.
- Challenge the proposed solution when it does not appear to serve the original problem. Exploration may produce a recommendation, experiment record, or proposed decision, but does not silently authorize implementation.
- Record durable findings in the relevant workstream or a dated experiment record. Cite files, tests, commands, and sources; distinguish assumption, hypothesis, observation, validated finding, and decision.

### Plan

- Revisit the original outcome and scope before refining the approach. Identify deliverables, dependencies, risks, open questions, and useful verification at baseline, quality-gate, and outcome levels.
- Keep `PLAN.md` as the current roadmap. Make a dated plan-change record under `history/plan-changes/` when a material change needs its rationale preserved; do not preserve routine edits as ceremony.
- Explain consequential alternatives and surface architectural choices or direction changes for user agreement before adopting them.

### Execute

- Begin implementation only when the user has agreed to the deliverable or an existing initiative record clearly approves it. Follow the repository's instructions and verification requirements.
- Keep changes within the agreed scope. Run focused checks, record actual commands and results, and update relevant evidence, workstream, and state records.
- If work reveals a material scope change, architectural decision, or invalidated premise, pause affected implementation, document the evidence, and discuss the recommendation rather than silently expanding scope.

### Review

- Compare the result with the original objective, agreed acceptance criteria, and actual verification evidence. Recommend accept, iterate, reject, or investigate further.
- Preserve failed and inconclusive attempts as well as successful findings. Update the experiment or decision record, current plan, and concise state snapshot as warranted.

### Reorient

- Revisit the original problem, evidence, and decisions. Identify assumptions that no longer hold and compare credible alternatives.
- Do not erase superseded approaches. Record a new decision referencing the prior record, explain consequences, and propose the corresponding plan change. Seek agreement before changing direction or starting consequential work.

### Status or resume

- Summarize the objective, current position, established findings, uncertainty, blockers, focus, and one useful next step. Verify important claims locally.
- Do not start substantial implementation just because the user asks for status or invokes `/initiative` without a clear request.

## Maintain the knowledge base

- Keep initiative `README.md` relatively stable: original problem, motivation, desired outcome, scope, non-goals, constraints, and success criteria.
- Keep `STATE.md` concise and current. Record what changed, current focus, blockers, important established findings, unresolved uncertainty, and the next step. Progress is more than completed checklist items.
- Keep `PLAN.md` hierarchical and actionable, with workstreams, milestones, deliverables, dependencies, and open questions. It is the intended direction, not immutable history.
- Workstream files own area-specific objectives, deliverables, dependencies, progress, and questions. Update the root initiative index when an initiative is created or its status/focus changes.
- Create dated experiment records for substantive investigations or attempts. Include question, type (investigation, experiment, spike, implementation, or verification), hypothesis if relevant, approach, evaluation criteria, evidence, conclusion, and implications. A failed approach remains useful history.
- Create dated decision records for significant technical or strategic choices. Include context, options, decision, rationale, consequences, related experiments, and any superseded decision. Never rewrite an accepted decision as if it had not changed.
- Put reproducible measurements and verification references in `evidence/`. Preserve objective command output where practical, but avoid copying large logs when a stable artifact or concise excerpt suffices.
- Record assumptions as assumptions. Do not turn agent-generated summaries into evidence or claim a check passed if it was not run.
- Use templates from `./templates/` when creating files. Keep relationships explicit with Markdown links and avoid forcing routine work into a dependency graph.

## Create or select an initiative

- For a new initiative request, create the overview, plan, state, and index entry before changing application code or dependencies. Loading this skill alone is not initiative setup.
- For a new initiative, use the index to choose a short kebab-case directory name that does not collide. Gather only missing details that matter; reasonable provisional assumptions may be recorded explicitly and confirmed later.
- Create `README.md`, `PLAN.md`, `STATE.md`, and relevant workstream files from templates. Create `history/experiments/`, `history/decisions/`, and `evidence/` as needed, and add the initiative to the root index.
- Distinguish the user's underlying problem from an initial solution suggestion. A proposed technology is a hypothesis unless the user has made it a constraint.
- For multiple existing initiatives, select using the request and current focus. If selection remains unclear, ask rather than updating the wrong initiative.

## Close each meaningful session

Update only the records affected by the work: the index if selection/status/focus changes, `STATE.md` after meaningful progress or discovery, `PLAN.md` after an agreed roadmap change, and relevant workstream/history/evidence files. End with a concise account of discoveries, consequences, verification, blockers, and the recommended next step. Leave enough repository-grounded context for a fresh session to continue without chat history.
