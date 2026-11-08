# frozen_string_literal: true

module Components
  class Typography < Base
    Size = _Union(:xs, :sm, :base, :lg, :xl, :"2xl", :"3xl", :display)
    Weight = _Union(:normal, :medium, :semibold, :bold)
    Color = _Union(:default, :secondary, :subtle, :error)

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

    prop :tag, Symbol, default: :p, reader: :public
    prop :size, Size, default: :base, reader: :public
    prop :weight, Weight, default: :normal, reader: :public
    prop :color, Color, default: :default, reader: :public

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
