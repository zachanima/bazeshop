class Admin::ProductsController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @products = @shop.products
  end

  def new
    @product = Product.new
    @categories = @shop.categories.top.nested
  end

  def create
    @product = Product.new params[:product]
    if @product.save
      redirect_to admin_shop_products_path(@shop), notice: 'Created product.'
    else
      @categories = @shop.categories.top.nested
      flash[:error] = 'Error while creating product.'
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
    @categories = @shop.categories.top.nested
  end

  def update
    @product = @shop.products.find params[:id]
    if @product.update_attributes params[:product]
      redirect_to admin_shop_products_path(@shop), notice: 'Updated product.'
    else
      @categories = @shop.categories.top.nested
      flash[:error] = 'Error while updating product.'
      render :edit
    end
  end

  def sort
    params[:product].each_with_index do |id, index|
      Product.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
