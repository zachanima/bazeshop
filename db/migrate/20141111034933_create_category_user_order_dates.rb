class CreateCategoryUserOrderDates < ActiveRecord::Migration
  def change
    create_table :category_user_order_dates do |t|
      t.references :category
      t.references :user
      t.date :order_date

      t.timestamps
    end
    add_index :category_user_order_dates, :category_id
    add_index :category_user_order_dates, :user_id
  end
end
