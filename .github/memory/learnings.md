# Agent Learnings & Project Memory

*This file is automatically updated by the AI agent when corrections are made. It serves as a persistent knowledge base across all sessions and agent interactions.*

---

## Format

Each entry uses this structure:

```markdown
### [YYYY-MM-DD] <Topic>
- **Scenario:** What was delivered vs. what was requested
- **The Fix:** The specific correction provided by the user
- **General Principle:** The actionable rule for future interactions
```

---

## Entries

### [2026-11-07] Commit message preferences
- **Scenario:** Commit subjects repeatedly used `Added`, though the user gave it only as a past-tense example.
- **The Fix:** Choose a past-tense verb appropriate to each change and omit Copilot authorship or co-authorship trailers.
- **General Principle:** Write commit subjects with accurate past-tense verbs rather than defaulting to `Added`; do not add a Copilot authorship or co-authorship trailer.

### [2026-11-07] Code quality and method responsibilities
- **Scenario:** The game loop mixed interaction, move validation, and outcome handling, obscuring its intent.
- **The Fix:** Review changed code for mixed responsibilities and distracting implementation details, not just method length.
- **General Principle:** Keep orchestration readable at a consistent level of abstraction; separate meaningful responsibilities without applying arbitrary line-count limits or unnecessary extractions.

### [2026-11-07] Class file organization
- **Scenario:** The board and game classes shared a file, and their tests were grouped together.
- **The Fix:** Separate classes and their tests into predictably named files.
- **General Principle:** Define each class in its own file and organize test classes to mirror the classes they exercise, making both easy to locate.
