# frozen_string_literal: true

module Components
  class Container < Base
    prop(:max_width, String, default: 'max-w-[1040px]', reader: :public)

    def view_template(&block)
      div(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          @max_width,
          'mx-auto'
        ]
      }
    end
  end
end
