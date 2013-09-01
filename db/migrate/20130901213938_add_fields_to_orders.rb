class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fields, :text
  end
end
