class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!
  layout 'admin'

  def authenticate!
    authenticate_or_request_with_http_basic do |login, password|
      login == 'login' && password == 'password'
    end
  end

private
  def find_shop
    id = params[:shop_id] || params[:id]
    @shop = Shop.find_by_link(id) || Shop.find(id)
  end
end
