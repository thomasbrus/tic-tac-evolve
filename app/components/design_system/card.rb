# frozen_string_literal: true

module DesignSystem
  class Card < View
    VARIANTS = {
      default: "bg-white border border-line",
      soft: "bg-soft-green border-0"
    }.freeze

    def initialize(variant: :default, **props)
      variant_class = VARIANTS[variant] || VARIANTS[:default]
      base_classes = "#{variant_class} rounded p-4"
      super(tag: :div, classes: base_classes, **props)
    end
  end
end
