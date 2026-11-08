require('test_helper')

class Components::HeadingTest < ActiveSupport::TestCase
  test('renders h2 with default size') do
    component = Components::Heading.new(text: 'Title')
    html = component.call
    assert_includes(html, '<h2')
    assert_includes(html, 'font-display')
    assert_includes(html, 'text-2xl')
    assert_includes(html, 'Title')
  end

  test('renders with different heading levels') do
    %i[h1 h2 h3 h4 h5 h6].each do |level|
      component = Components::Heading.new(text: 'Test', level: level)
      html = component.call
      assert_includes(html, "<#{level}")
      assert_includes(html, 'Test')
    end
  end

  test('renders with different sizes') do
    sizes = { sm: 'text-lg', base: 'text-2xl', lg: 'text-[34px]', xl: 'text-[42px]' }
    sizes.each do |size, class_name|
      component = Components::Heading.new(text: 'Test', size: size)
      html = component.call
      assert_includes(html, class_name)
    end
  end

  test('accepts custom html attributes') do
    component = Components::Heading.new(
      text: 'Custom',
      class: 'custom-class',
      id: 'heading-1'
    )
    html = component.call
    assert_includes(html, 'custom-class')
    assert_includes(html, 'id="heading-1"')
    assert_includes(html, 'font-display')
  end
end
