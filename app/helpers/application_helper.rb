module ApplicationHelper
  def current_shop? shop
    params[:shop_id].to_i == shop.id or (controller.controller_name == 'shops' and params[:id].to_i == shop.id)
  end

  def number_to_smart_currency number, currency = 'kr.'
    if not number
      return
    elsif number % 1 == 0
      "#{number.to_i} #{currency}"
    else
      number_to_currency number, unit: currency, format: '%n %u'
    end
  end
end
