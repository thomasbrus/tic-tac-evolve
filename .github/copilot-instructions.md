# Copilot Instructions for Genesis

## Self-Correction & Learning Loop

Whenever the user explicitly corrects your output, flags a misunderstanding, or refines a preference:

1. **Acknowledge the correction concisely** — thank the user and confirm what you understood.
2. **Execute a Self-Reflection step** — use the self-reflection skill to log the lesson.
3. **Append to project memory** — write to `.github/memory/learnings.md` before finalizing your response.

At the start of complex tasks, **review `.github/memory/learnings.md`** to ensure past mistakes are not repeated.

### Why This Matters

Your corrections teach the agent team what works and what doesn't in *this* codebase. By writing these lessons down, every future conversation (and every agent) can benefit from your guidance without you having to repeat yourself.

---

## General Working Principles

- **Completeness over partial fixes:** Deliver fully working solutions or iterate until they are.
- **Test before closing:** Verify changes work before marking a task complete.
- **Preserve context:** Remember learnings from this session across agent interactions.
