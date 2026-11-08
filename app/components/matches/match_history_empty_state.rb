module Components
  class MatchHistoryEmptyState < Phlex::HTML
    def initialize(t_scope: "matches.index")
      @t_scope = t_scope
    end

    def view_template
      p(class: "text-sm text-secondary") do
        plain I18n.t("#{@t_scope}.history.empty")
      end
    end
  end
end
