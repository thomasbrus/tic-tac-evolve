# frozen_string_literal: true

module DesignSystem
  class Badge < Base
    VARIANT_STYLE_CLASSES = {
      %i[default] => "bg-white border border-line text-ink",
      %i[success] => "bg-soft-green border border-green text-green",
      %i[error] => "bg-red bg-opacity-10 border border-red text-error"
    }.freeze

    SIZE_STYLE_CLASSES = {
      %i[sm] => "px-2 py-1 text-xs",
      %i[base] => "px-3 py-1.5 text-sm"
    }.freeze

    prop :variant, default: :default
    prop :size, default: :base

    def view_template(&block)
      span(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          "rounded font-semibold inline-block",
          VARIANT_STYLE_CLASSES[[@variant]],
          SIZE_STYLE_CLASSES[[@size]]
        ]
      }
    end
  end
end
