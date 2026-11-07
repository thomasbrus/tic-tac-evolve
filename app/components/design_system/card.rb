# frozen_string_literal: true

module DesignSystem
  class Card < Base
    Variant = _Union(:default, :soft)

    VARIANT_STYLE_CLASSES = {
      %i[default] => "bg-white border border-line",
      %i[soft] => "bg-soft-green border-0"
    }.freeze

    prop :variant, Variant, default: :default, reader: :public

    def view_template(&block)
      div(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          "rounded p-4",
          VARIANT_STYLE_CLASSES[[@variant]]
        ]
      }
    end
  end
end
