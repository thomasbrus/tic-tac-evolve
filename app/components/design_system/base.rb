# frozen_string_literal: true

module DesignSystem
  class Base < Phlex::HTML
    # DSL for declaring component props with defaults and types
    def self.prop(name, type = nil, default: nil, required: false)
      # Store prop metadata
      @prop_defaults ||= {}
      @prop_defaults[name] = default

      # Create a reader for the prop
      attr_reader name

      # Define a custom initialize that handles props
      define_method(:initialize) do |**kwargs|
        # Extract all props defined on the class
        prop_defaults = self.class.instance_variable_get(:@prop_defaults) || {}
        prop_defaults.each do |prop_name, default_value|
          value = kwargs.delete(prop_name)
          value = default_value if value.nil?
          instance_variable_set("@#{prop_name}", value)
        end

        # Store remaining kwargs as HTML attributes
        @html_attrs = kwargs
      end unless instance_methods(false).include?(:initialize)
    end

    def initialize(**html_attrs)
      @html_attrs = html_attrs
    end

    protected

    def default_attrs
      { class: [] }
    end

    def attrs
      defaults = default_attrs
      defaults[:class] = Array(defaults[:class]) + Array(@html_attrs[:class])
      defaults.deep_merge(@html_attrs.except(:class))
    end
  end
end
