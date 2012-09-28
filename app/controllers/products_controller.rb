class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shop = Shop.find params[:shop_id]
    @product = @shop.products.find params[:id]
  end
end
