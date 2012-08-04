require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  test 'should save shop on valid input' do
    shop = FactoryGirl.build(:shop)
    assert shop.save
  end
end
