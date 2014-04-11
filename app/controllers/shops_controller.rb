class ShopsController < ApplicationController
  before_filter :authenticate_user!, except: [:pay]
  before_filter :find_shop

  def pay
    render :pay
  end
end
