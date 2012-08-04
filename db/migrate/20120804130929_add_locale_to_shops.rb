class AddLocaleToShops < ActiveRecord::Migration
  def change
    add_column :shops, :locale, :string
  end
end
