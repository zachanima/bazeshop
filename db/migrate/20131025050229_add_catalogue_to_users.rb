class AddCatalogueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_catalogue, :boolean
  end
end
