class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @categories = Category.where parent_id: nil
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
