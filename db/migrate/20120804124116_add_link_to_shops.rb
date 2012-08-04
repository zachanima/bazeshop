class AddLinkToShops < ActiveRecord::Migration
  def change
    add_column :shops, :link, :string
  end
end
