class AnnouncementsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    @object = {}
    determine_announceable_object_type
    if current_user_is_admin_or_can_modify?(@object)
      save_and_insert_into_announcements_section
    else
      flash[:danger] = "You do not have permission to do that"
      redirect_to root_path
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

  def destroy
    @announcement = Announcement.find(params[:id])
    @object = @announcement.event || @announcement.group
    @id = params[:id]
    if current_user_is_admin_or_can_modify?(@object)
      destroy_announcement_and_remove_from_announcements_section
    else
      flash[:danger] = "You do not have permission to do that"
      redirect_to root_path
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit!
  end

  def determine_announceable_object_type
    @object_class = params[:object_type].constantize
    slug = params[:group_id] || params[:event_id]
    @object = @object_class.find_by(slug: slug)
  end

  def save_and_insert_into_announcements_section
    @announcement = @object.announcements.build(announcement_params)
      @announcement.position = 0
      @announcement.user_id = current_user.id
      
      if @announcement.save
        @object.set_announcements_positions
        @event = @announcement.event
        @group = @announcement.group
        respond_to do |format|
          format.js
        end
      end
  end

  def destroy_announcement_and_remove_from_announcements_section
    @announcement.destroy
      @object.set_announcements_positions
      respond_to do |format|
        format.js
      end
  end

  def current_user_is_admin_or_can_modify?(object)
    current_user.can_modify_group?(object) || current_user.can_modify_event?(object)
  end


end