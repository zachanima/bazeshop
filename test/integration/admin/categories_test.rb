require 'test_helper'

class Admin::CategoriesTest < ActionDispatch::IntegrationTest
  def create_with_valid_input
    @shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    fill_in 'Name', with: 'foo'
    select '', from: 'Parent'
    click_button 'Create Category'
  end
    
  test 'listing categories' do
    FactoryGirl.create(:category)
    visit admin_root_path
    click_link 'Categories'
    within 'div#content table' do
      assert has_content? 'foo'
    end
  end

  test 'creating with valid input' do
    create_with_valid_input
    assert has_no_selector?('div.field_with_errors')
  end

  test 'redirect after creating with valid input' do
    create_with_valid_input
    assert_equal admin_shop_categories_path(@shop), current_path
  end

  test 'creating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    click_button 'Create Category'
    assert has_selector?('div.field_with_errors')
  end

  test 'redirect after creating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    click_button 'Create Category'
    assert_equal admin_shop_categories_path(shop), current_path
  end

  test 'creating with valid parent' do
    shop = FactoryGirl.create(:category).shop
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    fill_in 'Name', with: 'bar'
    select 'foo', from: 'Parent'
    click_button 'Create Category'
    assert_equal admin_shop_categories_path(shop), current_path
  end

  test 'flash notice when creating with valid input' do
    create_with_valid_input
    assert has_selector? 'div#notice'
  end

  test 'flash error when creating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Categories'
    click_link 'New category'
    click_button 'Create Category'
    assert has_selector? 'div#error'
  end
end
