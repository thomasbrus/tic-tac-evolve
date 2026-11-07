# frozen_string_literal: true

module DesignSystem
  class Button < View
    VARIANTS = {
      primary: "bg-ink text-white hover:bg-green",
      secondary: "border border-line text-ink hover:bg-soft-green",
      tertiary: "text-link underline"
    }.freeze

    SIZES = {
      sm: "px-3 py-2 text-sm",
      base: "px-6 py-3.5",
      lg: "px-8 py-4 text-lg"
    }.freeze

    def initialize(variant: :primary, size: :base, **props)
      variant_class = VARIANTS[variant] || VARIANTS[:primary]
      size_class = SIZES[size] || SIZES[:base]
      
      base_classes = "#{variant_class} #{size_class} cursor-pointer rounded border-0 font-normal"
      super(tag: :button, classes: base_classes, **props)
    end
  end
end
