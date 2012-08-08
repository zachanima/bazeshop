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
      @categories = @shop.categories.top
      flash[:error] = 'Error while creating category.'
      render :new
    end
  end

  def edit
    @categories = @shop.categories.top
    @category = @shop.categories.find params[:id]
  end

  def update
    @category = @shop.categories.find params[:id]
    if @category.update_attributes params[:category]
      redirect_to admin_shop_categories_path(@shop), notice: 'Updated category.'
    else
      @categories = @shop.categories.top
      flash[:error] = 'Error while updating category.'
      render :edit
    end
  end

  def destroy
    @category = @shop.categories.find params[:id]
    if @category.can_destroy?
      @category.destroy
      flash[:notice] = 'Deleted category.'
    else
      flash[:error] = 'Error while deleting category.'
    end
    redirect_to admin_shop_categories_path(@shop)
  end

  def sort
    params[:category].each_with_index do |id, index|
      Category.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
