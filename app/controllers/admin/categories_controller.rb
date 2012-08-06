class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @categories = @shop.categories.where parent_id: nil
  end

  def new
    @category = @shop.categories.build
  end

  def create
    @category = @shop.categories.build params[:category]
    if @category.save
      redirect_to admin_shop_categories_path(@shop), notice: 'Created category.'
    else
      flash[:error] = 'Error while creating category.'
      render :new
    end
  end
private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
