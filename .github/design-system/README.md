# Design System with Phlex & Props

This directory contains documentation for the tic-tac-evolve design system. The system is built using [Phlex](https://www.phlex.fun/) components with explicit props and predefined style maps.

## Core Concept

Components declare explicit props using the `prop` DSL. Style classes are organized in keyed maps that combine prop values:

```ruby
class Badge < Base
  VARIANT_STYLE_CLASSES = {
    %i[default] => "bg-white border border-line",
    %i[success] => "bg-soft-green border border-green",
    %i[error] => "bg-red border border-red text-error"
  }.freeze

  SIZE_STYLE_CLASSES = {
    %i[sm] => "px-2 py-1 text-xs",
    %i[base] => "px-3 py-1.5 text-sm"
  }.freeze

  prop :variant, default: :default
  prop :size, default: :base
end
```

This approach provides:
- **Explicit props** — component behavior is clear and type-safe
- **Predefined styles** — no runtime magic, all styles are in maps
- **Maintainability** — changes to variants/sizes are in one place
- **Clarity** — props define *what*, styles define *how*

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

The foundation for all components. Provides the `prop` DSL and standard `attrs` method.

```ruby
class Base < Phlex::HTML
  def self.prop(name, type = nil, default: nil, required: false)
    # Declares a component prop with optional default
  end

  def default_attrs
    # Subclasses override this to provide default Tailwind classes
  end

  def attrs
    # Merges default_attrs with custom HTML attributes
  end
end
```

When you create a component:

```ruby
class MyComponent < Base
  prop :variant, default: :default
  prop :size, default: :base

  STYLE_MAP = { ... }.freeze

  def view_template(&block)
    div(**attrs, &block)
  end

  private

  def default_attrs
    {
      class: [
        "base-classes",
        STYLE_MAP[[@variant, @size]]
      ]
    }
  end
end
```

Usage:

```ruby
MyComponent.new(variant: :primary, class: "custom") { "Content" }
# Renders: <div class="base-classes primary-5-base custom">Content</div>
```

**Prefer props when:**
- Composing components for semantic meaning
- You want to change styling in one place (the component definition)
- Props are reused across multiple instances
- You need explicit, type-safe component options

**Use HTML attributes when:**
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
- [Literal Props](https://literal.fun/docs/properties)
- [Tailwind CSS](https://tailwindcss.com/)
