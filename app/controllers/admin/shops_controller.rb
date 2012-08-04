class Admin::ShopsController < ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new params[:shop]
    if @shop.save
      redirect_to edit_admin_shop_path(@shop)
    else
      render :new
    end
  end

  def edit
    @shop = Shop.find params[:id]
  end

  def update
    @shop = Shop.find params[:id]
    if @shop.update_attributes params[:shop]
      redirect_to edit_admin_shop_path(@shop)
    else
      render :edit
    end
  end
end
