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
end



# def create
#     @group = Group.find_by(slug: params[:group_id])
#     @membership = Membership.new(group_id: @group.id, user_id: current_user.id, role: "user")
#     respond_to do |format| 
#       format.js do
#         render :error unless @membership.save
#       end
#     end
#   end

#   def destroy
#     membership = Membership.find(params[:id])
#     @group = Group.find(membership.group_id)
#     membership.destroy
#     respond_to do |format|
#       format.js
#     end
#   end