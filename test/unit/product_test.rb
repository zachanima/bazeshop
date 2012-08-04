require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = FactoryGirl.build(:product)
  end

  test 'should save on valid input' do
    assert @product.save, 'Did not save on valid input'
  end

  test 'should save multiple on valid input' do
    @product.save
    product = FactoryGirl.build(:product)
    assert product.save, 'Did not save multiple on valid input'
  end

  test 'should not save without name' do
    @product.name = nil
    assert !@product.save, 'Saved without name'
  end

  test 'should not save with empty name' do
    @product.name = nil
    assert !@product.save, 'Saved with empty name'
  end

  test 'should not save without category' do
    @product.category = nil
    assert !@product.save, 'Saved without category'
  end

  test 'should not save with nonexistent category' do
    @product.category_id = 0
    assert !@product.save, 'Saved without category'
  end
end
