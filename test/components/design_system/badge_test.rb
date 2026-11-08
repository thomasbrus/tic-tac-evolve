# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class Components::BadgeTest < DesignSystemTest
  test "renders span tag" do
    component = Components::Badge.new
    html = render_component(component)
    assert_match(/<span/, html)
  end

  test "applies default variant" do
    component = Components::Badge.new
    html = render_component(component)
    assert_includes(html, "bg-white")
    assert_includes(html, "border")
    assert_includes(html, "border-line")
  end

  test "applies success variant" do
    component = Components::Badge.new(variant: :success)
    html = render_component(component)
    assert_includes(html, "bg-soft-green")
    assert_includes(html, "border-green")
    assert_includes(html, "text-green")
  end

  test "applies error variant" do
    component = Components::Badge.new(variant: :error)
    html = render_component(component)
    assert_includes(html, "bg-red")
    assert_includes(html, "border-red")
    assert_includes(html, "text-error")
  end

  test "applies size variants" do
    sizes = {
      sm: "text-xs",
      base: "text-sm"
    }
    sizes.each do |size, expected_class|
      component = Components::Badge.new(size:)
      html = render_component(component)
      assert_includes(html, expected_class)
    end
  end

  test "combines variant and size" do
    component = Components::Badge.new(variant: :success, size: :base)
    html = render_component(component)
    assert_includes(html, "bg-soft-green")
  end

  test "has common styling" do
    component = Components::Badge.new
    html = render_component(component)
    assert_includes(html, "rounded")
    assert_includes(html, "font-semibold")
    assert_includes(html, "inline-block")
  end

  test "yields content" do
    component = Components::Badge.new { "Active" }
    html = render_component(component)
    assert_includes(html, "Active")
  end
end
