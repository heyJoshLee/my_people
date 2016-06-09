class AnnouncementsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    @object = {}
    determine_commentable_object_type

    if !current_user.can_modify_group?(@object)
      flash[:danger] = "You do not have permission to do that"
      redirect_to root_path
    else 
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
    @group  = @announcement.group
    @id = params[:id]
    if current_user.can_modify_group?(@group) && @announcement.destroy
      @group.set_announcements_positions
      respond_to do |format|
        format.js
      end
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