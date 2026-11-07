# Design System with Phlex & Literal Props

This directory contains documentation for the tic-tac-evolve design system. The system is built using [Phlex](https://www.phlex.fun/) components with literal props that map directly to Tailwind CSS utilities.

## Core Concept

Components accept "literal props" — Ruby symbol and value pairs that translate to Tailwind CSS class names:

```ruby
DesignSystem::View.new(
  gap: 2,              # → gap-2
  items: :center,      # → items-center  
  p: 4,                # → p-4
  class: "custom"      # → custom (merged)
)
```

Literal props reduce boilerplate and make styling intent clear without CSS class strings polluting the component code.

## Component Hierarchy

```
View (base)
├── Container
├── Typography
├── Button (variants: primary, secondary, tertiary; sizes: sm, base, lg)
├── TextInput (sizes: sm, base, lg)
├── Select (sizes: sm, base, lg)
├── Label
├── FormFieldset
├── Card (variants: default, soft)
└── Badge (variants: default, success, error; sizes: sm, base)
```

## Visual Components

### Button

Button with variant and size support.

**Variants:** `:primary` (default), `:secondary`, `:tertiary`
**Sizes:** `:sm`, `:base` (default), `:lg`

```ruby
DesignSystem::Button.new(variant: :primary, size: :base) { "Click me" }
DesignSystem::Button.new(variant: :secondary) { "Secondary" }
```

### TextInput

Text input field with size variants and disabled state styling.

**Sizes:** `:sm`, `:base` (default), `:lg`

```ruby
DesignSystem::TextInput.new(type: "email", placeholder: "Enter email")
DesignSystem::TextInput.new(size: :lg, disabled: true)
```

### Select

Select dropdown with size variants.

**Sizes:** `:sm`, `:base` (default), `:lg`

```ruby
DesignSystem::Select.new(size: :sm) do
  # option elements
end
```

### Label

Basic label element with cursor-pointer styling.

```ruby
DesignSystem::Label.new(for: "input-id") { "Label text" }
```

### FormFieldset

Semantic fieldset wrapper for form groups (removes border and padding).

```ruby
DesignSystem::FormFieldset.new(flex: true, flex_col: true, gap: 4) do
  # form inputs and labels
end
```

### Card

Card container with variant support.

**Variants:** `:default` (white with border), `:soft` (soft green background)

```ruby
DesignSystem::Card.new(variant: :default) { "Card content" }
DesignSystem::Card.new(variant: :soft, p: 6) { "Soft card" }
```

### Badge

Badge component with variant and size support.

**Variants:** `:default`, `:success`, `:error`
**Sizes:** `:sm`, `:base` (default)

```ruby
DesignSystem::Badge.new(variant: :success) { "Active" }
DesignSystem::Badge.new(variant: :error, size: :sm) { "Error" }
```

## Base Components

### View

The foundation for all components. Handles literal prop-to-Tailwind conversion.

**Literal Prop Categories:**
- **Spacing:** `p`, `px`, `py`, `pt`, `pb`, `pl`, `pr`, `m`, `mx`, `my`, `mt`, `mb`, `ml`, `mr`
- **Flexbox:** `flex`, `flex_col`, `flex_row`, `flex_wrap`, `items`, `justify`, `content`
- **Grid:** `grid`, `grid_cols`, `grid_rows`
- **Gap:** `gap`, `gap_x`, `gap_y`
- **Typography:** `text`, `font`, `color`
- **Layout:** `w`, `h`, `max_w`, `max_h`, `min_w`, `min_h`, `overflow`
- **Styling:** `bg`, `border`, `rounded`, `shadow`, `opacity`, `cursor`

**HTML Attributes:**
- `data: {}` — data attributes
- `aria: {}` — ARIA attributes
- `class: "string"` — merged with generated Tailwind classes
- Any other standard HTML attribute

**Examples:**

```ruby
# Basic flex container
DesignSystem::View.new(flex: true, gap: 4, p: 6)

# Responsive spacing
DesignSystem::View.new(p: { base: 2, sm: 4, lg: 6 })

# With HTML attributes
DesignSystem::View.new(
  flex: true,
  data: { controller: "slideshow" },
  aria: { label: "Gallery" }
)
```

### Container

Centered container with max-width. Defaults to `max-w-[1040px]`.

```ruby
DesignSystem::Container.new(max_width: "max-w-2xl") { "Content" }
```

### Typography

Text component with size, weight, and color variants.

**Sizes:** `:xs`, `:sm`, `:base`, `:lg`, `:xl`, `:"2xl"`, `:"3xl"`, `:display`
**Weights:** `:normal`, `:medium`, `:semibold`, `:bold`
**Colors:** `:default`, `:secondary`, `:subtle`, `:error`

```ruby
DesignSystem::Typography.new(
  tag: :h1,
  size: :display,
  weight: :bold,
  color: :default
) { "Heading" }

DesignSystem::Typography.new(size: :sm, color: :subtle) { "Meta text" }
```



**Prefer literal props when:**
- Composing components for semantic meaning
- You want to change styling in one place (the component)
- Props are reused across multiple instances

**Use Tailwind utilities directly when:**
- Building one-off layouts with `flex`, `grid`, `gap`, etc.
- The styling is temporary or page-specific
- Mixing with existing Tailwind in HAML/HTML

## Layout Strategy

For now, **use Tailwind utility classes for layout** (flexbox, grid, gap, positioning). Literal props focus on visual components (Button, Input, Card).

Once the visual component library stabilizes, we can introduce semantic layout components if beneficial.

## File Structure

```
app/components/design_system/
├── view.rb              # Base class with literal prop conversion
├── container.rb         # Centered max-width wrapper
├── typography.rb        # Text & heading styles
├── button.rb            # Primary, secondary, tertiary variants
├── text_input.rb        # Text input field
├── select.rb            # Select dropdown
├── label.rb             # Label element
├── form_fieldset.rb     # Fieldset container
├── card.rb              # Card variants
└── badge.rb             # Badge with status variants

test/components/design_system/
├── view_test.rb
├── container_test.rb
├── typography_test.rb
├── button_test.rb
├── text_input_test.rb
├── select_test.rb
├── label_test.rb
├── form_fieldset_test.rb
├── card_test.rb
└── badge_test.rb
```

## Testing

Components are tested for:
1. Correct HTML output and tag rendering
2. Literal props translate to Tailwind classes
3. HTML attributes (data, aria) pass through correctly
4. Block content is yielded properly
5. Variants produce distinct class combinations

Run tests:
```bash
rails test test/components/design_system/
```

## References

- [Phlex Docs](https://www.phlex.fun/)
- [Literal Props](https://literal.fun/docs/properties)
- [Tailwind CSS](https://tailwindcss.com/)
