# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::ContainerTest < DesignSystemTest
  test "renders with default max width" do
    component = DesignSystem::Container.new
    html = render_component(component)
    assert_includes(html, "max-w-[1040px]")
    assert_includes(html, "mx-auto")
  end

  test "allows custom max width" do
    component = DesignSystem::Container.new(max_width: "max-w-2xl")
    html = render_component(component)
    assert_includes(html, "max-w-2xl")
    assert_includes(html, "mx-auto")
  end

  test "merges additional HTML attributes" do
    component = DesignSystem::Container.new(class: "custom-class", data: { test: "value" })
    html = render_component(component)
    assert_includes(html, "max-w-[1040px]")
    assert_includes(html, "mx-auto")
    assert_includes(html, "custom-class")
    assert_includes(html, "data-test=\"value\"")
  end

  test "yields content" do
    component = DesignSystem::Container.new { "Container content" }
    html = render_component(component)
    assert_includes(html, "Container content")
  end
end
