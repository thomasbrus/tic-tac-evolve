module DesignSystem
  class Section < Phlex::HTML
    def initialize(title: nil, subtitle: nil, content: nil, **html_attrs)
      @title = title
      @subtitle = subtitle
      @content = content
      @html_attrs = html_attrs
    end

    def view_template
      section(**@html_attrs) do
        if @title
          div(class: "mb-6") do
            h2(class: "font-display text-2xl font-normal mb-2") do
              plain @title
            end
            if @subtitle
              p(class: "text-sm text-secondary") do
                plain @subtitle
              end
            end
          end
        end
        if @content
          plain @content
        end
      end
    end
  end
end
