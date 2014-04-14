class ShopsController < ApplicationController
  before_filter :authenticate_user!, except: [:pay]
  before_filter :find_shop

  def pay
    render :pay
  end

  def payment_fail

  end

  def payment_ok
    @order = current_user.orders.build
    @order.line_items << current_user.line_items.current
    @order.gross_price = @order.line_items.collect(&:gross_price).compact.inject(&:+)
    @order.net_price = @order.line_items.collect(&:net_price).compact.inject(&:+)
    @order.user_name = current_user.name
    # TODO: Add transaction ID

    valid = true

    @order.fields = String.new

    if valid
      @order.save
      current_user.balance = 0 if current_user.balance and current_user.balance > 0 # Assume balance dropped below 0
      current_user.save

      OrderMailer.receipt(@order).deliver unless @order.user.email.blank?
      OrderMailer.manager_receipt(@order).deliver unless @order.user.manager.nil? or @order.user.manager.email.blank?
      OrderMailer.master_receipt(@order).deliver unless @order.user.is_demo
    end
  end
end
