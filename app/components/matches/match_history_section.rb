module Components
  class MatchHistorySection < Phlex::HTML
    def initialize(page:, t_scope: "matches.index")
      @page = page
      @t_scope = t_scope
    end

    def view_template
      section(class: "pt-7", aria: { labelledby: "history-heading" }) do
        div(class: "flex items-center justify-between gap-3") do
          h2(id: "history-heading", class: "my-5 font-display text-2xl font-normal") do
            plain I18n.t("#{@t_scope}.history.heading")
          end
          span(class: "text-xs") do
            plain I18n.t("#{@t_scope}.history.page", number: @page)
          end
        end
      end
    end
  end
end
