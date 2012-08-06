class Admin::ShopsController < Admin::ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new params[:shop]
    if @shop.save
      redirect_to edit_admin_shop_path(@shop), notice: 'Created shop.'
    else
      flash[:error] = 'Error while creating shop.'
      render :new
    end
  end

  def edit
    @shop = Shop.find params[:id]
  end

  def update
    @shop = Shop.find params[:id]
    if @shop.update_attributes params[:shop]
      redirect_to edit_admin_shop_path(@shop), notice: 'Updated shop.'
    else
      flash[:error] = 'Error while updating shop.'
      render :edit
    end
  end
end
