require 'test_helper'

class Admin::CategoriesTest < ActionDispatch::IntegrationTest
  test 'listing categories' do
    FactoryGirl.create(:category)
    visit admin_root_path
    click_link 'Categories'
    within 'div#content table' do
      assert has_content? 'foo'
    end
  end

  test 'creating with valid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    fill_in 'Name', with: 'foo'
    select '', from: 'Parent'
    click_button 'Create Category'
    assert_equal admin_shop_categories_path(shop), current_path
  end
end
