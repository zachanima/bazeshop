class AddNetPriceAndGrossPriceToOptions < ActiveRecord::Migration
  def change
    add_column :options, :net_price, :decimal, precision: 8, scale: 2
    add_column :options, :gross_price, :decimal, precision: 8, scale: 2
  end
end
