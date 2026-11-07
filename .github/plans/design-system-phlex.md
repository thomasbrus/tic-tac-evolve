# Design System with Phlex and Literal Props

## Outcome and scope

- **Outcome:** Build a composable design system using Phlex components with literal props, eliminating CSS class-based naming conventions and establishing a single source of truth for visual patterns.
- **Preserve:** All existing functionality and accessibility features (ARIA labels, semantic HTML, color schemes, responsive behavior). Maintain the current visual design.
- **Excluded:** Redesigning the UI or changing visual appearance beyond refactoring for composition. Layout utilities stay in Tailwind classes initially.
- **Constraints:** Components must work with Rails 8.1.4+, use Tailwind CSS 4 for styling, and maintain zero runtime overhead compared to rendered HAML. Focus on visual components; leverage Tailwind utilities (flex, grid, gap, etc) for layout.

## Approval

- **Status:** approved
- **Approved scope and phase sequence:** Start with visual components (Button, Input, Select, Badge), keep layout as Tailwind utilities initially. Migrate views to use visual components. Add layout components later if needed. Use `.github` folder for iteration and docs, not `app/components/DESIGN_SYSTEM.md`.
- **Execution policy:** continue through approved phases without routine approval pauses

## Phases

### 1. Foundation: Phlex setup and core visual component patterns
- **Status:** complete
- **Depends on:** none
- **Deliverables:**
  - ✅ Added phlex and phlex-rails gems, ran bundle install
  - ✅ Created component directory structure: `app/components/design_system/`
  - ✅ Built foundational base components (View, Container, Typography)
  - ✅ Documented the component API pattern in `.github/design-system/README.md`
  - ✅ Created comprehensive tests for base components
- **Acceptance criteria:** ✅ All met
  - ✅ Phlex gems installed, Rails recognizes components
  - ✅ All base components render to expected HTML/Tailwind classes
  - ✅ Literal props (e.g., `gap: 2`, `items: :center`) map correctly to Tailwind utilities
  - ✅ Components render without warnings or errors
  - ✅ 24 component tests pass
- **Verification commands:**
  - ✅ `bundle install` succeeded
  - ✅ `rails runner "DesignSystem::Container.new.render"` produces valid HTML
  - ✅ `rails test test/components/design_system/` — all 24 tests pass
  - ✅ `rails test` — full suite, 56 tests pass (existing tests not broken)
- **Results:** 
  - View base class with literal-to-Tailwind conversion logic working correctly
  - Container component with default max-width constraint
  - Typography component with size, weight, color variants
  - Component API pattern established and documented
  - Test infrastructure in place

### 2. Visual components: Build semantic UI building blocks
- **Status:** pending
- **Depends on:** Phase 1
- **Deliverables:**
  - Create visual components: Button, TextInput, Select, Label, FormFieldset, Card, Badge
  - Each component uses base components for composition and accepts literal props for customization
  - Add variant support (e.g., Button with `variant: :primary`, `size: :sm`)
  - Create comprehensive tests for all visual components
- **Acceptance criteria:**
  - All visual components are renderable and accept literal props
  - Component variants produce visually distinct Tailwind class combinations
  - Visual components compose base components without inheriting from them
  - Tests cover default states, all variants, and prop combinations
  - No CSS class names are hardcoded in component definitions (all via Tailwind utilities)
- **Verification commands:**
  - `rails test test/components/design_system/` passes for all visual components
  - Manual render verification: `rails runner "DesignSystem::Button.new(variant: :primary).render"`
- **Results:** not run

### 3. Page structure components: Build layout and organization primitives
- **Status:** pending
- **Depends on:** Phase 2
- **Deliverables:**
  - Create layout components: Section, Header, Main, Fieldset, List, ListItem (only if compelling composition benefit)
  - Create responsive wrapper components with breakpoint-aware props if needed
  - Document composition patterns for common layouts using visual components + Tailwind utilities
- **Acceptance criteria:**
  - Layout components add meaningful abstraction without duplicating Tailwind utilities
  - All components compose smaller primitives
  - Tests demonstrate responsive behavior and semantic correctness
  - Guideline documented: when to use layout components vs. raw Tailwind
- **Verification commands:**
  - `rails test test/components/design_system/` passes for all components
  - Manual inspection confirms semantic tags and Tailwind classes
- **Results:** not run

### 4. Migration: Refactor views to use visual components
- **Status:** pending
- **Depends on:** Phase 3
- **Deliverables:**
  - Refactor `app/views/layouts/application.html.haml` to use Phlex, keeping layout as Tailwind utilities
  - Create match-specific domain components: MatchHeading, MatchBoard, MatchMeta, GameCell using visual components
  - Refactor `app/views/matches/show.html.haml` to use domain and visual components
  - Refactor `app/views/matches/index.html.haml` to use visual components
  - Remove HAML partial for errors, replace with Phlex ErrorMessage visual component
  - Update controllers if needed to pass data in new formats
- **Acceptance criteria:**
  - All views render identically to their HAML counterparts (visual pixel parity)
  - No `.html.haml` files remain in app/views (except for non-component partials if any)
  - All tests pass without modification
  - ARIA labels and accessibility features are preserved
  - No CSS class selectors from old design in component code
- **Verification commands:**
  - `rails test` passes (full test suite)
  - Visual regression: start server and manually verify pages render correctly
  - Browser DevTools inspection: verify ARIA labels, semantic HTML, and Tailwind classes match old version
  - `grep -r "match-heading\|match-meta\|match-setup" app/` returns no results (CSS class names removed)
- **Results:** not run

### 5. Documentation and iteration
- **Status:** pending
- **Depends on:** Phase 4
- **Deliverables:**
  - Create design system documentation at `.github/design-system/`
  - Document literal prop mapping (e.g., `gap: 2` → `gap-2` Tailwind class)
  - Add usage examples for common patterns (forms, cards, buttons)
  - Document decision: when to use visual components vs. layout utilities
  - Update learnings if new patterns emerge
- **Acceptance criteria:**
  - Documentation is clear and accurate in `.github` folder
  - Examples are tested and working
  - Future developers can easily find and use components
- **Verification commands:**
  - Documentation examples are manually verified to render correctly
- **Results:** not run

## Migration and recovery

**Compatibility & Deployment:**
- This is a frontend refactoring with zero impact on backend logic, database, or API contracts.
- Phlex components are rendered server-side and output the same HTML as HAML, so browsers see no difference.
- No data migration or deployment order complexity.
- **Rollback:** If needed, revert the commit to restore HAML views. No destructive operations.

**Data Safety:**
- No data changes. All changes are to view layer only.
- Tests confirm rendering output remains identical.

## Decisions and blockers

**Phase 1 Decision: Component Namespace**
- Used `DesignSystem::` module namespace for components
- Keeps design system clearly separate from domain logic
- Easy to identify and audit all design-system-specific code

**Phase 1 Decision: Literal Prop Implementation**
- Implemented pattern-based detection of Tailwind utilities vs. HTML attributes
- Allows any Tailwind utility to be used without explicit allowlisting
- `data`, `aria`, `class` are special-cased for correct merging behavior
- Simple, extensible approach that works for current and future utilities

## Resume point

- **Next action:** Begin Phase 2 - build visual/semantic components (Button, TextInput, Select, Label, FormFieldset, Card, Badge) using the foundation from Phase 1.

## Final verification

- **Cross-phase checks:** (not applicable until phases complete)
  - Full test suite passes: `rails test`
  - Manual visual inspection of all pages in browser
  - No hardcoded CSS class names in component code
  - All views use Phlex components (no HAML in app/views/ except ERB for PWA)
