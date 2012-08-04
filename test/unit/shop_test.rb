require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  def setup
    @shop = FactoryGirl.build(:shop)
  end

  test 'should save on valid input' do
    assert @shop.save, 'Did not save on valid input'
  end

  test 'should save multiple on valid input' do
    @shop.save
    shop = FactoryGirl.build(:shop)
    assert shop.save, 'Did not save multiple on valid input'
  end

  test 'should not save without name' do
    @shop.name = nil
    assert !@shop.save, 'Saved without name'
  end

  test 'should not save with empty name' do
    @shop.name = ''
    assert !@shop.save, 'Saved with empty name'
  end

  test 'should not save without link' do
    @shop.link = nil
    assert !@shop.save, 'Saved without link'
  end

  test 'should not save with empty link' do
    @shop.link = ''
    assert !@shop.save, 'Saved with empty link'
  end

  test 'should not save with nonunique link' do
    @shop.save
    shop = FactoryGirl.build(:shop)
    shop.link = @shop.link
    assert !shop.save, 'Saved with nonunique link'
  end

  test 'should parameterize link' do
    @shop.link = 'Fo/o-ba#r'
    @shop.save
    assert_equal 'fo-o-ba-r', @shop.link
  end

  test 'should not save shop without locale' do
    @shop.locale = nil
    assert !@shop.save, 'Saved shop without locale'
  end
  
  test 'should not save shop with invalid locale' do
    @shop.locale = 'xx'
    assert !@shop.save, 'Saved shop with invalid locale'
  end
end
