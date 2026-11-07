# frozen_string_literal: true

module DesignSystem
  class Typography < View
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

    def initialize(tag: :p, size: :base, weight: :normal, color: :default, **props)
      size_class = SIZES[size] || SIZES[:base]
      weight_class = WEIGHTS[weight] || WEIGHTS[:normal]
      color_class = COLORS[color] || COLORS[:default]

      classes = "#{size_class} #{weight_class} #{color_class}"
      super(tag:, classes:, **props)
    end
  end
end
