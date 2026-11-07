# frozen_string_literal: true

module DesignSystem
  class Typography < Base
    SIZES = {
      xs: "text-xs",
      sm: "text-sm",
      base: "text-base",
      lg: "text-lg",
      xl: "text-xl",
      "2xl": "text-2xl",
      "3xl": "text-3xl",
      display: "font-display text-[34px] sm:text-[42px]"
    }.freeze

    WEIGHTS = {
      normal: "font-normal",
      medium: "font-medium",
      semibold: "font-semibold",
      bold: "font-bold"
    }.freeze

    COLORS = {
      default: "text-ink",
      secondary: "text-secondary",
      subtle: "text-subtle",
      error: "text-error"
    }.freeze

    prop :tag, default: :p
    prop :size, default: :base
    prop :weight, default: :normal
    prop :color, default: :default

    def view_template(&block)
      send(@tag, **attrs, &block)
    end

    private

    def default_attrs
      {
        class: [
          SIZES[@size] || SIZES[:base],
          WEIGHTS[@weight] || WEIGHTS[:normal],
          COLORS[@color] || COLORS[:default]
        ]
      }
    end
  end
end
