require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should belong_to(:shop)
  should belong_to(:parent)
  should have_many(:categories)
  should have_many(:products)

  should allow_mass_assignment_of(:name)
  should allow_mass_assignment_of(:shop_id)
  should allow_mass_assignment_of(:parent_id)
  should validate_presence_of(:name)
  should validate_presence_of(:shop)

  def setup
    @category = FactoryGirl.create(:category)
  end

  test 'saves on valid input' do
    assert @category.save
  end

  test 'saves multiple on valid input' do
    category = FactoryGirl.build(:category)
    assert category.save
  end

  test 'saves with parent' do
    category = FactoryGirl.build(:category, parent: @category)
    assert category.save, 'Did not save with parent'
  end

  test 'saves without parent' do
    @category.parent = nil
    assert @category.save, 'Did not save without parent'
  end

  test 'does not save with nonexistent parent' do
    @category.parent_id = 0
    assert !@category.save, 'Saved with nonexistent parent'
  end

  test 'does not save with self as parent' do
    @category.parent_id = @category.id
    assert !@category.save, 'Saved with self as parent'
  end

  test 'returns correct path' do
    category = FactoryGirl.build(:category, parent: @category)
    assert_equal "#{@category.name} > #{category.name}", category.path
  end

  test 'returns correct nested scope' do
    category = FactoryGirl.create(:category, parent: @category)
    assert @category.categories.nested.include?(category)
  end

  test 'returns correct nested scope with exclusion category' do
    category = FactoryGirl.create(:category, parent: @category)
    assert !@category.categories.nested(category).include?(category)
  end
end
