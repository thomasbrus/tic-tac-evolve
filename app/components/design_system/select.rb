# frozen_string_literal: true

module DesignSystem
  class Select < Base
    Size = _Union(:sm, :base, :lg)

    SIZE_STYLE_CLASSES = {
      %i[sm] => "px-2 py-1.5 text-sm",
      %i[base] => "px-2 py-2.5",
      %i[lg] => "px-3 py-3 text-lg"
    }.freeze

    prop :size, Size, default: :base, reader: :public

    def view_template(&block)
      select(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          "rounded border border-line bg-white disabled:bg-muted disabled:text-subtle",
          SIZE_STYLE_CLASSES[[@size]]
        ]
      }
    end
  end
end
