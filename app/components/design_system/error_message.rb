module Components
  class ErrorMessage < Base
    def initialize(message:, **html_attrs)
      html_attrs[:class] ||= []
      html_attrs[:class] = Array(html_attrs[:class]) + ['border-l-[3px]', 'border-red', 'p-3', 'text-error', 'my-4']
      html_attrs[:role] = 'alert'
      super(**html_attrs)
      @message = message
    end

    def view_template
      div(**html_attrs) do
        plain(@message)
      end
    end
  end
end
