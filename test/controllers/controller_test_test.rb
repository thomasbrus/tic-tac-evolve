require('test_helper')

class ControllerTestTest < ControllerTest
  test('page parses the latest integration response') do
    get(root_path)

    assert_selector(:fieldset, 'Opponent')

    match = Match.create!(mode: 'local')
    get(match_path(match))

    assert_selector(:button, 'Square 1, empty')
    assert_no_selector(:fieldset, 'Opponent')
  end

  test('page reparses changed bodies on the same response') do
    get(root_path)
    original_response = response
    assert_selector(:button, 'Start match')

    response.body = '<p>Updated response</p>'

    assert_same(original_response, response)
    assert_text('Updated response')
    assert_no_selector(:button, 'Start match')
  end

  test('configured test IDs locate controls without a browser') do
    get(root_path)
    response.body = '<button data-test-id="sample-action">Go</button>'

    assert_selector(:button, 'sample-action', text: 'Go')
    assert_no_selector(:button, 'missing-action')
  end

  test('non-visible metadata and hidden inputs remain assertable') do
    get(root_path)
    response.body = '<html><head><title>Sample title</title></head><body><input type="hidden" name="revision" value="2"></body></html>'

    assert_selector('title', visible: :all, text: 'Sample title')
    assert_selector('input[name="revision"]', visible: :all, count: 1)
    assert_no_selector('input[name="revision"]')
  end
end
