source('https://rubygems.org')

gem('rails', '~> 8.1.4', '>= 8.1.4.1')
gem('sqlite3', '>= 2.1')
gem('puma', '>= 5.0')
gem('propshaft')
gem('importmap-rails')
gem('turbo-rails')
gem('stimulus-rails')
gem('bootsnap', require: false)
gem('haml-rails', '~> 3.0')
gem('tailwindcss-rails', '~> 4.0')
gem('tailwindcss-ruby', '~> 4.0')
gem('phlex', '~> 1.10')
gem('phlex-rails', '~> 1.2.2')
gem('literal', '~> 0.1')

group(:development, :test) do
  gem('haml_lint', require: false)
  gem('minitest', '~> 5.0')
  gem('rubocop', '~> 1.81', require: false)
end

group(:test) do
  gem('capybara', '~> 3.40')
  gem('capybara_accessible_selectors', git: 'https://github.com/citizensadvice/capybara_accessible_selectors', tag: 'v0.12.0')
end
