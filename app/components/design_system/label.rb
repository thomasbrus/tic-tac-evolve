# frozen_string_literal: true

module DesignSystem
  class Label < Base
    def view_template(&block)
      label(**attrs, &block)
    end

    private

    def default_attrs
      { class: "cursor-pointer" }
    end
  end
end
