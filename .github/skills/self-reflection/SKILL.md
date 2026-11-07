---
name: self-reflection
description: Logs corrections, user preferences, and architectural rules to project memory when the user points out a mistake or bad assumption.
applyTo: 
  - "**"
---

# Self-Reflection Protocol

When triggered by a user correction or explicit preference update, consider whether it reveals a durable, actionable lesson useful beyond the immediate task. Record qualifying lessons in `.github/memory/learnings.md`; do not log routine, one-off bug fixes without a generalizable takeaway.

## Entry Format

Append the following Markdown block to `.github/memory/learnings.md` under the "Entries" section:

```markdown
### [YYYY-MM-DD] <Short Summary Topic>
- **Scenario:** <What was delivered vs. what was requested>
- **The Fix:** <The specific correction provided by the user>
- **General Principle:** <The actionable rule takeaway to apply to future interactions>
```

## Operational Rules

1. **Be Concise:** Keep the scenario and fix to 1–2 lines maximum.
2. **Make Principles Actionable:** The "General Principle" must be phrased as an imperative rule for an AI agent, e.g.:
   - ✅ "Always use X over Y when building Z"
   - ✅ "Never place domain state inside controller actions"
   - ✅ "Prioritize security over convenience in authentication flows"
3. **Generalize Carefully:** Record only lessons that will help with future work; do not turn every bug report into a project rule.
4. **No Duplicate Rules:** If a similar principle already exists in `learnings.md`, update the existing entry rather than adding a duplicate.
5. **Timestamp Format:** Use ISO 8601 date format `[YYYY-MM-DD]` to match the file's consistency.

## When to Trigger

Execute this protocol when:
- ✅ User explicitly says "No, that's wrong" or provides a correction
- ✅ User clarifies a misunderstood preference or requirement
- ✅ User reveals a bug or issue that exposes a generalizable lesson
- ✅ User shares a domain-specific rule or convention specific to this project

Do **not** trigger when:
- ❌ User is just asking a follow-up question
- ❌ User is refining scope (add to context, but don't log unless it contradicts a past entry)
- ❌ User is iterating on design (normal development flow)

## Integration with Instructions

The `.github/copilot-instructions.md` file instructs agents to use this skill whenever corrected. This ensures:
- No manual invocation needed by the user
- Automatic persistence across sessions
- Consistent format across all learnings
