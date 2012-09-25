class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.decimal :net_price, precision: 8, scale: 2
      t.decimal :gross_price, precision: 8, scale: 2
      t.references :option
      t.references :product

      t.timestamps
    end
    add_index :variants, :option_id
    add_index :variants, :product_id
  end
end
