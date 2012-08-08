require 'test_helper'

class Admin::ProductsTest < ActionDispatch::IntegrationTest
  def create_with_valid_input
    @shop = FactoryGirl.create :shop
    visit new_admin_shop_product_path(@shop)
    fill_in 'Name', with: 'foo'
    click_button 'Create Product'
  end

  test 'exists in list of products' do
    shop = FactoryGirl.create(:product).shop
    visit admin_shop_products_path(shop)
    within 'div#content table#products' do
      assert has_content? 'foo'
    end
  end

  test 'has no errors when creating with valid input' do
    create_with_valid_input
    assert has_no_selector?('div.field_with_errors')
  end

  test 'redirects after creating with valid input' do
    create_with_valid_input
    assert_equal admin_shop_products_path(@shop), current_path
  end
end
