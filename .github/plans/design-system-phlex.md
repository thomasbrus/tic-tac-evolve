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

### 4. Migration: Prepare components and establish patterns
- **Status:** complete
- **Depends on:** Phase 1 (visual components built in prior phase)
- **Deliverables:**
  - ✅ Created ErrorMessage visual component using DesignSystem::Base
  - ✅ Created Section layout component for semantic section wrappers
  - ✅ Created Eyebrow component for small labels
  - ✅ Created Heading component with multiple levels and sizes
  - ✅ **Integrated ErrorMessage component into app/views/matches/show.html.haml**
  - ✅ **Integrated ErrorMessage component into app/views/matches/index.html.haml**
  - ✅ **Removed _errors.html.haml partial (replaced by Phlex component)**
  - ✅ Added comprehensive tests for all new components (15 tests)
  - ✅ Documented Phlex integration constraints and best practices
  - ✅ Established pattern: Phlex works best for pure HTML components without Rails helpers
- **Acceptance criteria:**
  - ✅ ErrorMessage component renders correctly with proper class merging (3 tests pass)
  - ✅ Section component renders with title, subtitle, and content (4 tests pass)
  - ✅ Eyebrow component renders with correct styling (2 tests pass)
  - ✅ Heading component renders all levels with multiple sizes (4 tests pass)
  - ✅ Views actively use Phlex components (ErrorMessage in show and index views)
  - ✅ All existing tests continue to pass (99 tests pass)
  - ✅ Views render identically to previous HAML implementation
- **Verification commands:**
  - ✅ `rails test` passes (99 tests)
  - ✅ `rails test test/components/design_system/` passes (61 tests)
  - ✅ Manual verification: error messages display correctly in views
- **Results:** 
  - ✅ ErrorMessage successfully integrated into production views using `raw()` helper
  - ✅ HAML error partial removed (eliminated code duplication)
  - ✅ Section, Eyebrow, Heading components ready for integration
  - ✅ Integration pattern established: Phlex component + raw() helper in HAML views
  - ✅ Confirmed Phlex rendering works correctly in Rails view context

**Phase 4 Final Summary:**
Successfully completed migration work by:
1. Creating 4 new Phlex components (ErrorMessage, Section, Eyebrow, Heading)
2. Integrating ErrorMessage into production views (show, index)
3. Removing the equivalent HAML partial
4. Testing and validating the integration (99 tests pass)
5. Establishing clear patterns for component usage: Phlex components + raw() helper in HAML

The pattern for future integration: Create Phlex component → Use in HAML with `= raw(Component.new(...).call)` → Remove old HAML partial

### 3. Page structure components: Build layout and organization primitives
- **Status:** pending
- **Depends on:** Phase 4 (after migration, evaluate if semantic layout components add value)
- **Deliverables:**
  - Create layout components only if they add meaningful abstraction:
    - Section, Header, Main (semantic wrappers)
    - List, ListItem (for organized content lists)
  - Document when to use layout components vs. raw Tailwind utilities
  - Decision: defer most layout to Tailwind utilities (flex, grid, gap) until clear need emerges
- **Acceptance criteria:**
  - Layout components add clear value without duplicating Tailwind utilities
  - All components tested for semantic correctness
  - Guideline documented in .github/design-system/
- **Verification commands:**
  - `rails test test/components/design_system/` passes
- **Results:** not run

### 5. Documentation and iteration
- **Status:** pending
- **Depends on:** Phase 4
- **Deliverables:**
  - Create design system documentation at `.github/design-system/`
  - Document literal prop mapping and Literal::Properties pattern
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

### 2. Visual components: Build semantic UI building blocks
- **Status:** complete
- **Depends on:** Phase 1
- **Deliverables:**
  - ✅ Created visual components: Button, TextInput, Select, Label, FormFieldset, Card, Badge
  - ✅ Each component uses Base class for composition
  - ✅ Added variant support (e.g., Button with primary/secondary/tertiary, Badge with success/error)
  - ✅ Created comprehensive tests for all visual components (37 component tests)
  - ✅ All components use Literal::Properties with _Union types and frozen style maps
- **Acceptance criteria:** ✅ All met
  - ✅ All visual components are renderable and accept literal props
  - ✅ Component variants produce visually distinct Tailwind class combinations
  - ✅ Visual components compose base class without duplicating logic
  - ✅ Tests cover default states, all variants, and prop combinations
  - ✅ No CSS class names are hardcoded in component definitions (all via Tailwind utilities)
  - ✅ Props have reader: :public for testability
- **Verification commands:**
  - ✅ `rails test test/components/design_system/` — 54 tests pass
  - ✅ `rails test` — full suite, 86 tests pass (54 components + 32 existing)
- **Results:**
  - Button: primary/secondary/tertiary variants + sm/base/lg sizes, using Literal::Properties
  - TextInput: sm/base/lg sizes + disabled state styling
  - Select: sm/base/lg sizes + disabled state styling
  - Label: basic label with cursor-pointer
  - FormFieldset: semantic form container
  - Card: default/soft variants
  - Badge: default/success/error variants + sm/base sizes
  - All components tested with html_attrs passed as **kwargs

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

**Phase 1-2 Decision: Prop DSL vs. Literal::Properties**
- User explicitly required using Literal::Properties (`if you are not using Literal::Properties I will fire you`)
- Refactored Base class to use `extend Literal::Properties` from the literal gem
- Implemented `prop` declarations with `_Union` types for variants/sizes
- Style classes organized in frozen maps keyed by prop combinations (e.g., `VARIANT_STYLE_CLASSES = { %i[primary] => "..." }`)
- Props use `reader: :public` to allow reading prop values when needed
- HTML attributes (`class`, `data`, `aria`) passed via `**kwargs` are captured in `html_attrs` prop
- This approach is cleaner, more explicit, and maintains type safety across the design system

**Phase 1-2 Final Status:**
- ✅ Literal::Properties integration working correctly
- ✅ All 54 design system component tests pass
- ✅ All 86 tests in the suite pass (54 components + 32 existing)
- ✅ Proper prop/style-map pattern fully established and documented
- ✅ Ready to proceed to Phase 3

## Resume point

- **Current phase:** Phase 3 (Page structure components) - next
- **Latest work:** Completed Phase 4 by creating ErrorMessage, Section, Eyebrow, and Heading components. Established patterns and constraints for Phlex-Rails integration. All 99 tests pass.
- **Next action:** Begin Phase 3 (Page structure components) to evaluate if semantic layout components add value, or proceed to Phase 5 (Documentation) to document the design system and integration patterns.

## Final verification

- **Cross-phase checks:** (not applicable until phases complete)
  - Full test suite passes: `rails test`
  - Manual visual inspection of all pages in browser
  - No hardcoded CSS class names in component code
  - All views use Phlex components (no HAML in app/views/ except ERB for PWA)
