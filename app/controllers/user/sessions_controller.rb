class User::SessionsController < Devise::SessionsController
  before_filter :find_shop

  def new
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
    id = params[:shop_id] || params[:id]
    @shop || Shop.find_by_link(id) || Shop.find(id)
  end
end
