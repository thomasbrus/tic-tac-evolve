# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class Components::TextInputTest < DesignSystemTest
  test "renders input tag" do
    component = Components::TextInput.new
    html = render_component(component)
    assert_match(/<input/, html)
  end

  test "has base styling" do
    component = Components::TextInput.new
    html = render_component(component)
    assert_includes(html, "rounded")
    assert_includes(html, "border")
    assert_includes(html, "border-line")
    assert_includes(html, "bg-white")
  end

  test "applies size variants" do
    sizes = {
      sm: "text-sm",
      base: "px-3",
      lg: "text-lg"
    }
    sizes.each do |size, expected_class|
      component = Components::TextInput.new(size:)
      html = render_component(component)
      assert_includes(html, expected_class, "Size #{size} should include #{expected_class}")
    end
  end

  test "disables styling" do
    component = Components::TextInput.new(disabled: true)
    html = render_component(component)
    assert_includes(html, "disabled:bg-muted")
    assert_includes(html, "disabled:text-subtle")
  end

  test "merges additional props" do
    component = Components::TextInput.new(type: "email", placeholder: "Enter email")
    html = render_component(component)
    assert_includes(html, "type=\"email\"")
    assert_includes(html, "placeholder=\"Enter email\"")
  end
end
