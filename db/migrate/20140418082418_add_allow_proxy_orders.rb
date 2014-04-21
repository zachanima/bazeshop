class AddAllowProxyOrders < ActiveRecord::Migration
  def change
    add_column :shops, :allow_proxy_orders, :boolean
  end
end
