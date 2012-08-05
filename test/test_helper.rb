ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

class ActiveSupport::TestCase
  def assert_presence_of model, attribute
    model.assign_attributes(attribute => nil)
    assert !model.valid?, "Saved without #{attribute.to_s}"
  end

  def assert_numericality_of model, attribute
    model.assign_attributes(attribute => 'foo')
    assert !model.valid?, "Saved with nonnumerical #{attribute.to_s}"
  end
end
