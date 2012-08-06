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
end
