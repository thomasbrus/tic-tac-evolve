# Rails view composition guide

This guide records the implemented composition boundaries and examples for this repository. The concise standards are in the [frontend instructions](../../instructions/views.instructions.md); the examples below reflect the verified setup/history and play/layout slices.

## Choose the smallest useful boundary

| Need | Default |
| --- | --- |
| Assemble a page, select its sections, and wire Rails forms | Haml view |
| Extract feature markup or render repeated records | Haml partial with explicit locals |
| Format a display value or choose repeated presentation attributes | Feature-prefixed Rails helper |
| Reuse typography, control appearance, or other general UI semantics | Shared component |
| Encapsulate substantial, cohesive UI behavior or presentation state | Feature component, with a reason the simpler options are insufficient |

Reuse is one reason for a component, not the only one. A complex single-use interface may benefit from a tested class, but a one-line paragraph or ordinary section heading does not need a feature class merely for uniformity.

Keep database queries, game rules, and mutations outside rendering helpers and components. Declare strict locals at the top of every partial; avoid reaching into unrelated controller instance variables. The [view-linting initiative](../view-linting/README.md) owns the syntax conventions and lint setup.

## Share appearance, keep placement local

Shared components own their supported sizes, colors, weights, and semantics. A view owns where they sit: spacing, alignment, grids, and responsive page structure. Pass layout classes at the call site when the API allows it.

Use supported component variants to change appearance. Appending a conflicting background or font-size utility is not a stable variant API: class-string order does not reliably determine Tailwind's CSS precedence.

A genuinely custom feature element can use local Tailwind utilities and shared theme tokens. Extract it into a nearby partial if that helps. Add custom CSS only for a demonstrated need that utilities cannot express clearly; do not introduce a parallel BEM styling system as part of this initiative.

## Repository-specific examples

The setup/history and play/layout examples reflect the implemented direction. Translation moves must stay coordinated with their callers.

### A setup fragment built from shared primitives

Call from [the index view](../../../app/views/matches/index.html.haml):

```haml
= render('setup_heading')
```

`app/views/matches/_setup_heading.html.haml`:

```haml
-# locals: ()
%section.border-b.border-line.pt-6.pb-12
  = Eyebrow(text: t('.eyebrow'))
  = Typography(tag: :h1, size: :display, class: 'mt-3 mb-4') do
    = t('.heading')
```

The existing [Typography](../../../app/components/design_system/typography.rb) display size includes the responsive display font classes. The caller adds spacing, not competing typography rules. This replaces a feature wrapper without replacing the shared component mechanism.

Move the corresponding labels from `matches.index` to `matches.setup_heading`; do not assume relative lookup in the new partial still resolves the old keys.

### Rails collection rendering for history

```haml
%ul.my-3.list-none.p-0
  = render(partial: 'history_item', collection: @matches, as: :match)
```

The `_history_item.html.haml` partial starts with `-# locals: (match:)`. It uses Rails links, shared typography, and model display labels without needing its own component class.

Match-number formatting currently appears only in the play heading, so it stays in the view. If the formatting recurs, a small feature-prefixed `matches_number(match)` helper can format an already-loaded record. Keep it presentation-only; do not fetch records, calculate game outcomes, or change date and localization behavior as an incidental part of extraction.

### Shared typography in the play view and layout

Use the shared primitives for typography while leaving feature layout and link behavior in Rails:

```haml
= Eyebrow(text: t('.eyebrow', number: @match.id.to_s.rjust(3, '0')))
= Typography(tag: :h1, size: :display, class: 'mt-3 mb-4', role: 'status') do
  = @match.status_label
= Typography(size: :sm, color: :secondary) do
  = @match.mode_label
```

The application header follows the same boundary. The link owns navigation; `Typography` owns the wordmark's size and weight:

```haml
= link_to(root_path, class: 'wordmark no-underline') do
  = Typography(tag: :span, size: :lg, weight: :bold) do
    tic-tac-evolve
```

### Keep the board as a Rails partial

The play view passes the match explicitly:

```haml
= render('board', match: @match)
```

The [board partial](../../../app/views/matches/_board.html.haml) owns square rendering and its accessible labels, while Rails `button_to` continues to own move submission and parameters. Its board-specific labels live under `matches.board`; no board component is needed for this boundary.

### Preserve Rails form ownership

```haml
= form_with(model: @match, data: { controller: 'match-setup' }) do |form|
  = render('setup_fields', form: form, match: @match)
```

The setup-fields partial declares `-# locals: (form:, match:)` and keeps the existing submit helper and its markup contract, parameter names, selected values, and Stimulus hooks. Shared appearance is not a reason to hand-build Rails submission behavior.

## Extension and review rules

- Search the existing component library before adding a primitive.
- Extend an API only for a real supported variation needed by a migrated page. Keep Literal::Properties for typed shared component properties; avoid a new property DSL.
- Keep semantic tags, IDs, roles, and accessible labels explicit. Visual size must not dictate heading level.
- Do not add classes solely as test selectors. Prefer accessible labels and semantic selectors; use literal dashed `data-test-id` names when those are insufficient.
- Preserve complete conditional utility names so Tailwind can discover them.
- Test component appearance contracts separately from Rails request behavior, and cover the Haml-to-Kit boundary when using blocks or new APIs.
- Review the rendered structure as well as test results. Neither fewer files nor more components is the success metric.

## Controller assertions and data hooks

Controller tests inherit from `ControllerTest`, which keeps Rails integration requests and exposes each current response through `Capybara.string(response.body)`. Use accessible selectors for labeled controls, links, fieldsets, headings, alerts, and navigation.

For non-semantic elements, write a literal hook in the view:

```haml
= Typography(tag: :span, data: { test_id: 'edition' }) { 'CLASSIC / 01' }
```

Then assert the same name:

```ruby
assert_selector("[data-test-id='edition']", text: 'CLASSIC / 01')
```

Capybara is configured with `test_id = 'data-test-id'`, so supported built-in selectors can also locate controls through that attribute. Prefer the accessible label when one exists. Do not introduce `test_id`/`test_class` naming helpers or `data-test-class` attributes.

Repeated history items share `data-test-id="history-match"` for counting or scoping; record-specific accessible link names and URLs identify individual matches. Hooks do not change HTML IDs, presentation classes, or Stimulus attributes.

Use `visible: :all` for metadata and hidden input contracts. Parsed HTML does not execute JavaScript or apply stylesheet visibility rules. Keep appearance assertions in rendering/component tests rather than coupling controller tests to Tailwind classes.
