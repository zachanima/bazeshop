class ShopsController < ApplicationController
  def show
    @shop = Shop.find params[:id]
    unless user_signed_in?
      redirect_to new_user_session_path(@shop)
    end
  end
end
