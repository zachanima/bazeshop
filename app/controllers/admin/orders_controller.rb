class Admin::OrdersController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @orders = @shop.orders
  end

  def destroy
    @shop.orders.find(params[:id]).destroy
    redirect_to admin_shop_orders_path(@shop)
  end
end
