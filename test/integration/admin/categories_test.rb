require 'test_helper'

class Admin::CategoriesTest < ActionDispatch::IntegrationTest
  def create_with_valid_input
    @shop = FactoryGirl.create :shop
    visit new_admin_shop_category_path(@shop)
    fill_in 'Name', with: 'foo'
    click_button 'Create Category'
  end

  def update_with_valid_input
    @shop = FactoryGirl.create :shop
    @category = FactoryGirl.create(:category, shop: @shop)
    visit edit_admin_shop_category_path(@shop, @category)
    fill_in 'Name', with: 'foobar'
    click_button 'Update Category'
  end
    
  test 'exists in list of categories' do
    shop = FactoryGirl.create(:category).shop
    visit admin_shop_categories_path(shop)
    within 'div#content ol.categories' do
      assert has_content? 'foo'
    end
  end

  test 'has no errors when creating with valid input' do
    create_with_valid_input
    assert has_no_selector?('div.field_with_errors')
  end

  test 'redirects after creating with valid input' do
    create_with_valid_input
    assert_equal admin_shop_categories_path(@shop), current_path
  end

  test 'has errors when creating with invalid input' do
    shop = FactoryGirl.create :shop
    visit new_admin_shop_category_path(shop)
    click_button 'Create Category'
    assert has_selector?('div.field_with_errors')
  end

  test 'redirects after creating with invalid input' do
    shop = FactoryGirl.create :shop
    visit new_admin_shop_category_path(shop)
    click_button 'Create Category'
    assert_equal admin_shop_categories_path(shop), current_path
  end

  test 'creates with valid parent' do
    shop = FactoryGirl.create(:category).shop
    visit new_admin_shop_category_path(shop)
    fill_in 'Name', with: 'bar'
    select 'foo', from: 'Parent'
    click_button 'Create Category'
    assert_equal admin_shop_categories_path(shop), current_path
  end

  test 'flashes notice when creating with valid input' do
    create_with_valid_input
    assert has_selector? 'div#notice'
  end

  test 'flashes error when creating with invalid input' do
    shop = FactoryGirl.create :shop
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    click_button 'Create Category'
    assert has_selector? 'div#error'
  end

  test 'redirects to referer when cancelling creating' do
    create_with_valid_input
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    click_link 'Cancel'
    assert_equal admin_shop_categories_path(@shop), current_path
  end

  test 'updates with valid input' do
    update_with_valid_input
    assert_equal admin_shop_categories_path(@shop), current_path
  end

  test 'updates with invalid input' do
    category = FactoryGirl.create :category
    visit admin_root_path
    click_link 'Categories'
    within 'div#content ol.categories' do
      click_link 'foo'
    end
    fill_in 'Name', with: ''
    click_button 'Update Category'
    assert_equal admin_shop_category_path(category.shop, category), current_path
  end

  test 'flashes notice when updating with valid input' do
    update_with_valid_input
    assert has_selector? 'div#notice'
  end

  test 'flashes error when updating with invalid input' do
    category = FactoryGirl.create(:category)
    visit edit_admin_shop_category_path(category.shop, category)
    fill_in 'Name', with: ''
    click_button 'Update Category'
    assert has_selector? 'div#error'
  end

  test 'redirects to referer when cancelling updating' do
    shop = FactoryGirl.create(:category).shop
    visit admin_shop_categories_path(shop)
    within 'div#content ol.categories' do
      click_link 'foo'
    end
    click_link 'Cancel'
    assert_equal admin_shop_categories_path(shop), current_path
  end

  test 'destroys' do
    category = FactoryGirl.create(:category)
    assert_difference 'Category.count', -1 do
      page.driver.delete admin_shop_category_path(category.shop, category)
    end
  end
end
