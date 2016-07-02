class GroupDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all


  def render_join_or_leave_group_button(logged_in)
    if logged_in
      if current_user.is_member_of?(group)
        render partial: "leave_button"
      else
        render partial: "join_button"
      end
    end
  end

end
