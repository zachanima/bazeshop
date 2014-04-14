class AddTermsToShops < ActiveRecord::Migration
  def change
    add_column :shops, :terms, :text
  end
end
