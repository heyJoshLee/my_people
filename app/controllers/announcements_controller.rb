class AnnouncementsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    @object = {}
    determine_commentable_object_type
    @announcement = @object.announcements.build(announcement_params)
    @announcement.position = 0
    @announcement.user_id = current_user.id
    if @announcement.save
      @object.set_announcements_positions
      respond_to do |format|
        format.js
      end
    end
  end

  def sort
    params[:announcement].each_with_index do |id, index|
      Announcement.find(id.to_i).update_attributes!(position: index + 1)
    end

    respond_to do |format|
      format.js { render :nothing => true }
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit!
  end

  def determine_commentable_object_type
    @object_class = params[:object_type].constantize
    slug = params[:group_id] || params[:event_id]
    @object = @object_class.find_by(slug: slug)
  end


end