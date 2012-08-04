class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :shop

      t.timestamps
    end
    add_index :categories, :shop_id
  end
end
