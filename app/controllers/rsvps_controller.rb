class RsvpsController < ApplicationController 
  before_filter :require_user

  def create
    rsvp = Rsvp.where(user_id: current_user.id, event_id: Event.find_by(slug: params[:event_id])).first
    if rsvp
      rsvp.update_column(:going, false)
    else
      going = params[:going]
      @event = Event.find_by(slug: params[:event_id])
      @rsvp = current_user.rsvps.build(event_id: @event.id, going: going)
      @rsvp.save
    end
      respond_to do |format|
        format.js
      end
  end

  def change
    @going = params[:going]
    rsvp = Rsvp.find(params[:id])
    @event_id= rsvp.event.id
    rsvp.update_column(:going, @going)
    respond_to do |format|
      format.html do
          flash[:success] = "You have changed your rsvp."
        redirect_to event_path(rsvp.event)
      end
      format.js
    end
  end

end
