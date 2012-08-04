require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = FactoryGirl.build(:product)
  end

  test 'saving on valid input' do
    assert @product.save, 'Did not save on valid input'
  end

  test 'saving multiple on valid input' do
    @product.save
    product = FactoryGirl.build(:product)
    assert product.save, 'Did not save multiple on valid input'
  end

  test 'invalid without name' do
    assert_presence_of @product, :name
  end

  test 'invalid without category' do
    assert_presence_of @product, :category_id
  end
end
