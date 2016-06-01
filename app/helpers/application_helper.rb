module ApplicationHelper
  def categories_dropdown
    options_for_select(Category.all.map { |category| [category.name, category.id] })
  end
end
