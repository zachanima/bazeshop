class User::SessionsController < Devise::SessionsController
  def new
    @shop = Shop.find params[:id]
  end

  private
  def after_sign_in_path_for resource
    @shop = Shop.find params[:id]
  end

  def after_sign_out_path_for resource
    @shop = Shop.find params[:id]
  end
end
