# Persistent Initiative Workflow

> The original prompt-and-hidden-skill design below was superseded by the directly invocable [`/initiative` skill](../skills/initiative/SKILL.md). The prompt wrapper was removed, and the workflow and templates were moved together.

## Outcome and scope
- **Outcome:** Provide one `/initiative` command backed by repository-native prompts, a hidden workflow skill, and a durable Markdown knowledge base for independent engineering initiatives.
- **Preserve:** Existing Copilot instructions, skills, plans, and the current application/CLI behavior.
- **Excluded:** A task manager, database, custom parser, additional user-facing slash commands, or a seeded example initiative.
- **Constraints:** Use VS Code's supported `.github/prompts/*.prompt.md` and `.github/skills/<name>/SKILL.md` conventions; keep initiative history selectively loaded.

## Approval
- **Status:** approved by the implementation request
- **Approved scope and phase sequence:** Add the single prompt and hidden skill, templates and index, then validate integration and documentation.
- **Execution policy:** Complete the approved scope without routine pauses.

## Phases
### 1. Entry point and workflow
- **Status:** complete
- **Depends on:** none
- **Deliverables:** `/initiative` prompt, non-invocable workflow skill, repo instruction link.
- **Acceptance criteria:** Prompt accepts optional natural-language intent and explicitly loads the skill; no second slash command is introduced.
- **Verification commands or agreed manual checks:** Review prompt and skill frontmatter and invocation guidance.
- **Results:** Implemented using VS Code workspace prompt and skill conventions. Chat invocation is not available in this tool session.

### 2. Persistent knowledge model
- **Status:** complete
- **Depends on:** Phase 1
- **Deliverables:** Initiative index, templates for overview/plan/state/workstream/experiment/decision, lifecycle and history guidance.
- **Acceptance criteria:** Supports multiple initiatives; separates stable outcome, evolving plan, actual state, experiments, decisions, and evidence; retains failed approaches.
- **Verification commands or agreed manual checks:** Review templates and links against the requested model.
- **Results:** Markdown-only structure and templates implemented; no sample initiative was seeded.

### 3. Integration and documentation validation
- **Status:** complete
- **Depends on:** Phases 1-2
- **Deliverables:** Validate frontmatter, links, and whitespace; record limitations of direct prompt execution testing.
- **Acceptance criteria:** Prompt is discoverable as `/initiative`, skill is not independently user-invocable, references resolve, and changed Markdown has no whitespace errors.
- **Verification commands or agreed manual checks:** Frontmatter/link review, editor diagnostics where available, and `git diff --check`.
- **Results:** Prompt and skill use the documented workspace frontmatter conventions; the prompt explicitly loads the hidden skill and links to the initiative index. Editor diagnostics reported no errors for the added Markdown, and `git diff --check` passed. Direct `/initiative` execution in VS Code Chat was unavailable in this session.

## Decisions and blockers
- Use a workspace prompt as the sole slash entry point and set `user-invocable: false` on the skill, because VS Code exposes both prompts and skills as commands by default.
- No blocker identified. End-to-end Chat invocation cannot be exercised through the available tools.

## Resume point
- **Next action:** Begin using `/initiative` to create or resume a repository-backed initiative; validate actual Chat invocation in VS Code.

## Final verification
- **Cross-phase checks and outcomes:** Frontmatter and links reviewed against the workspace prompt/skill conventions; editor diagnostics clean; `git diff --check` clean. Application tests were not applicable to documentation and agent configuration changes. Chat invocation remains to be verified in the interactive VS Code environment.
