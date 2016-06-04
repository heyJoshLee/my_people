class GroupsController < ApplicationController

  before_filter :require_user, only: [:new, :create, :update, :comment]
  before_filter :set_group, only: [:show, :update, :comment]

  def index
    @groups = Group.all
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator_id = current_user.id
    if @group.save
      flash[:success] = "You group has been created."
      redirect_to group_path(@group)
    else
      flash[:danger] = "There was an error and your group was not created."
      render :new
    end
  end

  def show
  end

  def update
    if @group.update(group_params)
      flash[:success] = "Post saved"
      redirect_to group_path(@group)
    else
      flash[:danger] = "There was an error and your Post was not saved"
      render :edit
    end
  end

  def comment
    @comment = @group.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = Group.find_by(slug: params[:id])
  end

  def group_params
    params.require(:group).permit!
  end

  def comment_params
    params.require(:comment).permit!
  end

end