class User::SessionsController < Devise::SessionsController
  before_filter :find_shop

  def new
  end

private
  def after_sign_in_path_for resource
    @shop
  end

  def after_sign_out_path_for resource
    @shop
  end
end
