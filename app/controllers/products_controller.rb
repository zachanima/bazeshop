class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shop = Shop.find params[:shop_id]
    @product = @shop.products.find params[:id]
    @line_item = current_user.line_items.build(product_id: @product.id)
  end
end
