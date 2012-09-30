class OrderMailer < ActionMailer::Base
  default from: 'username@baze.dk'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.receipt.subject
  #
  def receipt(order)
    @order = order
    @user = @order.user
    @shop = @user.shop

    mail to: @user.email, subject: "#{@shop.name}, Ordre ##{order.id}"
  end

  def manager_receipt(order)
    @order = order
    @user = @order.user
    @manager = @user.manager
    @shop = @user.shop

    mail to: @manager.email, subject: "#{@shop.name}, Ordre ##{order.id}"
  end

  def master_receipt(order)
    @order = order
    @user = @order.user
    @shop = @user.shop

    mail to: 'shop@baze.dk', subject: "#{@shop.name}, Ordre ##{order.id}"
  end
end
