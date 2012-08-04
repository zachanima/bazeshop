require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  def setup
    @shop = FactoryGirl.build(:shop)
  end

  test 'should save shop on valid input' do
    assert @shop.save
  end

  test 'should save multiple shops on valid input' do
    @shop.save
    shop = FactoryGirl.build(:shop)
    assert shop.save
  end

  test 'should not save shop without name' do
    @shop.name = nil
    assert !@shop.save
  end

  test 'should not save shop with empty name' do
    @shop.name = ''
    assert !@shop.save
  end

  test 'should not save shop without link' do
    @shop.link = nil
    assert !@shop.save
  end

  test 'should not save shop with empty link' do
    @shop.link = ''
    assert !@shop.save
  end

  test 'should not save shop with similar link' do
    @shop.save
    shop = FactoryGirl.build(:shop)
    shop.link = @shop.link
    assert !shop.save
  end
end
