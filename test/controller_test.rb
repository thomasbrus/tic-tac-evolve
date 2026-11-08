class ControllerTest < ActionDispatch::IntegrationTest
  include(Capybara::Minitest::Assertions)

  def page
    Capybara.string(response.body)
  end
end
