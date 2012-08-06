require 'test_helper'

class Admin::ShopsTest < ActionDispatch::IntegrationTest
  def create_with_valid_input
    visit admin_root_path
    click_link 'New shop'
    fill_in 'Name', with: 'foo'
    fill_in 'Link', with: 'bar'
    select 'English', from: 'Locale'
    click_button 'Create Shop'
  end

  def update_with_valid_input
    @shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Edit shop'
    fill_in 'Name', with: 'foobar'
    click_button 'Update Shop'
  end

  test 'creates in navigation menu' do
    create_with_valid_input
    within 'nav' do
      assert has_content? 'foo'
    end
  end

  test 'has edit link in navigation menu' do
    create_with_valid_input
    within 'nav' do
      assert has_content? 'Edit shop'
    end
  end

  test 'creating with valid input' do
    create_with_valid_input
    assert_equal edit_admin_shop_path(Shop.last), current_path
  end

  test 'creating with invalid input' do
    visit admin_root_path
    click_link 'New shop'
    click_button 'Create Shop'
    assert_equal admin_shops_path, current_path
  end

  test 'creating with all fields' do
    visit admin_root_path
    click_link 'New shop'
    fill_in 'Name', with: 'foo'
    fill_in 'Link', with: 'bar'
    select 'English', from: 'Locale'
    fill_in 'Login text', with: 'baz'
    fill_in 'Password text', with: 'foobar'
    fill_in 'Text', with: 'lorem ipsum dolor sit amet'
    fill_in 'Currency', with: 'points'
    fill_in 'Border style', with: '#000'
    fill_in 'Link style', with: '#ff9'
    fill_in 'Custom style', with: 'body { background-color: #eee }'
    fill_in 'Receipt text', with: 'lorem ipsum dolor sit amet'
    fill_in 'Correspondent', with: 'foo@example.com'
    fill_in 'Shipping price', with: 123.45
    fill_in 'Free shipping over', with: 543.21
    find(:css, "#shop_is_closed[value='1']").set true
    click_button 'Create Shop'
    assert_equal edit_admin_shop_path(Shop.last), current_path
  end

  test 'flash notice when creating with valid input' do
    create_with_valid_input
    assert has_selector? 'div#notice'
  end

  test 'flash error when creating with invalid input' do
    visit admin_root_path
    click_link 'New shop'
    click_button 'Create Shop'
    assert has_selector? 'div#error'
  end

  test 'updating with valid input' do
    update_with_valid_input
    assert_equal edit_admin_shop_path(@shop), current_path
  end

  test 'updating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Edit shop'
    fill_in 'Name', with: ''
    click_button 'Update Shop'
    assert_equal admin_shop_path(shop), current_path
  end

  test 'flash notice when updating with valid input' do
    update_with_valid_input
    assert has_selector? 'div#notice'
  end

  test 'flash error when updating with invalid input' do
    shop = FactoryGirl.create(:shop)
    visit admin_root_path
    click_link 'Edit shop'
    fill_in 'Name', with: ''
    click_button 'Update Shop'
    assert has_selector? 'div#error'
  end
end
