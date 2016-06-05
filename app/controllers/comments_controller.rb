class CommentsController < ApplicationController

  def create
    @object_class = params[:object_type].constantize
    slug = params[:group_id]
    @object = @object_class.find_by(slug: slug)
    @comment = @object.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    respond_to { |format| format.js }
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end