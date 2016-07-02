class EventDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all


  # if the user is logged in let the user rsvp to the event
  # this creates a rsvp object with going? == true
  # if the user is going allow them to un rsvp from the event
  # this sets going == !going

  def render_rsvp_button(logged_in, event)
    if logged_in
      if current_user.is_going_to?(event)
        render partial: "un_rsvp_button"
      elsif current_user.has_unrsvpd?(event)
        render partial: "re_rsvp_button"
      else
        render partial: "rsvp_button"
      end
    end
  end

end
