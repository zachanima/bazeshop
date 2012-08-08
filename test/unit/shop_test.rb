require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  should have_many(:categories)

  should allow_mass_assignment_of(:name)
  should allow_mass_assignment_of(:link)
  should allow_mass_assignment_of(:locale)
  should allow_mass_assignment_of(:login_text)
  should allow_mass_assignment_of(:password_text)
  should allow_mass_assignment_of(:text)
  should allow_mass_assignment_of(:currency)
  should allow_mass_assignment_of(:border_style)
  should allow_mass_assignment_of(:link_style)
  should allow_mass_assignment_of(:receipt_text)
  should allow_mass_assignment_of(:correspondent)
  should allow_mass_assignment_of(:shipping_price)
  should allow_mass_assignment_of(:free_shipping_over)
  should allow_mass_assignment_of(:custom_style)
  should allow_mass_assignment_of(:is_closed)
  should_not allow_value('xx').for(:locale)
  should ensure_inclusion_of(:locale).in_array Shop::Locales.keys.collect(&:to_s)
  should validate_numericality_of(:shipping_price)
  should validate_numericality_of(:free_shipping_over)
  should validate_presence_of(:name)
  should validate_presence_of(:link)
  should validate_presence_of(:locale)
  should validate_uniqueness_of(:link)

  def setup
    @shop = FactoryGirl.create(:shop)
  end

  test 'saves on valid input' do
    assert @shop.save
  end

  test 'saves on full valid input' do
    shop = FactoryGirl.build(:shop_full)
    assert shop.save
  end

  test 'parameterizes link' do
    @shop.link = 'Fo/o-ba#r'
    @shop.save
    assert_equal 'fo-o-ba-r', @shop.link
  end

  test 'destroys no associations' do
    @shop.save
    assert_difference 'Shop.count', -1 do false
      @shop.destroy
    end
  end

  test 'does not destroy with category association' do
    @shop.save
    category = @shop.categories.build
    category.save
    assert_equal false, @shop.can_destroy?
  end

  test 'closes shop' do
    @shop.is_closed = true
    assert_equal true, @shop.closed?
  end

  test 'is advanced with custom style' do
    @shop.custom_style = 'body { background-color: red }'
    assert_equal true, @shop.advanced?
  end

  test 'is advanced with receipt text' do
    @shop.receipt_text = 'lorem ipsum dolor sit amet'
    assert_equal true, @shop.advanced?
  end

  test 'is advanced with correspondent' do
    @shop.correspondent = 'foo@example.com'
    assert_equal true, @shop.advanced?
  end

  test 'is advanced with shipping price' do
    @shop.shipping_price = 123.45
    assert_equal true, @shop.advanced?
  end

  test 'is advanced with free shipping over' do
    @shop.free_shipping_over = 543.21
    assert_equal true, @shop.advanced?
  end

  test 'is advanced when closed' do
    @shop.is_closed = true
    assert_equal true, @shop.advanced?
  end

  test 'is not advanced without advanced field' do
    assert_equal false, @shop.advanced?
  end
end
