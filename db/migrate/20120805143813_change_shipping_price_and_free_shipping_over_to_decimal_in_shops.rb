class ChangeShippingPriceAndFreeShippingOverToDecimalInShops < ActiveRecord::Migration
  def up
    change_column :shops, :shipping_price, :decimal, precision: 8, scale: 2
    change_column :shops, :free_shipping_over, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :shops, :shipping_price, :float
    change_column :shops, :free_shipping_over, :float
  end
end
