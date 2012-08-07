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

  test 'saving on full valid input' do
    @shop.save
    shop = FactoryGirl.build(:shop_full)
    assert shop.save, 'Did not save on full valid input'
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

  test 'invalid with nonnumerical shipping price' do
    assert_numericality_of @shop, :shipping_price
  end

  test 'invalid with nonnumerical free shipping over' do
    assert_numericality_of @shop, :free_shipping_over
  end

  test 'destroying no associations' do
    @shop.save
    assert_difference 'Shop.count', -1 do false
      @shop.destroy
    end
  end

  test 'destroying with category association' do
    @shop.save
    category = @shop.categories.build
    category.save
    assert_equal false, @shop.can_destroy?
  end

  test 'closing shop' do
    @shop.is_closed = true
    assert_equal true, @shop.closed?
  end

  test 'advanced with custom style' do
    @shop.custom_style = 'body { background-color: red }'
    assert_equal true, @shop.advanced?
  end

  test 'advanced with receipt text' do
    @shop.receipt_text = 'lorem ipsum dolor sit amet'
    assert_equal true, @shop.advanced?
  end

  test 'advanced with correspondent' do
    @shop.correspondent = 'foo@example.com'
    assert_equal true, @shop.advanced?
  end

  test 'advanced with shipping price' do
    @shop.shipping_price = 123.45
    assert_equal true, @shop.advanced?
  end

  test 'advanced with free shipping over' do
    @shop.free_shipping_over = 543.21
    assert_equal true, @shop.advanced?
  end

  test 'advanced when closed' do
    @shop.is_closed = true
    assert_equal true, @shop.advanced?
  end

  test 'not advanced without advanced field' do
    assert_equal false, @shop.advanced?
  end
end
