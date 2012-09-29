class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def create
    @shop = Shop.find params[:shop_id]
    @order = current_user.orders.build(params[:order])
    @order.line_items << current_user.line_items.current
    @order.gross_price = @order.line_items.collect(&:gross_price).compact.inject(&:+)
    @order.net_price = @order.line_items.collect(&:net_price).compact.inject(&:+)
    @order.user_name = current_user.name
    @order.save
    redirect_to shop_order_path(@shop, @order)
  end

  def show
    @shop = Shop.find params[:shop_id]
    @order = current_user.orders.find params[:id]
  end
end