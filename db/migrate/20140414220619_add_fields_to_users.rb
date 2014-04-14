class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fields, :text
  end
end
