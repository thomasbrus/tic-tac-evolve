# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::ButtonTest < DesignSystemTest
  test "renders button tag" do
    component = DesignSystem::Button.new
    html = render_component(component)
    assert_match(/<button/, html)
  end

  test "applies primary variant by default" do
    component = DesignSystem::Button.new
    html = render_component(component)
    assert_includes(html, "bg-ink")
    assert_includes(html, "text-white")
    assert_includes(html, "hover:bg-green")
  end

  test "applies secondary variant" do
    component = DesignSystem::Button.new(variant: :secondary)
    html = render_component(component)
    assert_includes(html, "border")
    assert_includes(html, "border-line")
    assert_includes(html, "hover:bg-soft-green")
  end

  test "applies tertiary variant" do
    component = DesignSystem::Button.new(variant: :tertiary)
    html = render_component(component)
    assert_includes(html, "text-link")
    assert_includes(html, "underline")
  end

  test "applies size variants" do
    sizes = {
      sm: "text-sm",
      base: "px-6",
      lg: "text-lg"
    }
    sizes.each do |size, expected_class|
      component = DesignSystem::Button.new(size:)
      html = render_component(component)
      assert_includes(html, expected_class, "Size #{size} should include #{expected_class}")
    end
  end

  test "merges additional props" do
    component = DesignSystem::Button.new(class: "custom", data: { test: "value" })
    html = render_component(component)
    assert_includes(html, "custom")
    assert_includes(html, "data-test=\"value\"")
  end

  test "yields content" do
    component = DesignSystem::Button.new { "Click me" }
    html = render_component(component)
    assert_includes(html, "Click me")
  end
end
