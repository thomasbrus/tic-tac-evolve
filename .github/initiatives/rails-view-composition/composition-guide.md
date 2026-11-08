# Proposed view composition guide

This is original guidance for this repository, informed by the user's internal guide. It is a proposal for the initiative, not yet a replacement for the [frontend instructions](../../instructions/views.instructions.md).

## Choose the smallest useful boundary

| Need | Default |
| --- | --- |
| Assemble a page, select its sections, and wire Rails forms | Haml view |
| Extract feature markup or render repeated records | Haml partial with explicit locals |
| Format a display value or choose repeated presentation attributes | Feature-prefixed Rails helper |
| Reuse typography, control appearance, or other general UI semantics | Shared component |
| Encapsulate substantial, cohesive UI behavior or presentation state | Feature component, with a reason the simpler options are insufficient |

Reuse is one reason for a component, not the only one. A complex single-use interface may benefit from a tested class, but a one-line paragraph or ordinary section heading does not need a feature class merely for uniformity.

Keep database queries, game rules, and mutations outside rendering helpers and components. Partial locals describe a fragment's inputs; avoid reaching into unrelated controller instance variables. Consider strict locals when extracting partials, and verify their syntax with the installed Haml handler.

## Share appearance, keep placement local

Shared components own their supported sizes, colors, weights, and semantics. A view owns where they sit: spacing, alignment, grids, and responsive page structure. Pass layout classes at the call site when the API allows it.

Use supported component variants to change appearance. Appending a conflicting background or font-size utility is not a stable variant API: class-string order does not reliably determine Tailwind's CSS precedence.

A genuinely custom feature element can use local Tailwind utilities and shared theme tokens. Extract it into a nearby partial if that helps. Add custom CSS only for a demonstrated need that utilities cannot express clearly; do not introduce a parallel BEM styling system as part of this initiative.

## Repository-specific examples

These examples illustrate the proposed direction. They have been checked against current component signatures, but have not been rendered or installed. Translation moves shown below must be implemented together with their callers.

### A setup fragment built from shared primitives

Proposed call from [the index view](../../../app/views/matches/index.html.haml):

```haml
= render "setup_heading"
```

Proposed `app/views/matches/_setup_heading.html.haml`:

```haml
%section{class: "border-b border-line pt-6 pb-12"}
  = Eyebrow(text: t(".eyebrow"))
  = Typography(tag: :h1, size: :display, class: "mt-3 mb-4") do
    = t(".heading")
```

The existing [Typography](../../../app/components/design_system/typography.rb) display size includes the responsive display font classes. The caller adds spacing, not competing typography rules. This replaces a feature wrapper without replacing the shared component mechanism.

Move the corresponding labels from `matches.index` to `matches.setup_heading`; do not assume relative lookup in the new partial still resolves the old keys.

### Rails collection rendering for history

```haml
%ul.history-list{class: "my-3 list-none p-0"}
  = render partial: "history_item", collection: @matches, as: :match
```

The proposed `_history_item.html.haml` receives `match` explicitly. It can use `link_to`, `time_tag`, shared typography, and model display labels without needing its own component class.

If match-number formatting is extracted, a small `matches_number(match)` helper is enough:

```ruby
module MatchesHelper
  def matches_number(match)
    "##{match.id.to_s.rjust(3, '0')}"
  end
end
```

This formats an already-loaded record. It must not fetch records or calculate game outcomes. Do not change date formatting or localization behavior as an incidental part of extraction.

### Preserve Rails form ownership

```haml
= form_with model: @match, data: { controller: "match-setup" } do |form|
  = render "setup_fields", form: form, match: @match
  = form.submit t(".start_button"), class: "primary-button cursor-pointer rounded border-0 bg-ink px-6 py-3.5 text-white hover:bg-green"
```

Keeping the existing submit helper initially preserves its current markup contract. The eventual shared-control integration must retain parameter names, selected values, error state, and Stimulus hooks. Shared appearance is not a reason to hand-build Rails submission behavior.

## Extension and review rules

- Search the existing component library before adding a primitive.
- Extend an API only for a real supported variation needed by a migrated page. Keep Literal::Properties for typed shared component properties; avoid a new property DSL.
- Keep semantic tags, IDs, roles, and accessible labels explicit. Visual size must not dictate heading level.
- Preserve complete conditional utility names so Tailwind can discover them.
- Test component appearance contracts separately from Rails request behavior, and cover the Haml-to-Kit boundary when using blocks or new APIs.
- Review the rendered structure as well as test results. Neither fewer files nor more components is the success metric.
