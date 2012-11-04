class Admin::ProductsController < Admin::ApplicationController
  before_filter :find_shop, except: [:all]

  def index
    @products = @shop.products
  end

  def new
    @product = Product.new
    @product.images.build
    @categories = @shop.categories.top.nested
  end

  def create
    @product = Product.new params[:product]
    if @product.save
      redirect_to edit_admin_shop_product_path(@shop, @product), notice: 'Created product.'
    else
      @categories = @shop.categories.top.nested
      flash[:error] = 'Error while creating product.'
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
    @product.images.build
    @categories = @shop.categories.top.nested
    @option_sets = OptionSet.exclude(@product.option_sets)
  end

  def update
    @product = @shop.products.find params[:id]

    # Set variant prices. FIXME: Implement using nested attributes.
    params[:variants_attributes].each_pair do |id, fields|
      variant = Variant.find id
      variant.gross_price = fields[:gross_price]
      variant.net_price = fields[:net_price]
      variant.save
    end if params[:variants_attributes]

    # Remove all variants if none are selected.
    if params[:product][:option_ids].nil?
      @product.variants.each do |variant|
        variant.destroy
      end
    end

    # Add all variants of selected option set.
    unless params[:option_set_id].blank?
      params[:product][:option_ids] = Array.new if params[:product][:option_ids].nil?
      OptionSet.find(params[:option_set_id]).option_groups.each do |option_group|
        option_group.options.each do |option|
          params[:product][:option_ids] << option.id
        end
      end
    end

    if @product.update_attributes params[:product]
      redirect_to edit_admin_shop_product_path(@shop, @product), notice: 'Updated product.'
    else
      @categories = @shop.categories.top.nested
      flash[:error] = 'Error while updating product.'
      render :edit
    end
  end

  def destroy
    @product = @shop.products.find params[:id]
    if @product.can_destroy?
      @product.destroy
      flash[:notice] = 'Deleted product.'
    else
      flash[:error] = 'Error while deleting product.'
    end
    redirect_to admin_shop_products_path(@shop)
  end

  def all
    @products = Product.all
  end

  def sort
    params[:product].each_with_index do |id, index|
      Product.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def edit_multiple
    unless params[:copy_shop_id].blank?
      params[:product_ids].each do |id|
        Product.find(id).copy(params[:copy_shop_id])
      end
      redirect_to admin_shop_products_path(params[:copy_shop_id]), notice: 'Copied products.'
    else
      redirect_to admin_shop_products_path(@shop)
    end
  end
end
