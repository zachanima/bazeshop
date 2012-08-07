module Admin::CategoriesHelper
  def nested categories
    categories.collect do |category|
      [category, nested(category.categories)]
    end.flatten.compact
  end
end
