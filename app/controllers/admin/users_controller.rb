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

  def edit_multiple
    case params[:commit]
      when 'Set budget'
        set_budget
      when 'Add budget to balance'
        add_budget_to_balance
      when 'Reset balance to budget'
        reset_balance_to_budget
    end
    redirect_to admin_shop_users_path @shop
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end

  def set_budget
    unless params[:budget].blank?
      users = @shop.users.find(params[:user_ids])
      users.each do |user|
        user.budget = params[:budget]
        user.save
      end
      flash[:notice] = "Set budget for #{users.count} users."
    else
      flash[:error] = 'Error while setting budget for users'
    end
  end

  def add_budget_to_balance
    users = @shop.users.find params[:user_ids]
    users.each do |user|
      if user.balance
        user.balance += user.budget if user.budget
      else
        user.balance = user.budget if user.budget
      end
      user.save
    end
    flash[:notice] = "Added budget to balance for #{users.count} users."
  end

  def reset_balance_to_budget
    users = @shop.users.find params[:user_ids]
    users.each do |user|
      user.balance = user.budget
      user.save
    end
    flash[:notice] = "Reset balance to budget for #{users.count} users."
  end
end
