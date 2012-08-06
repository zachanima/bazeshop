class Admin::ShopsController < Admin::ApplicationController
  before_filter :find_shop, only: [:edit, :update, :destroy]

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

  # def edit

  def update
    if @shop.update_attributes params[:shop]
      redirect_to edit_admin_shop_path(@shop), notice: 'Updated shop.'
    else
      flash[:error] = 'Error while updating shop.'
      render :edit
    end
  end

  def destroy
    if @shop.can_destroy?
      @shop.destroy
      redirect_to admin_root_path, notice: 'Deleted shop.'
    else
      flash[:error] = 'Error while deleting shop.'
      redirect_to request.referer || admin_root_path
    end
  end

private
  def find_shop
    @shop = Shop.find params[:id]
  end
end
