# frozen_string_literal: true

require('test_helper')
require_relative('../../components/design_system_test_helper')

class Components::FormFieldsetTest < DesignSystemTest
  test('renders fieldset tag') do
    component = Components::FormFieldset.new
    html = render_component(component)
    assert_match(/<fieldset/, html)
  end

  test('has base styling') do
    component = Components::FormFieldset.new
    html = render_component(component)
    assert_includes(html, 'border-0')
    assert_includes(html, 'p-0')
  end

  test('merges additional HTML attributes') do
    component = Components::FormFieldset.new(class: 'custom', aria: { label: 'Form' })
    html = render_component(component)
    assert_includes(html, 'border-0')
    assert_includes(html, 'p-0')
    assert_includes(html, 'custom')
    assert_includes(html, 'aria-label="Form"')
  end

  test('yields content') do
    component = Components::FormFieldset.new { 'Form content' }
    html = render_component(component)
    assert_includes(html, 'Form content')
  end
end
