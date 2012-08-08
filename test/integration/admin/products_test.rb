require 'test_helper'

class Admin::ProductsTest < ActionDispatch::IntegrationTest
  test 'exists in list of products' do
    shop = FactoryGirl.create(:product).shop
    visit admin_shop_products_path(shop)
    within 'div#content table#products' do
      assert has_content? 'foo'
    end
  end
end
