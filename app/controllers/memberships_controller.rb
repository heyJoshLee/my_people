class MembershipsController < ApplicationController
  before_filter :require_user, only: [:create, :destroy]

  def create
    @group = Group.find_by(slug: params[:group_id])
    @membership = Membership.new(group_id: @group.id)
    
    if current_user.is_admin?
      @membership.role = params[:role] || "user"
      @membership.user_id = params[:user_id]
    else
      @membership.role = "user"
      @membership.user_id = current_user.id
    end

    @membership.save

    respond_to do |format| 
      format.js do
        render :error unless @membership.save
      end
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    @group = Group.find(membership.group_id)
    membership.destroy
    respond_to do |format|
      format.js
    end
  end
end