# frozen_string_literal: true

module DesignSystem
  class FormFieldset < View
    def initialize(**props)
      super(tag: :fieldset, classes: "border-0 p-0", **props)
    end
  end
end
