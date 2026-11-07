# frozen_string_literal: true

require "test_helper"
require_relative "../../components/design_system_test_helper"

class DesignSystem::FormFieldsetTest < DesignSystemTest
  test "renders fieldset tag" do
    component = DesignSystem::FormFieldset.new
    html = render_component(component)
    assert_match(/<fieldset/, html)
  end

  test "has base styling" do
    component = DesignSystem::FormFieldset.new
    html = render_component(component)
    assert_includes(html, "border-0")
    assert_includes(html, "p-0")
  end

  test "merges additional props" do
    component = DesignSystem::FormFieldset.new(gap: 4, flex: true)
    html = render_component(component)
    assert_includes(html, "gap-4")
    assert_includes(html, "flex")
  end

  test "yields content" do
    component = DesignSystem::FormFieldset.new { "Form content" }
    html = render_component(component)
    assert_includes(html, "Form content")
  end
end
