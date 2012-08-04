ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def assert_presence_of model, attribute
    model.assign_attributes(attribute => nil)
    assert !model.valid?, "Saved without #{attribute.to_s}"
  end
end
