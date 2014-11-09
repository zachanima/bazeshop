class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def index
    @orders = current_user.orders
  end

  def create
    @order = current_user.orders.build(params[:order])
    @order.line_items << current_user.line_items.current
    @order.gross_price = @order.line_items.collect(&:gross_price).compact.inject(&:+)
    @order.net_price = @order.line_items.collect(&:net_price).compact.inject(&:+)
    @order.user_name = current_user.name

    valid = true

    @order.fields = String.new
    receipt_emails = Array.new
    if params[:fields]
      params[:fields].each do |field|
        found_field = Field.find field[:id].to_i
        if field[:text].blank?
          if found_field.required
            valid = false
            break
          end
        else 
          if found_field.is_receipt_email
            receipt_emails << field[:text]
          end
          @order.fields << "#{found_field.text}: #{field[:text]}\n"
        end
      end
    end

    if valid
      @order.save
      current_user.balance -= @order.gross_price if current_user.balance and @order.gross_price
      current_user.save

      OrderMailer.receipt(@order).deliver unless @order.user.email.blank?
      OrderMailer.manager_receipt(@order).deliver unless @order.user.manager.nil? or @order.user.manager.email.blank?
      OrderMailer.master_receipt(@order).deliver unless @order.user.is_demo

      receipt_emails.each do |email|
        puts email
        OrderMailer.user_receipt(@order, email).deliver unless email.blank?
      end

      redirect_to shop_order_path(@shop, @order)
    else
      redirect_to shop_line_items_path(@shop)
    end
  end

  def show
    @order = current_user.orders.find params[:id]
  end
end
