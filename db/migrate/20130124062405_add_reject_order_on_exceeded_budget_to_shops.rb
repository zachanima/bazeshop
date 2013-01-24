class AddRejectOrderOnExceededBudgetToShops < ActiveRecord::Migration
  def change
    add_column :shops, :reject_order_on_exceeded_budget, :boolean
  end
end
