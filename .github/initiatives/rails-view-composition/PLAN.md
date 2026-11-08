# Plan

## Outcome and approval

Use Rails-native feature composition and shared UI primitives without changing match behavior or redesigning the interface.

- **Status:** proposed.
- **Approved scope:** Creating the initiative, investigating the baseline, and writing original guidance.
- **Implementation scope and phase sequence:** Awaiting approval.
- **Execution policy after approval:** Continue through the approved phases; pause for material scope or behavior changes.

## Workstreams

### Feature composition

- Objective: Keep page orchestration in Haml and ordinary fragments in partials with explicit locals; use narrowly scoped helpers for presentation calculations.
- Status: proposed.
- Depends on: direction approval.
- Deliverables: [Feature composition workstream](workstreams/feature-composition.md).
- Risks: relative translation paths, form-builder boundaries, changed DOM hooks, and unnecessary fragmentation.

### Shared UI and contributor guidance

- Objective: Reuse typography and recurring UI components with clear ownership of appearance, semantics, and layout.
- Status: proposed.
- Depends on: direction approval; actual API needs discovered in each feature slice.
- Deliverables: [Shared UI workstream](workstreams/shared-ui.md).
- Risks: class conflicts, heading semantics, changed form behavior, and overgeneralized component APIs.

## Phases

### 1. Setup and history form a Rails-native slice

- Status: pending.
- Depends on: approval.
- Deliverables:
  - Run focused baseline tests and fill coverage gaps for empty history, pagination boundaries, defaults, and invalid setup rendering.
  - Replace simple setup/history wrappers with Haml partials where useful. Use collection rendering for history items and explicit locals for match/page/form inputs.
  - Reuse existing shared typography. Add only component API changes needed by this slice.
  - Move presentation formatting to feature-prefixed helpers only where it improves clarity or removes meaningful duplication.
  - Move partial-specific translations with the markup and check all consumers.
  - Replace the helper test tied to `MatchSetupSection` with coverage of a retained general Kit primitive before removing that class.
- Acceptance criteria: Empty, active, completed, and paginated history render correctly; setup defaults and failed submissions are unchanged; the page reads as Rails composition using shared UI.
- Checks: `bin/rails test test/controllers/matches_controller_test.rb test/helpers`; relevant changed component tests; `bin/rails tailwindcss:build`; `bin/rails zeitwerk:check` after component removal or relocation.
- Results: not run.

### 2. Play view and layout use the same boundaries

- Status: pending.
- Depends on: phase 1.
- Deliverables:
  - Apply the established pattern to match headings, metadata, and layout typography.
  - Extract board markup only if it creates a useful boundary. Start with a partial; retain or introduce a feature component only for demonstrated complexity.
  - Keep Rails form helpers responsible for submission wiring. Do not substitute a bare component button for `button_to` forms.
- Acceptance criteria: Nine squares render with the same move availability, labels, submitted position/revision, and state styling. Completed games and invalid/stale submissions retain their behavior and feedback.
- Checks: `bin/rails test test/controllers/matches_controller_test.rb test/helpers`; relevant changed component tests; `bin/rails tailwindcss:build`.
- Results: not run.

### 3. Consolidate and verify the outcome

- Status: pending.
- Depends on: phase 2.
- Deliverables:
  - Remove superseded wrappers and styling duplication within the migrated scope.
  - Promote approved, implementation-backed guidance into the owning frontend instructions and directly related documentation. Keep this initiative's examples aligned with the final APIs.
  - Perform the repository code-quality and writing reviews.
- Acceptance criteria: Each retained feature component has a concrete reason; no obsolete helper/component references or missing translations remain; the documented architecture matches working code.
- Checks: `bin/rails test test`; `bin/rails tailwindcss:build`; `bin/rails zeitwerk:check`; scoped whitespace/link review.
- Browser checks: Ask for scenarios before running any. If deferred, record visual parity as unverified rather than passed.
- Results: not run.

## Cross-workstream dependencies

Both workstreams contribute to each vertical slice. Do not rebuild the component library before testing its use in a real page. Contributor guidance is finalized only after the migrated slices validate it.

## Migration and recovery

No database or dependency migration is planned. Keep each slice independently reviewable, preserve the existing Kit setup, and remove a feature wrapper only after its callers and tests have replacements. Recovery is a targeted reversal of the affected slice, not a database reset or reversal of the completed Phlex integration.

## Outcome verification

- Baseline: [Source investigation](history/experiments/2026-11-08-view-construction-baseline.md); runtime checks still pending.
- Quality gates: focused request/helper/component coverage per slice, Tailwind rebuilds, autoload checks, and code-quality review.
- Desired outcome: inspect migrated templates against the success criteria, alongside test evidence. Passing tests alone does not establish good composition or visual parity.

## Next planning checkpoint

Review direction before phase 1. Revisit shared UI APIs after the first slice exposes concrete gaps; ask again if an extension changes appearance, behavior, or the agreed architecture.
