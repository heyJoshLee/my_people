module ApplicationHelper
  def categories_dropdown
    options_for_select(Category.all.map { |category| [category.name, category.id] })
  end


  def render_follow_button(another_user=nil)
    return unless current_user
    other_user = another_user || @user
    if current_user.can_follow?(other_user)
      render partial: "relationships/follow_button"
    else
      # render unfollow button
    end
  end

end

