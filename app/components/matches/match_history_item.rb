module Components
  class MatchHistoryItem < Phlex::HTML
    include Rails.application.routes.url_helpers

    def initialize(match:, t_scope: "matches.index")
      @match = match
      @t_scope = t_scope
    end

    def view_template
      complete = @match.complete?
      li(class: "flex items-center justify-between gap-3 border-t border-line py-5 sm:gap-5") do
        div(class: "min-w-0") do
          span(class: "text-sm font-bold") { plain "##{@match.id.to_s.rjust(3, '0')}" }
          span(class: "state-label #{complete ? 'finished text-subtle' : 'active text-green'} ml-3 text-[11px] uppercase") do
            plain complete ? I18n.t("#{@t_scope}.history.complete") : I18n.t("#{@t_scope}.history.active")
          end
          p(class: "my-2 text-sm") { plain @match.mode_label }
          time(class: "text-xs text-subtle", datetime: @match.updated_at.iso8601) do
            plain @match.updated_at.strftime("%d %b %Y, %H:%M")
          end
        end

        div(class: "flex shrink-0 flex-col items-end gap-3 text-xs sm:text-sm") do
          span { plain @match.status_label }
          a(
            href: match_path(@match),
            class: "py-1.5 text-green",
            aria: { label: I18n.t(complete ? "#{@t_scope}.history.view_label" : "#{@t_scope}.history.resume_label", number: @match.id) }
          ) do
            plain complete ? I18n.t("#{@t_scope}.history.view") : I18n.t("#{@t_scope}.history.resume")
          end
        end
      end
    end
  end
end
