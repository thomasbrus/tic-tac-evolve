# frozen_string_literal: true

module DesignSystem
  class Label < View
    def initialize(**props)
      super(tag: :label, classes: "cursor-pointer", **props)
    end
  end
end
