class CategoriesController < ApplicationController
  def show
    @shop = Shop.find params[:shop_id]
    @category = @shop.categories.find params[:id]
  end
end
