class Admin::UsersController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @users = @shop.users
  end

  def new
    @user = @shop.users.build
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password]
    params[:user][:plaintext_password] = params[:user][:password]
    @user = @shop.users.build params[:user]

    if @user.save
      redirect_to admin_shop_users_path(@shop), notice: 'Created user.'
    else
      flash[:error] = 'Error while creating user.'
      render :new
    end
  end

  def edit
    @user = @shop.users.find params[:id]
  end

  def update
    params[:user][:password_confirmation] = params[:user][:password]
    params[:user][:plaintext_password] = params[:user][:password]
    @user = @shop.users.find params[:id]
    
    if @user.update_attributes params[:user]
      redirect_to admin_shop_users_path(@shop), notice: 'Updated user.'
    else
      flash[:error] = 'Error while updating user.'
      render :edit
    end
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
