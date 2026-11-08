# frozen_string_literal: true

module Components
  class Button < Base
    Variant = _Union(:primary, :secondary, :tertiary)
    Size = _Union(:sm, :base, :lg)

    VARIANT_STYLE_CLASSES = {
      %i[primary] => "bg-ink text-white hover:bg-green",
      %i[secondary] => "border border-line text-ink hover:bg-soft-green",
      %i[tertiary] => "text-link underline"
    }.freeze

    SIZE_STYLE_CLASSES = {
      %i[sm] => "px-3 py-2 text-sm",
      %i[base] => "px-6 py-3.5",
      %i[lg] => "px-8 py-4 text-lg"
    }.freeze

    prop :variant, Variant, default: :primary, reader: :public
    prop :size, Size, default: :base, reader: :public

    def view_template(&block)
      button(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          "cursor-pointer rounded border-0 font-normal",
          VARIANT_STYLE_CLASSES[[@variant]],
          SIZE_STYLE_CLASSES[[@size]]
        ]
      }
    end
  end
end
