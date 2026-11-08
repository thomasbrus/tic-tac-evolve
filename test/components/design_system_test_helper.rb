# frozen_string_literal: true

require('test_helper')

class DesignSystemTest < ActiveSupport::TestCase
  def render_component(component)
    component.call
  end
end
