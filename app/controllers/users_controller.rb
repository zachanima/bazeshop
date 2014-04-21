class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def index
    redirect_to @shop unless current_user.superuser

    @users = @shop.users
    @user = @shop.users.build
  end

  def create
    redirect_to @shop unless current_user.superuser

    params[:user][:password_confirmation] = params[:user][:password]
    params[:user][:plaintext_password] = params[:user][:password]
    @user = @shop.users.build params[:user]
    @user.balance = @user.budget

    if @user.save
      redirect_to(shop_users_path @shop)
    else
      flash[:error] = 'Kunne ikke oprette bruger.'
      @users = @shop.users
      render :index
    end
  end
end
