class AddReorderPeriodToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :reorder_period, :integer
  end
end
