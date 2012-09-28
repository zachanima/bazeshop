class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shop = Shop.find params[:shop_id]
    @category = @shop.categories.find params[:id]
  end
end
