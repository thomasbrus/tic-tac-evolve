module Matches
  class MatchHistoryPagination < Phlex::HTML
    include Rails.application.routes.url_helpers

    def initialize(page:, more_matches:, t_scope: "matches.index")
      @page = page
      @more_matches = more_matches
      @t_scope = t_scope
    end

    def view_template
      nav(class: "mt-5 flex justify-between gap-5", aria: { label: I18n.t("#{@t_scope}.history.pagination.label") }) do
        if @page > 1
          a(href: root_path(page: @page - 1)) do
            plain I18n.t("#{@t_scope}.history.pagination.previous")
          end
        end
        if @more_matches
          a(href: root_path(page: @page + 1)) do
            plain I18n.t("#{@t_scope}.history.pagination.next")
          end
        end
      end
    end
  end
end
