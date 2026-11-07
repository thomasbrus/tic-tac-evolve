module DesignSystem
  class Heading < Phlex::HTML
    SIZE_STYLE_CLASSES = {
      sm: "text-lg",
      base: "text-2xl",
      lg: "text-[34px]",
      xl: "text-[42px]"
    }.freeze

    def initialize(text:, level: :h2, size: :base, **html_attrs)
      html_attrs[:class] ||= []
      html_attrs[:class] = Array(html_attrs[:class]) + [
        "font-display font-normal",
        SIZE_STYLE_CLASSES[size]
      ]
      @text = text
      @level = level
      @html_attrs = html_attrs
    end

    def view_template
      case @level
      when :h1
        h1(**@html_attrs) { plain @text }
      when :h2
        h2(**@html_attrs) { plain @text }
      when :h3
        h3(**@html_attrs) { plain @text }
      when :h4
        h4(**@html_attrs) { plain @text }
      when :h5
        h5(**@html_attrs) { plain @text }
      when :h6
        h6(**@html_attrs) { plain @text }
      else
        h2(**@html_attrs) { plain @text }
      end
    end
  end
end
