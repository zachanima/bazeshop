class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :user_name
      t.decimal :gross_price, precision: 8, scale: 2
      t.decimal :net_price, precision: 8, scale: 2
      t.references :user

      t.timestamps
    end
  end
end
