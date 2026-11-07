require "test_helper"

class DesignSystem::EyebrowTest < ActiveSupport::TestCase
  test "renders eyebrow text with default styling" do
    component = DesignSystem::Eyebrow.new(text: "Label text")
    html = component.call
    assert_includes html, "<p"
    assert_includes html, "text-xs"
    assert_includes html, "Label text"
  end

  test "accepts custom html attributes" do
    component = DesignSystem::Eyebrow.new(
      text: "Custom",
      class: "custom-class",
      id: "eyebrow-1"
    )
    html = component.call
    assert_includes html, "custom-class"
    assert_includes html, "id=\"eyebrow-1\""
    assert_includes html, "text-xs"
  end
end
