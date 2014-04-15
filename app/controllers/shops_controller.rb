class ShopsController < ApplicationController
  before_filter :authenticate_user!, except: [:pay]
  before_filter :find_shop

  def save_fields
    current_user.fields = params['fields']
    current_user.save
  end

  def pay
    render :pay
  end

  def payment_fail

  end

  def payment_ok
    @shop.free_shipping_over = 1000000 if not @shop.free_shipping_over
    @order = current_user.orders.build
    @order.line_items << current_user.line_items.current
    @order.gross_price = @order.line_items.collect(&:gross_price).compact.inject(&:+)
    @order.net_price = @order.line_items.collect(&:net_price).compact.inject(&:+)
    @order.user_name = current_user.name
    @order.transaction_id = params['OrderID']
    if @shop.shipping_price and @order.gross_price and @order.gross_price < @shop.free_shipping_over
      @order.payment = (@order.gross_price + @shop.shipping_price - current_user.balance)
    else
      @order.payment = @order.gross_price - current_user.balance
    end
    @order.payment *= 1.25 if @shop.add_vat
    @order.fields = current_user.fields
    # TODO: VAT

    valid = true

    @order.fields = String.new if not @order.fields

    if valid
      @order.save
      current_user.balance = 0 if current_user.balance and current_user.balance > 0 # Assume balance dropped to 0
      current_user.save

      OrderMailer.receipt(@order).deliver unless @order.user.email.blank?
      OrderMailer.manager_receipt(@order).deliver unless @order.user.manager.nil? or @order.user.manager.email.blank?
      OrderMailer.master_receipt(@order).deliver unless @order.user.is_demo
    end
  end
end
