class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_shop, except: [:sort]

  def index
    @categories = @shop.categories.top
  end

  def new
    # Not using @shop.categories.build, to avoid empty entry in parent dropdown.
    @category = Category.new
    @categories = @shop.categories.top.nested @category
  end

  def create
    @category = @shop.categories.build params[:category]
    if @category.save
      redirect_to admin_shop_categories_path(@shop), notice: 'Created category.'
    else
      @categories = @shop.categories.top.nested @category
      flash[:error] = 'Error while creating category.'
      render :new
    end
  end

  def edit
    @category = @shop.categories.find params[:id]
    @categories = @shop.categories.top.nested @category
  end

  def update
    @category = @shop.categories.find params[:id]

    # Remove all access groups if none are selected.
    if params[:category][:access_group_ids].nil?
      @category.access_groups.clear
    end

    if @category.update_attributes params[:category]
      redirect_to admin_shop_categories_path(@shop), notice: 'Updated category.'
    else
      @categories = @shop.categories.top.nested @category
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
    params[:category].each_with_index do |(id, parent_id), index|
      category = Category.find id
      category.position = index + 1
      category.parent_id = parent_id
      category.save
      # Category.update_all({position: index+1}, {id: id}, {parent_id: parent_id})
    end
    render nothing: true
  end
end
