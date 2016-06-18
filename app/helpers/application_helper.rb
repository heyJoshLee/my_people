module ApplicationHelper
  def categories_dropdown
    options_for_select(Category.all.map { |category| [category.name, category.id] })
  end

  def render_join_or_leave_group_button
    if logged_in?
      if current_user.is_member_of?(@group)
        render partial: "leave_button"
      else
        render partial: "join_button"
      end
    end
  end


  def render_follow_button(another_user=nil)
    return unless curent_user
    other_user = another_user || @user
    if current_user.can_follow(other_user)
      render partial: "relationships/follow_button"
    else
      # render unfollow button
    end
  end

end


# create
# mark as true
# mark as false