module DesignSystem
  class Eyebrow < Base
    def initialize(text:, **html_attrs)
      html_attrs[:class] ||= []
      html_attrs[:class] = Array(html_attrs[:class]) + ["text-xs"]
      super(**html_attrs)
      @text = text
    end

    def view_template
      p(**html_attrs) do
        plain @text
      end
    end
  end
end
