# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::LabelTest < DesignSystemTest
  test "renders label tag" do
    component = DesignSystem::Label.new
    html = render_component(component)
    assert_match(/<label/, html)
  end

  test "has cursor-pointer styling" do
    component = DesignSystem::Label.new
    html = render_component(component)
    assert_includes(html, "cursor-pointer")
  end

  test "merges additional props" do
    component = DesignSystem::Label.new(for: "input-id", class: "custom")
    html = render_component(component)
    assert_includes(html, "for=\"input-id\"")
    assert_includes(html, "custom")
  end

  test "yields content" do
    component = DesignSystem::Label.new { "Label text" }
    html = render_component(component)
    assert_includes(html, "Label text")
  end
end
