require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = FactoryGirl.build(:category)
  end

  test 'saving on valid input' do
    assert @category.save, 'Did not save on valid input'
  end

  test 'saving multiple on valid input' do
    @category.save
    category = FactoryGirl.build(:category)
    assert category.save, 'Did not save multiple on valid input'
  end

  test 'invalid without name' do
    assert_presence_of @category, :name
  end

  test 'invalid without shop' do
    assert_presence_of @category, :shop_id
  end

  test 'valid with parent' do
    @category.save
    category = FactoryGirl.build(:category, parent: @category)
    assert category.save, 'Did not save with parent'
  end

  test 'valid without parent' do
    @category.parent = nil
    assert @category.save, 'Did not save without parent'
  end

  test 'invalid with nonexistent parent' do
    @category.parent_id = 0
    assert !@category.save, 'Saved with nonexistent parent'
  end


  test 'invalid with self as parent' do
    @category.save
    @category.parent_id = @category.id
    assert !@category.save, 'Saved with self as parent'
  end
end
