class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_shop
  before_filter :sign_out_on_wrong_shop

  def new
  end
  
  def sign_out_on_wrong_shop
    if current_user and current_user.shop != @shop
      sign_out_and_redirect(current_user)
    end
  end

private
  def find_shop
    id = params[:shop_id] || params[:id]
    @shop = Shop.find_by_link(id) || Shop.find(id)
  end
end
