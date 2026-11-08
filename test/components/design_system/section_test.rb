require('test_helper')

class Components::SectionTest < ActiveSupport::TestCase
  test('renders section with title') do
    component = Components::Section.new(title: 'Test Section', content: 'Content here')
    html = component.call
    assert_includes(html, '<section')
    assert_includes(html, 'Test Section')
    assert_includes(html, 'Content here')
    assert_includes(html, 'font-display')
  end

  test('renders section with title and subtitle') do
    component = Components::Section.new(
      title: 'Main', 
      subtitle: 'Sub', 
      content: 'Body content'
    )
    html = component.call
    assert_includes(html, 'Main')
    assert_includes(html, 'Sub')
    assert_includes(html, 'text-secondary')
    assert_includes(html, 'Body content')
  end

  test('renders section without title') do
    component = Components::Section.new(content: 'Just content')
    html = component.call
    assert_includes(html, '<section')
    assert_includes(html, 'Just content')
    assert_includes(html, '</section>')
  end

  test('accepts custom html attributes') do
    component = Components::Section.new(
      class: 'custom-class',
      id: 'main-section',
      content: 'Content'
    )
    html = component.call
    assert_includes(html, 'custom-class')
    assert_includes(html, 'id="main-section"')
  end
end
