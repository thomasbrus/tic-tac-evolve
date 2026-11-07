# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::ViewTest < DesignSystemTest
  test "renders with default div tag" do
    component = DesignSystem::View.new
    html = render_component(component)
    assert_match(/<div.*><\/div>/, html)
  end

  test "renders with custom tag" do
    component = DesignSystem::View.new(tag: :section)
    html = render_component(component)
    assert_match(/<section.*><\/section>/, html)
  end

  test "converts literal prop to tailwind class" do
    component = DesignSystem::View.new(gap: 2, p: 4)
    html = render_component(component)
    assert_includes(html, "gap-2")
    assert_includes(html, "p-4")
  end

  test "converts symbol prop to tailwind class" do
    component = DesignSystem::View.new(items: :center, justify: :between)
    html = render_component(component)
    assert_includes(html, "items-center")
    assert_includes(html, "justify-between")
  end

  test "converts boolean true to utility name" do
    component = DesignSystem::View.new(flex: true, grid: true)
    html = render_component(component)
    assert_includes(html, "flex")
    assert_includes(html, "grid")
  end

  test "merges custom class with generated tailwind classes" do
    component = DesignSystem::View.new(gap: 2, class: "custom-class")
    html = render_component(component)
    assert_includes(html, "gap-2")
    assert_includes(html, "custom-class")
  end

  test "ignores nil and false values" do
    component = DesignSystem::View.new(gap: 2, p: nil, m: false)
    html = render_component(component)
    assert_includes(html, "gap-2")
    assert_not_includes(html, "class=\"p-")
    assert_not_includes(html, "class=\"m-")
  end

  test "converts underscores to hyphens in class names" do
    component = DesignSystem::View.new(grid_cols: 3, gap_x: 4)
    html = render_component(component)
    assert_includes(html, "grid-cols-3")
    assert_includes(html, "gap-x-4")
  end

  test "handles responsive values" do
    component = DesignSystem::View.new(p: { base: 2, sm: 4, lg: 6 })
    html = render_component(component)
    assert_includes(html, "p-2")
    assert_includes(html, "sm:p-4")
    assert_includes(html, "lg:p-6")
  end

  test "yields content block" do
    component = DesignSystem::View.new { "Hello World" }
    html = render_component(component)
    assert_includes(html, "Hello World")
  end

  test "passes through additional html attributes" do
    component = DesignSystem::View.new(data: { controller: "test" }, aria: { label: "Test" })
    html = render_component(component)
    assert_includes(html, "data-controller=\"test\"")
    assert_includes(html, "aria-label=\"Test\"")
  end

  test "base_classes are preserved" do
    component = DesignSystem::View.new(classes: "base-class", p: 4)
    html = render_component(component)
    assert_includes(html, "base-class")
    assert_includes(html, "p-4")
  end
end
