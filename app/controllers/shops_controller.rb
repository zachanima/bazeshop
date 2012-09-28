class ShopsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shop = Shop.find params[:id]
  end
end
