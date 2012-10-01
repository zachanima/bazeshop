require 'csv'

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

  def destroy
    @shop.users.find(params[:id]).destroy
    redirect_to admin_shop_users_path(@shop)
  end

  def edit_multiple
    case params[:commit]
      when 'Set budget'
        set_budget
      when 'Add budget to balance'
        add_budget_to_balance
      when 'Reset balance to budget'
        reset_balance_to_budget
      else
        upload
        return
    end
    redirect_to admin_shop_users_path @shop
  end

  def import
    params[:attributes].reject! do |key, value|
      value['checked'].blank?
    end

    users = Array.new
    params[:attributes].each do |index, values|
      user = Hash.new
      values.each do |key, value|
        field = params[:fields][key]
        if field
          if user[field].blank?
            user[field] = value
          else
            if field == 'address'
              user[field] += "\n#{value}"
            else
              user[field] += " #{value}"
            end
          end
        end
      end
      users << user
    end

    users.each do |user|
      new_user = @shop.users.build
      new_user.password = params[:password]
      new_user.plaintext_password = params[:password]
      new_user.department = params[:department]
      new_user.text = params[:text]
      user.each_pair do |key, value|
        case key
          when 'name'
            new_user.name = value
          when 'login'
            new_user.login = value
          when 'password'
            new_user.password = value
            new_user.plaintext_password = value
          when 'email'
            new_user.email = value
          when 'department'
            new_user.department = value
          when 'phone'
            new_user.phone = value
          when 'address'
            new_user.address = value
          when 'text'
            new_user.text = value
        end
      end
      unless new_user.save
        flash[:error] = 'Error while importing users, please check list.'
      end
    end
    
    flash[:notice] = 'Imported users.' if flash[:error].blank?
    redirect_to admin_shop_users_path @shop
  end

private
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

  def upload
    @csv = CSV.parse params[:upload].read
    render :upload
  end
end
