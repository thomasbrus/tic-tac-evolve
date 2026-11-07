# Design System with Phlex & Literal::Properties

This directory contains documentation for the tic-tac-evolve design system. The system is built using [Phlex](https://www.phlex.fun/) components with [Literal::Properties](https://literal.fun/docs/properties) for type-safe props and predefined style maps.

## Core Concept

Components use `Literal::Properties` to declare explicit, type-safe props. Style classes are organized in frozen maps keyed by prop combinations:

```ruby
class Badge < Base
  Variant = _Union(:default, :success, :error)
  Size = _Union(:sm, :base)

  VARIANT_STYLE_CLASSES = {
    %i[default] => "bg-white border border-line",
    %i[success] => "bg-soft-green border border-green",
    %i[error] => "bg-red border border-red text-error"
  }.freeze

  SIZE_STYLE_CLASSES = {
    %i[sm] => "px-2 py-1 text-xs",
    %i[base] => "px-3 py-1.5 text-sm"
  }.freeze

  prop :variant, Variant, default: :default, reader: :public
  prop :size, Size, default: :base, reader: :public
end
```

This approach provides:
- **Explicit, type-safe props** — using `_Union` types for variants and sizes
- **Predefined styles** — all styling is in frozen maps, no runtime magic
- **Maintainability** — changes to variants/sizes are in one place
- **Clarity** — props define *what*, style maps define *how*
- **Props as readers** — `reader: :public` allows accessing props as instance methods when needed for testing or logic

## Component Hierarchy

```
Base
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

## Base Component

The foundation for all components. Uses `Literal::Properties` for explicit prop handling and provides the standard `attrs` method for merging default and custom styles.

```ruby
class Base < Phlex::HTML
  extend Literal::Properties

  # Captures all HTML attributes passed as keyword arguments (**kwargs)
  prop :html_attrs, _Hash(Symbol, _Any), :**, default: -> { {} }, reader: :public

  protected

  def default_attrs
    # Subclasses override to provide default Tailwind classes
    { class: [] }
  end

  def attrs
    # Merges default_attrs with html_attrs, handling class merging
    defaults = default_attrs
    class_list = Array(defaults[:class]) + Array(html_attrs[:class])
    attrs_hash = defaults.dup
    attrs_hash[:class] = class_list.compact
    attrs_hash.merge!(html_attrs.except(:class))
    attrs_hash
  end
end
```

When you create a component:

```ruby
class MyComponent < Base
  Variant = _Union(:primary, :secondary)
  Size = _Union(:sm, :lg)

  VARIANT_STYLE_CLASSES = {
    %i[primary] => "bg-ink text-white",
    %i[secondary] => "border border-line"
  }.freeze

  SIZE_STYLE_CLASSES = {
    %i[sm] => "px-3 py-2 text-sm",
    %i[lg] => "px-6 py-4 text-lg"
  }.freeze

  prop :variant, Variant, default: :primary, reader: :public
  prop :size, Size, default: :lg, reader: :public

  def view_template(&block)
    button(**attrs, &block)
  end

  private

  def default_attrs
    {
      class: [
        "cursor-pointer rounded font-semibold",
        VARIANT_STYLE_CLASSES[[@variant]],
        SIZE_STYLE_CLASSES[[@size]]
      ]
    }
  end
end
```

Usage:

```ruby
MyComponent.new(variant: :primary, size: :sm, class: "mt-4") { "Click me" }
# Renders: <button class="cursor-pointer rounded font-semibold bg-ink text-white px-3 py-2 text-sm mt-4">Click me</button>
```

### How Props & Attributes Work Together

- **Props**: Component behavior declarators (`:variant`, `:size`). Accessed via `Literal::Properties` instance variables.
- **HTML Attributes**: Rendering context (`class`, `data`, `aria`, etc.). Passed via `**kwargs` and captured in `html_attrs`.
- **The `attrs` method**: Merges default Tailwind classes (from props) with custom attributes (from `html_attrs`).

**Prefer props when:**
- Composing components for semantic meaning
- You want to change styling in one place (the component definition)
- Props are reused across multiple instances
- You need explicit, type-safe component options

**Use HTML attributes (passed as kwargs) when:**
- Adding one-off classes or data attributes for a specific use
- Integrating with other tools (e.g., Stimulus with `data-controller`)
- Adding accessibility attributes (ARIA, role) for specific context

## Layout Strategy

Use **Tailwind utility classes directly in views** for layout (flexbox, grid, gap, positioning). Components focus on visual styling (Button, Input, Card), not layout.

Layout remains flexible and easy to adjust without creating new components. As we discover repeated layout patterns, we can introduce semantic layout components later.

## File Structure

```
app/components/design_system/
├── base.rb              # Base class with prop DSL
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
- [Literal::Properties Documentation](https://literal.fun/docs/properties)
- [Tailwind CSS](https://tailwindcss.com/)
