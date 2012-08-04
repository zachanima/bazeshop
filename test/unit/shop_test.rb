require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  test 'should save shop on valid input' do
    shop = FactoryGirl.build(:shop)
    assert shop.save
  end

  test 'should not save shop without name' do
    shop = FactoryGirl.build(:shop)
    shop.name = nil
    assert !shop.save
  end

  test 'should not save shop with empty name' do
    shop = FactoryGirl.build(:shop)
    shop.name = ''
    assert !shop.save
  end

  test 'should not save shop without link' do
    shop = FactoryGirl.build(:shop)
    shop.link = nil
    assert !shop.save
  end

  test 'should not save shop with empty link' do
    shop = FactoryGirl.build(:shop)
    shop.link = ''
    assert !shop.save
  end
end
