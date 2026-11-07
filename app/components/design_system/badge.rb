# frozen_string_literal: true

module DesignSystem
  class Badge < View
    VARIANTS = {
      default: "bg-white border border-line text-ink",
      success: "bg-soft-green border border-green text-green",
      error: "bg-red bg-opacity-10 border border-red text-error"
    }.freeze

    SIZES = {
      sm: "px-2 py-1 text-xs",
      base: "px-3 py-1.5 text-sm"
    }.freeze

    def initialize(variant: :default, size: :base, **props)
      variant_class = VARIANTS[variant] || VARIANTS[:default]
      size_class = SIZES[size] || SIZES[:base]
      base_classes = "#{variant_class} #{size_class} rounded font-semibold inline-block"
      super(tag: :span, classes: base_classes, **props)
    end
  end
end
