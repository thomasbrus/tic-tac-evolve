# frozen_string_literal: true

module Components
  class Badge < Base
    Variant = _Union(:default, :success, :error)
    Size = _Union(:sm, :base)

    VARIANT_STYLE_CLASSES = {
      %i[default] => 'bg-white border border-line text-ink',
      %i[success] => 'bg-soft-green border border-green text-green',
      %i[error] => 'bg-red bg-opacity-10 border border-red text-error'
    }.freeze

    SIZE_STYLE_CLASSES = {
      %i[sm] => 'px-2 py-1 text-xs',
      %i[base] => 'px-3 py-1.5 text-sm'
    }.freeze

    prop(:variant, Variant, default: :default, reader: :public)
    prop(:size, Size, default: :base, reader: :public)

    def view_template(&block)
      span(**attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          'rounded font-semibold inline-block',
          VARIANT_STYLE_CLASSES[[@variant]],
          SIZE_STYLE_CLASSES[[@size]]
        ]
      }
    end
  end
end
