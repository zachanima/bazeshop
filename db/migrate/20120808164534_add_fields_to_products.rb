class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :number, :string
    add_column :products, :supplier_number, :string
    add_column :products, :brand, :string
    add_column :products, :text, :text
    add_column :products, :gross_price, :decimal, precision: 8, scale: 2
    add_column :products, :net_price, :decimal, precision: 8, scale: 2
    add_column :products, :environment_fee, :decimal, precision: 8, scale: 2
    add_column :products, :parcel_size, :integer
  end
end
