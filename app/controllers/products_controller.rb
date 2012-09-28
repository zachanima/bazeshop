class ProductsController < ApplicationController
  def show
    @shop = Shop.find params[:shop_id]
    @product = @shop.products.find params[:id]
  end
end
