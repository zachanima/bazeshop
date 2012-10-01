module ApplicationHelper
  def current_shop? shop
    params[:shop_id].to_i == shop.id or
      params[:shop_id] == shop.link or
      (controller.controller_name == 'shops' and params[:id].to_i == shop.id) or
      (controller.controller_name == 'shops' and params[:id] == shop.link)
  end

  def markdown text
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    renderer.render text
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
