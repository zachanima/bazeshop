class AddAddVatToShops < ActiveRecord::Migration
  def change
    add_column :shops, :add_vat, :boolean
  end
end
