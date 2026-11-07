module Matches
  class MatchSetupSection < Phlex::HTML
    def initialize(t_scope: "matches.index")
      @t_scope = t_scope
    end

    def view_template
      section(class: "border-b border-line pt-6 pb-12") do
        p(class: "text-xs") { plain I18n.t("#{@t_scope}.eyebrow") }
        h1(class: "mt-3 mb-4 font-display text-[34px] font-normal sm:text-[42px]") do
          plain I18n.t("#{@t_scope}.heading")
        end
      end
    end
  end
end
