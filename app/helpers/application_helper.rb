module ApplicationHelper
  def current_shop? shop
    params[:shop_id].to_i == shop.id or controller.controller_name == 'shops' and params[:id].to_i == shop.id
  end
end
