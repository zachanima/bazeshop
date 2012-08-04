require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = FactoryGirl.build(:category)
  end

  test 'should save on valid input' do
    assert @category.save, 'Did not save on valid input'
  end

  test 'should save multiple on valid input' do
    @category.save
    category = FactoryGirl.build(:category)
    assert category.save, 'Did not save multiple on valid input'
  end

  test 'should not save without name' do
    @category.name = nil
    assert !@category.save, 'Saved without name'
  end

  test 'should not save with empty name' do
    @category.name = nil
    assert !@category.save, 'Saved with empty name'
  end

  test 'should not save without shop' do
    @category.shop = nil
    assert !@category.save, 'Saved without shop'
  end

  test 'should not save with nonexistent shop' do
    @category.shop_id = 256
    assert !@category.save, 'Saved without shop'
  end
end
