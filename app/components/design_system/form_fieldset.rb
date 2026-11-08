# frozen_string_literal: true

module Components
  class FormFieldset < Base
    def view_template(&block)
      fieldset(**attrs, &block)
    end

    private

    def default_attrs
      { class: 'border-0 p-0' }
    end
  end
end
