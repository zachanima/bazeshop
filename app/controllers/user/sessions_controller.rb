class User::SessionsController < Devise::SessionsController
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
  def after_sign_in_path_for resource
    unless resource.is_active
      sign_out(:user)
    end

    id = params[:shop_id] || params[:id]
    @shop || Shop.find_by_link(id) || Shop.find(id)
  end

  def after_sign_out_path_for resource
    @shop
  end
end
