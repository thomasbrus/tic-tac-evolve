# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::SelectTest < DesignSystemTest
  test "renders select tag" do
    component = DesignSystem::Select.new
    html = render_component(component)
    assert_match(/<select/, html)
  end

  test "has base styling" do
    component = DesignSystem::Select.new
    html = render_component(component)
    assert_includes(html, "rounded")
    assert_includes(html, "border")
    assert_includes(html, "bg-white")
  end

  test "applies size variants" do
    sizes = {
      sm: "text-sm",
      base: "py-2.5",
      lg: "text-lg"
    }
    sizes.each do |size, expected_class|
      component = DesignSystem::Select.new(size:)
      html = render_component(component)
      assert_includes(html, expected_class)
    end
  end
end
