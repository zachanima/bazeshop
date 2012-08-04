require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  def setup
    @shop = FactoryGirl.build(:shop)
  end

  test 'saving on valid input' do
    assert @shop.save, 'Did not save on valid input'
  end

  test 'saving multiple on valid input' do
    @shop.save
    shop = FactoryGirl.build(:shop)
    assert shop.save, 'Did not save multiple on valid input'
  end

  test 'invalid without name' do
    assert_presence_of @shop, :name
  end

  test 'invalid without link' do
    assert_presence_of @shop, :link
  end

  test 'invalid with nonunique link' do
    @shop.save
    shop = FactoryGirl.build(:shop, link: @shop.link)
    assert !shop.save, 'Saved with nonunique link'
  end

  test 'parameterize link' do
    @shop.link = 'Fo/o-ba#r'
    @shop.save
    assert_equal 'fo-o-ba-r', @shop.link
  end

  test 'invalid without locale' do
    assert_presence_of @shop, :locale
  end

  test 'invalid with wrong locale' do
    @shop.locale = 'xx'
    assert !@shop.save, 'Saved with invalid locale'
  end
end
