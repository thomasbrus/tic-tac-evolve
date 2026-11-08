# frozen_string_literal: true

require('test_helper')
require_relative('../../components/design_system_test_helper')

class Components::CardTest < DesignSystemTest
  test('renders div tag') do
    component = Components::Card.new
    html = render_component(component)
    assert_match(/<div[^>]*class="[^"]*bg-white/, html)
  end

  test('applies default variant') do
    component = Components::Card.new
    html = render_component(component)
    assert_includes(html, 'bg-white')
    assert_includes(html, 'border')
    assert_includes(html, 'border-line')
  end

  test('applies soft variant') do
    component = Components::Card.new(variant: :soft)
    html = render_component(component)
    assert_includes(html, 'bg-soft-green')
    assert_not_includes(html, 'class="p-4 bg-soft-green border')
  end

  test('has padding and rounded styling') do
    component = Components::Card.new
    html = render_component(component)
    assert_includes(html, 'p-4')
    assert_includes(html, 'rounded')
  end

  test('merges additional HTML attributes') do
    component = Components::Card.new(class: 'custom', data: { id: 'card-1' })
    html = render_component(component)
    assert_includes(html, 'custom')
    assert_includes(html, 'data-id="card-1"')
  end

  test('yields content') do
    component = Components::Card.new { 'Card content' }
    html = render_component(component)
    assert_includes(html, 'Card content')
  end
end
