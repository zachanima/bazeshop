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
    @user.is_active = true

    if @user.save
      redirect_to(shop_users_path @shop)
    else
      flash[:error] = 'Kunne ikke oprette bruger.'
      @users = @shop.users
      render :index
    end
  end

  def activate
    params[:user_ids].each do |user_id|
      user = User.find(user_id)
      if user.shop == @shop
        user.is_active = true
        user.save
      end
    end
    redirect_to shop_users_path(@shop)
  end

  def deactivate
    params[:user_ids].each do |user_id|
      user = User.find(user_id)
      if user.shop == @shop
        user.is_active = false
        user.save
      end
    end
    redirect_to shop_users_path(@shop)
  end
end
