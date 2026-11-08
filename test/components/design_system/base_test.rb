# frozen_string_literal: true

require('test_helper')
require_relative('../../components/design_system_test_helper')

class Components::BaseTest < DesignSystemTest
  test('Base is the foundation for all components') do
    # Base is abstract; we test it through concrete components
    assert_includes(Components::Button.ancestors, Components::Base)
    assert_includes(Components::Card.ancestors, Components::Base)
  end

  test('prop DSL declares instance variables') do
    component = Components::Button.new(variant: :secondary)
    assert_equal(:secondary, component.variant)
  end

  test('prop defaults work') do
    component = Components::Button.new
    assert_equal(:primary, component.variant)
    assert_equal(:base, component.size)
  end

  test('attrs method merges default and custom classes') do
    component = Components::Button.new(class: 'custom-class')
    attrs = component.send(:attrs)
    classes = attrs[:class]
    # Classes is an array, check that it contains both default and custom
    assert(classes.is_a?(Array))
    assert(classes.any? { |c| c.include?('cursor-pointer') })
    assert(classes.include?('custom-class'))
  end

  test('custom HTML attributes pass through') do
    component = Components::Button.new(data: { test: 'value' }, aria: { label: 'Test' })
    attrs = component.send(:attrs)
    assert_equal({ test: 'value' }, attrs[:data])
    assert_equal({ label: 'Test' }, attrs[:aria])
  end
end
