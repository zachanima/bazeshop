require 'test_helper'

class Admin::ShopsTest < ActionDispatch::IntegrationTest
  test 'creating with valid input' do
    visit new_admin_shop_path
    fill_in 'Name', with: 'foo'
    fill_in 'Link', with: 'bar'
    select 'English', from: 'Locale'
    click_button 'Create Shop'
    assert_equal edit_admin_shop_path(Shop.last), current_path
  end

  test 'creating with invalid input' do
    visit new_admin_shop_path
    fill_in 'Link', with: 'bar'
    select 'English', from: 'Locale'
    click_button 'Create Shop'
    assert_equal admin_shops_path, current_path
  end

  test 'updating with valid input' do
    shop = FactoryGirl.create(:shop)
    visit edit_admin_shop_path(shop)
    fill_in 'Name', with: 'foo'
    fill_in 'Link', with: 'bar'
    click_button 'Update Shop'
    assert_equal edit_admin_shop_path(shop), current_path
  end

  test 'updating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit edit_admin_shop_path(shop)
    fill_in 'Name', with: 'foo'
    fill_in 'Link', with: ''
    click_button 'Update Shop'
    assert_equal admin_shop_path(shop), current_path
  end
end
