module ApplicationHelper
  def categories_dropdown
    options_for_select(Category.all.map { |category| [category.name, category.id] })
  end

  def render_join_or_leave_group_button
    if current_user.is_member_of?(@group)
      render partial: "leave_button"
    else
      render partial: "join_button"
    end
  end

  def render_rsvp_button
    if current_user.is_going_to?(@event)
      render partial: "un_rsvp_button"
    else
      render partial: "rsvp_button"
    end
  end

end


# create
# mark as true
# mark as false