module Admin::CategoriesHelper
  def nested categories
    categories.collect do |category|
      [category, nested(category.categories)] unless @category and @category == category
    end.flatten.compact
  end
end
