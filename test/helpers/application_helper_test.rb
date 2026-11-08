require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "renders a shared typography kit component from Haml" do
    render inline: "= Typography(tag: :h2, size: :lg) { 'Typography test' }", type: :haml

    assert_select "h2", count: 1, text: "Typography test"
    assert_includes rendered, "text-lg"
  end

  test "renders the error message kit method from Haml" do
    render inline: "= ErrorMessage(message: message)", type: :haml,
      locals: { message: "Something went wrong" }

    assert_select "div[role=alert].border-red.text-error", count: 1, text: "Something went wrong"
  end

  test "escapes error message text without escaping component markup" do
    message = "<script>alert('error')</script> & invalid"
    render inline: "= ErrorMessage(message: message)", type: :haml, locals: { message: message }

    assert_select "div[role=alert]", count: 1, text: message
    assert_select "script", count: 0
    assert_includes rendered, "&lt;script&gt;"
    assert_includes rendered, "&amp; invalid"
  end
end
