# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::TypographyTest < DesignSystemTest
  test "renders with default tag and classes" do
    component = DesignSystem::Typography.new
    html = render_component(component)
    assert_match(/<p[^>]*class="[^"]*text-ink[^"]*"/, html)
  end

  test "renders with custom tag" do
    component = DesignSystem::Typography.new(tag: :h1)
    html = render_component(component)
    assert_match(/<h1[^>]*>/, html)
  end

  test "applies size variants" do
    sizes = [:xs, :sm, :base, :lg, :xl, :"2xl", :"3xl", :display]
    sizes.each do |size|
      component = DesignSystem::Typography.new(size:)
      html = render_component(component)
      expected_class = DesignSystem::Typography::SIZES[size]
      assert_includes(html, expected_class, "Size #{size} should include #{expected_class}")
    end
  end

  test "applies weight variants" do
    weights = [:normal, :medium, :semibold, :bold]
    weights.each do |weight|
      component = DesignSystem::Typography.new(weight:)
      html = render_component(component)
      expected_class = DesignSystem::Typography::WEIGHTS[weight]
      assert_includes(html, expected_class, "Weight #{weight} should include #{expected_class}")
    end
  end

  test "applies color variants" do
    colors = [:default, :secondary, :subtle, :error]
    colors.each do |color|
      component = DesignSystem::Typography.new(color:)
      html = render_component(component)
      expected_class = DesignSystem::Typography::COLORS[color]
      assert_includes(html, expected_class, "Color #{color} should include #{expected_class}")
    end
  end

  test "combines multiple variants" do
    component = DesignSystem::Typography.new(size: :xl, weight: :bold, color: :error)
    html = render_component(component)
    assert_includes(html, "text-xl")
    assert_includes(html, "font-bold")
    assert_includes(html, "text-error")
  end

  test "yields content" do
    component = DesignSystem::Typography.new { "Hello World" }
    html = render_component(component)
    assert_includes(html, "Hello World")
  end

  test "merges additional props" do
    component = DesignSystem::Typography.new(class: "custom", data: { test: "value" })
    html = render_component(component)
    assert_includes(html, "custom")
    assert_includes(html, "data-test=\"value\"")
  end
end
