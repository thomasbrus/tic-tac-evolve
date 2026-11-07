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

  test "merges additional props" do
    component = DesignSystem::Container.new(p: 4, gap: 2)
    html = render_component(component)
    assert_includes(html, "max-w-[1040px]")
    assert_includes(html, "mx-auto")
    assert_includes(html, "p-4")
    assert_includes(html, "gap-2")
  end

  test "yields content" do
    component = DesignSystem::Container.new { "Container content" }
    html = render_component(component)
    assert_includes(html, "Container content")
  end
end
