ENV['RAILS_ENV'] ||= 'test'
require_relative('../config/environment')
require('rails/test_help')
require('capybara/minitest')
require('capybara_accessible_selectors')
Capybara.test_id = 'data-test-id'
Capybara.enable_aria_label = true
require_relative('controller_test')

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures(:all)

    # Add more helper methods to be used by all tests here...
  end
end
