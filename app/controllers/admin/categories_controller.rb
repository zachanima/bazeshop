class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @categories = @shop.categories.top
  end

  def new
    # Not using @shop.categories.build, to avoid empty entry in parent dropdown.
    @categories = @shop.categories.top
    @category = Category.new
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
