# frozen_string_literal: true

module DesignSystem
  class View < Phlex::HTML
    # Base component for all design system components.
    # Provides a foundation for building styled, composable UI elements with literal props.
    #
    # Literal props map to Tailwind utility classes:
    #   gap: 2          → gap-2
    #   items: :center  → items-center
    #   p: 4            → p-4
    #   class: "custom" → custom (merged with generated classes)

    TAILWIND_UTILITY_PATTERNS = [
      /^(p|px|py|pt|pb|pl|pr)$/,
      /^(m|mx|my|mt|mb|ml|mr)$/,
      /^gap/,
      /^flex/,
      /^grid/,
      /^(items|justify|content)/,
      /^text/,
      /^font/,
      /^bg/,
      /^border/,
      /^rounded/,
      /^(w|h|max_w|max_h|min_w|min_h)$/,
      /^overflow/,
      /^cursor/,
      /^opacity/,
      /^shadow/,
      /^(hover|active|focus|disabled)/
    ].freeze

    def initialize(tag: :div, classes: "", **props)
      @tag = tag
      @base_classes = classes
      
      # Extract class and data/aria attributes specially
      @custom_class = props.delete(:class)
      @data = props.delete(:data)
      @aria = props.delete(:aria)
      
      # Separate Tailwind utility props from other HTML attributes
      @tailwind_props = {}
      @html_props = {}
      
      props.each do |key, value|
        if tailwind_utility?(key)
          @tailwind_props[key] = value
        else
          @html_props[key] = value
        end
      end
    end

    def view_template
      send(@tag, **html_attributes) { yield if block_given? }
    end

    protected

    def html_attributes
      attrs = {
        class: combined_classes,
        **@html_props
      }
      attrs[:data] = @data if @data.present?
      attrs[:aria] = @aria if @aria.present?
      attrs
    end

    def combined_classes
      [*literal_to_tailwind, @custom_class, @base_classes].compact.join(" ").strip
    end

    private

    def tailwind_utility?(key)
      TAILWIND_UTILITY_PATTERNS.any? { |pattern| pattern.match?(key.to_s) }
    end

    def literal_to_tailwind
      @tailwind_props.map { |key, value| tailwind_for(key, value) }
    end

    def tailwind_for(key, value)
      return if value.nil? || value == false

      case value
      when true
        # Boolean true for utilities that don't need a value (e.g., flex, grid)
        key.to_s.tr("_", "-")
      when Integer, String
        "#{key.to_s.tr('_', '-')}-#{value}"
      when Symbol
        "#{key.to_s.tr('_', '-')}-#{value.to_s.tr('_', '-')}"
      when Array
        value.map { |v| tailwind_for(key, v) }.compact
      when Hash
        # Responsive values: { base: 2, sm: 4 } → ["p-2", "sm:p-4"]
        value.map { |breakpoint, val| responsive_class(key, val, breakpoint) }
      end
    end

    def responsive_class(key, value, breakpoint)
      return tailwind_for(key, value) if breakpoint == :base

      "#{breakpoint}:#{tailwind_for(key, value)}"
    end
  end
end
