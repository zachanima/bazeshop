require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should belong_to(:category)
  should have_one(:shop)

  should allow_mass_assignment_of(:name)
  should allow_mass_assignment_of(:number)
  should allow_mass_assignment_of(:supplier_number)
  should allow_mass_assignment_of(:brand)
  should allow_mass_assignment_of(:text)
  should allow_mass_assignment_of(:category_id)
  should allow_mass_assignment_of(:gross_price)
  should allow_mass_assignment_of(:net_price)
  should allow_mass_assignment_of(:environment_fee)
  should allow_mass_assignment_of(:parcel_size)
  should validate_numericality_of(:gross_price)
  should validate_numericality_of(:net_price)
  should validate_numericality_of(:environment_fee)
  should validate_numericality_of(:parcel_size).only_integer
  should validate_presence_of(:name)
  should validate_presence_of(:category)

  def setup
    @product = FactoryGirl.create(:product)
  end

  test 'saves on valid input' do
    assert @product.save, 'Did not save on valid input'
  end

  test 'destroys' do
    assert_difference 'Product.count', -1 do
      @product.destroy
    end
  end
end
