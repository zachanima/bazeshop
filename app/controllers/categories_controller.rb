class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop

  def show
    @category = @shop.categories.find params[:id]
  end
end
