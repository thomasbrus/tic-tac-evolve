# frozen_string_literal: true

module DesignSystem
  class TextInput < Base
    SIZE_STYLE_CLASSES = {
      %i[sm] => "px-2 py-1.5 text-sm",
      %i[base] => "px-3 py-2",
      %i[lg] => "px-4 py-3 text-lg"
    }.freeze

    prop :size, default: :base

    def view_template
      input(**attrs)
    end

    private

    def default_attrs
      {
        class: [
          "rounded border border-line bg-white min-w-0 disabled:bg-muted disabled:text-subtle",
          SIZE_STYLE_CLASSES[[@size]]
        ]
      }
    end
  end
end
