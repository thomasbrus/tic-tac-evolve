# frozen_string_literal: true

module Components
  class Base < Phlex::HTML
    extend(Literal::Properties)

    prop(:html_attrs, _Hash(Symbol, _Any), :**, default: -> { {} }, reader: :public)

    protected

    def default_attrs
      { class: [] }
    end

    def attrs
      defaults = default_attrs
      
      # Merge classes - keep as array for Phlex
      class_list = Array(defaults[:class]) + Array(html_attrs[:class])
      
      attrs_hash = defaults.dup
      attrs_hash[:class] = class_list.compact
      
      # Merge other HTML attributes
      attrs_hash.merge!(html_attrs.except(:class))
      
      attrs_hash
    end
  end
end
