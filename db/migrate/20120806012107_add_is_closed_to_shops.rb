class AddIsClosedToShops < ActiveRecord::Migration
  def change
    add_column :shops, :is_closed, :boolean
  end
end
