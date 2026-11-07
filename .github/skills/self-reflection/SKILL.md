---
name: self-reflection
description: "Record durable lessons from user corrections, preferences, or architectural rules. Use when the user flags a misunderstanding or requests reflection; do not log routine fixes or duplicate existing lessons."
user-invocable: true
---

# Self-Reflection Protocol

1. Acknowledge the correction or preference concisely. Decide whether it yields a durable, actionable lesson; ordinary scope changes, design iteration, and one-off fixes do not automatically qualify.
2. Check [project learnings](../../memory/learnings.md) for a matching entry. Update it rather than adding a duplicate; no edit is needed when it already captures the lesson.
3. Record qualifying lessons using the format below. Keep scenario and fix to one or two lines, and phrase the principle as an actionable instruction.
4. Current conventions belong in the relevant instruction file or owning skill. When explicitly asked to adopt a convention, update that authority as appropriate and keep rationale in memory; do not proliferate copies across skills. Reflection alone does not authorize unrelated code changes.

## Entry Format

```markdown
### [YYYY-MM-DD] <Short Summary Topic>
- **Scenario:** <What was delivered vs. what was requested>
- **The Fix:** <The specific correction provided by the user>
- **General Principle:** <The actionable rule takeaway to apply to future interactions>
```
