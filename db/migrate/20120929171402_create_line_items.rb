class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :product_name
      t.string :product_number
      t.string :supplier_number
      t.string :brand
      t.decimal :gross_price, precision: 8, scale: 2
      t.decimal :net_price, precision: 8, scale: 2
      t.integer :quantity
      t.references :order
      t.references :user
      t.references :product

      t.timestamps
    end
  end
end
