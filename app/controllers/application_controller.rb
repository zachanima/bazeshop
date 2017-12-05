class ApplicationController < ActionController::Base
  protect_from_forgery

  def new
  end

private
  def find_shop
    id = params[:shop_id] || params[:id]
    @shop = Shop.find_by_link(id) || Shop.find(id)
  end
end
