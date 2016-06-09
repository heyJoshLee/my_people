class CommentsController < ApplicationController
  before_filter :require_user, only: [:create]

  def create
    @object = {}
    determine_commentable_object_type
    @comment = @object.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    respond_to { |format| format.js }
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

  def determine_commentable_object_type
    @object_class = params[:object_type].constantize
    slug = params[:group_id] || params[:event_id] || params[:user_id]
    @object = @object_class.find_by(slug: slug)
  end
end