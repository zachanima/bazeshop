class AddProductGrossPriceAndProductNetPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :product_gross_price, :decimal, precision: 8, scale: 2
    add_column :line_items, :product_net_price, :decimal, precision: 8, scale: 2
  end
end
