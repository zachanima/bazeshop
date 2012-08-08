require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should belong_to(:category)

  should allow_mass_assignment_of(:name)
  should allow_mass_assignment_of(:category_id)

  should validate_presence_of(:name)
  should validate_presence_of(:category)

  def setup
    @product = FactoryGirl.create(:product)
  end

  test 'saves on valid input' do
    assert @product.save, 'Did not save on valid input'
  end

  test 'saves multiple on valid input' do
    product = FactoryGirl.build(:product)
    assert product.save, 'Did not save multiple on valid input'
  end
end
