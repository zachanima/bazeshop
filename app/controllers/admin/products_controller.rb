class Admin::ProductsController < Admin::ApplicationController
  before_filter :find_shop

  def index
    @products = @shop.products
  end

private
  def find_shop
    @shop = Shop.find params[:shop_id]
  end
end
