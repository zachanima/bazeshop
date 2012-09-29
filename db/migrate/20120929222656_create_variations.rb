class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.string :option_set_name
      t.string :option_name
      t.decimal :gross_price, precision: 8, scale: 2
      t.decimal :net_price, precision: 8, scale: 2
      t.references :variant
      t.references :line_item

      t.timestamps
    end
    add_index :variations, :variant_id
    add_index :variations, :line_item_id
  end
end
