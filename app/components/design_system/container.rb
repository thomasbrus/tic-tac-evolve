# frozen_string_literal: true

module DesignSystem
  class Container < View
    def initialize(max_width: "max-w-[1040px]", **props)
      super(tag: :div, classes: "#{max_width} mx-auto", **props)
    end
  end
end
