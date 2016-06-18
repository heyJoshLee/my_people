class EventDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def rsvp_button(logged_in, event)
    if logged_in
      if current_user.is_going_to?(event)
        render partial: "un_rsvp_button"
      elsif current_user.has_unrsvpd?(event)
        "Say you're  going again"
      else
        render partial: "rsvp_button"
      end
    else
      render partial: "shared/join_button", locals: {object: "event"}
    end
  end

end
