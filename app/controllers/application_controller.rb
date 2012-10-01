class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def find_shop
    id = params[:shop_id] || params[:id]
    @shop = Shop.find_by_link(id) || Shop.find(id)
  end
end
