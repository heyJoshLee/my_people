class GroupsController < ApplicationController

  before_filter :require_user, only: [:new, :create]

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
    @group = Group.find_by(slug: params[:id])
  end

  private


  def group_params
    params.require(:group).permit!
  end

end