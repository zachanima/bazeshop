class AddTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :text, :text
  end
end
