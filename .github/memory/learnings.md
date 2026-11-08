# Agent Learnings & Project Memory

*This file is automatically updated by the AI agent when corrections are made. It serves as a persistent knowledge base across all sessions and agent interactions.*

These entries preserve historical rationale. Current standards live in the [main instructions](../copilot-instructions.md), [Rails conventions](../instructions/rails.instructions.md), [frontend conventions](../instructions/views.instructions.md), and owning skills; maintain those authorities rather than copying rules into additional workflows.

**Every learning recorded here has a corresponding artifact** (skill, instruction file, or instruction section). This ensures that durable lessons are actionable and discoverable by agents and future sessions. See the [self-reflection skill](../skills/self-reflection/SKILL.md) for the workflow.

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

### [2026-11-08] Avoid test-only markup classes
- **Scenario:** The history list used a CSS class only as a request-test selector.
- **The Fix:** Removed the class and updated tests to assert semantic structure and rendered text; added the rule to the [view composition guide](../initiatives/rails-view-composition/composition-guide.md).
- **General Principle:** Do not add or preserve non-styling classes solely as test selectors; test semantic structure and user-visible content instead.

### [2026-11-08] Lightweight commit workflow
- **Scenario:** The commit skill encouraged exhaustive diff review, elaborate splitting, and per-commit verification for large changes.
- **The Fix:** Updated the [commit skill](../skills/commit/SKILL.md) to start with file summaries, default to one commit, and reuse unchanged verification results.
- **General Principle:** Keep commit preparation summary-first; inspect targeted details only for concrete scope or risk questions, not merely because many files changed.

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

### [2026-11-07] Terminal application testing
- **Scenario:** CLI interaction was verified with complex, one-off Python pseudo-terminal commands.
- **The Fix:** Create repeatable Ruby system tests for the terminal application instead.
- **General Principle:** Prefer maintainable, reusable Ruby system tests for CLI interactions over ad hoc pseudo-terminal scripts.

### [2026-11-07] Reviewable verification scripts
- **Scenario:** A complex inline Ruby validation command was difficult for the user to review.
- **The Fix:** Use a formatted temporary script, allow review and request approval before running it, then explicitly remove it.
- **General Principle:** Prefer existing tests or simple commands; do not run inline custom verification scripts. Put necessary one-off scripts in readable temporary files, obtain approval before execution, and explicitly remove them afterward, including on failure.

### [2026-11-07] Generalizable learnings
- **Scenario:** A one-off terminal interruption bug was recorded as a project learning.
- **The Fix:** Record durable lessons useful for future work, not routine bug fixes without a generalizable takeaway.
- **General Principle:** Evaluate whether a correction yields a reusable, actionable lesson before adding it to project memory.

### [2026-11-07] Rails frontend stack
- **Scenario:** The Rails migration used ERB views and handwritten match CSS before the user specified the preferred frontend stack.
- **The Fix:** Use Haml and Tailwind CSS 4 when migration work resumes.
- **General Principle:** Use Haml for this project's Rails application views and Tailwind CSS 4 for styling; preserve these choices in subsequent frontend work.

### [2026-11-07] Proportionate workflow overhead
- **Scenario:** A modest migration accumulated repeated context reads, oversized generated diffs, verification ceremony, and frontend rework; the user flagged excessive elapsed time.
- **The Fix:** Keep investigation and bookkeeping proportional to the change, clarify consequential stack choices early, and reuse verified context.
- **General Principle:** Run focused checks after meaningful edits and required final gates; avoid redundant checks without new risk. Review diffs in bounded sections, batch independent operations, and update plans at phase boundaries or material changes rather than every microstep.

### [2026-11-07] Preserve intentional design decisions during migrations
- **Scenario:** During CLI-to-Rails migration, the default game mode changed from "Play against the computer" (user's first choice) to "Two players" (database default). The user's earlier deliberate design decision was not carried forward into the new technology stack.
- **The Fix:** Explicitly verify design decisions and defaults from the source system before implementing them in the target system; document which decisions are deliberate vs. accidental.
- **General Principle:** When migrating between technologies or architectures, treat intentional design decisions as a checklist item. Cross-reference the original system's documented choices (or meeting notes) against the new implementation, and confirm that no deliberate behavior is being lost to framework defaults or shortcuts.

### [2026-11-07] Relative Rails view translations
- **Scenario:** Match views used absolute translation keys for page-specific labels and left some accessible text hardcoded.
- **The Fix:** Use relative view lookups and scope locale entries to their template; retain absolute keys for shared and model translations.
- **General Principle:** Prefer `t(".key")` for view- and partial-specific text, with locale keys matching the template path. Use absolute keys for genuinely shared translations, and translate complete accessible labels with interpolation rather than concatenating localized fragments.

### [2026-11-07] Natural writing over AI mannerisms
- **Scenario:** Documentation and explanations used dense paragraphs, excessive semicolons and colons, and over-explained obvious details. The tone felt formal and artificial.
- **The Fix:** Write naturally with paragraph breaks, avoid formal punctuation patterns, trust the reader's intelligence, and omit self-evident details.
- **General Principle:** Use clear, natural prose. Break text into readable chunks. Avoid redundant semicolons, double colons, and explanations of the obvious. Trust the reader to understand context and implications without spelling them out.

### [2026-11-07] Use external libraries as documented, not custom replacements
- **Scenario:** User requested a design system using Literal::Properties for type-safe component props. I built a custom `prop` DSL instead of using the literal gem directly. User responded with: "if you are not using Literal::Properties I will fire you."
- **The Fix:** Fetched the documentation from literal.fun/docs/properties, used `extend Literal::Properties` with `_Union` types and frozen style maps, and implemented `prop :html_attrs, _Hash(...), :**, default: -> { {} }, reader: :public` to capture kwargs. All 86 tests passed with the correct implementation.
- **General Principle:** When a user explicitly names an external tool or library, fetch its documentation immediately before implementation. Use the tool exactly as designed rather than building a custom replacement. Trust explicit requirements ("use X") over assumptions; simple, correct use of existing tools beats elaborate custom implementations.
