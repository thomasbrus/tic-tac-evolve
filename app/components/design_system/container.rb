# frozen_string_literal: true

module DesignSystem
  class Container < Base
    prop :max_width, default: "max-w-[1040px]"

    def view_template(&block)
      div(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          @max_width,
          "mx-auto"
        ]
      }
    end
  end
end
