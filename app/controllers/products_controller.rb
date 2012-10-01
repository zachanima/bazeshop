class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def show
    @product = @shop.products.find params[:id]
    @line_item = current_user.line_items.build(product_id: @product.id)
  end
end
