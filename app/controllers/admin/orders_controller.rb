class Admin::OrdersController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @orders = @shop.orders
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
