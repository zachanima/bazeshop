class RenameBorderStyleToHeaderStyleInShops < ActiveRecord::Migration
  def up
    rename_column :shops, :border_style, :header_style
  end

  def down
    rename_column :shops, :header_style, :border_style
  end
end
