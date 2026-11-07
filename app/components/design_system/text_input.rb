# frozen_string_literal: true

module DesignSystem
  class TextInput < View
    SIZES = {
      sm: "px-2 py-1.5 text-sm",
      base: "px-3 py-2",
      lg: "px-4 py-3 text-lg"
    }.freeze

    def initialize(size: :base, **props)
      size_class = SIZES[size] || SIZES[:base]
      base_classes = "#{size_class} rounded border border-line bg-white min-w-0 disabled:bg-muted disabled:text-subtle"
      super(tag: :input, classes: base_classes, **props)
    end
  end
end
