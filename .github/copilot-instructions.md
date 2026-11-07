# Copilot Instructions for tic-tac-evolve

## Self-Correction & Learning Loop

Whenever the user explicitly corrects your output, flags a misunderstanding, or refines a preference:

1. **Acknowledge the correction concisely** — thank the user and confirm what you understood.
2. **Execute a Self-Reflection step** — use the self-reflection skill to decide whether there is a durable, generalizable lesson.
3. **Update project memory when warranted** — record qualifying lessons in `.github/memory/learnings.md` before finalizing your response; do not log routine one-off fixes.

At the start of complex tasks, **review `.github/memory/learnings.md`** to ensure past mistakes are not repeated.

### Why This Matters

Your corrections teach the agent team what works and what doesn't in *this* codebase. By writing these lessons down, every future conversation (and every agent) can benefit from your guidance without you having to repeat yourself.

---

## General Working Principles

- **Completeness over partial fixes:** Deliver fully working solutions or iterate until they are.
- **Test before closing:** Verify changes work before marking a task complete.
- **Preserve context:** Remember learnings from this session across agent interactions.

## Verification Scripts

Prefer existing tests, tools, or simple commands for verification. Avoid complex inline scripts and dense command chains. When a one-off script is needed, write it as a clearly formatted temporary file in the session workspace, show the user its path and purpose, and ask for approval before running it. Remove the specific temporary file after execution, including on failure; do not make it self-delete. If the check is useful repeatedly, prefer a maintained project test or script instead.

## Code Quality

Define each class in its own predictably named file, including test classes; organize tests to mirror the classes they exercise.

After making code changes and before completing the task, invoke the `code-quality` skill to review the changed code and its relevant context. If the skill is not yet available to invoke, read and follow `.github/skills/code-quality/SKILL.md` instead. Address issues within the task's scope and run the relevant checks after any fixes.

## Commit Messages

- Write commit subjects in past tense, choosing a verb that accurately describes the change, such as `Fixed`, `Refactored`, `Updated`, or `Added` as appropriate. Do not default to `Added`.
- Do not add a Copilot authorship or co-authorship trailer.
