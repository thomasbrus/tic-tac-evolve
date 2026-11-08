require "test_helper"

class Components::ErrorMessageTest < ActiveSupport::TestCase
  test "renders error message with default styling" do
    component = Components::ErrorMessage.new(message: "Something went wrong")
    html = component.call
    assert_includes html, "role=\"alert\""
    assert_includes html, "border-l-[3px]"
    assert_includes html, "border-red"
    assert_includes html, "p-3"
    assert_includes html, "text-error"
    assert_includes html, "my-4"
    assert_includes html, "Something went wrong"
  end

  test "accepts custom html attributes" do
    component = Components::ErrorMessage.new(
      message: "Error occurred",
      data: { test: "value" }
    )
    html = component.call
    assert_includes html, "data-test=\"value\""
    assert_includes html, "role=\"alert\""
  end

  test "renders with custom class merging" do
    component = Components::ErrorMessage.new(
      message: "Test error",
      class: "custom-class"
    )
    html = component.call
    assert_includes html, "custom-class"
    assert_includes html, "border-red"
  end
end

