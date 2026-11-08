# 2026-11-08 Components Kit and compatible Rails adapter

- **Status:** accepted
- **Context:** The initial Kit spike resolved the method in Haml but phlex-rails 0.1.0 failed to render the component.
- **Options considered:**
  - Retain separate top-level namespaces.
  - Adopt the previous project's `Components` root Kit with collapsed grouping directories.
  - Migrate Haml views to Phlex or add custom rendering helpers.
- **Decision:** Use the `Components` root Kit, collapse immediate grouping directories, and include it in `ApplicationHelper`. Retain Haml and Phlex 1.x; upgrade phlex-rails to 1.2.2.
- **Rationale:** The user explicitly approved the namespace structure and separately approved the adapter upgrade. Published adapter metadata declares compatibility with Phlex 1.x and Rails 8.1; application tests confirm actual rendering.
- **Consequences:** Component classes and test references use `Components`; folders organize files without adding namespace levels. Haml renders components through capitalized Kit calls, with empty parentheses for no-argument calls. No custom rendering bridge or UI migration is needed.
- **Related experiments and evidence:** [Implementation and verification](../experiments/2026-11-08-components-integration.md); [failed spike](../experiments/2026-11-08-haml-kit-spike.md).
- **Supersedes:** No accepted decision; qualifies the preliminary documentation interpretation.
