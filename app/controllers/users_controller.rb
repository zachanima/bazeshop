class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def index
    redirect_to @shop unless current_user.superuser

    @users = @shop.users
    @user = @shop.users.build
  end
end
