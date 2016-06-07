class MembershipsController < ApplicationController
  def create
    group = Group.find_by(slug: params[:group_id])
    membership = Membership.new(group_id: group.id, user_id: current_user.id, role: "user")
    respond_to do |format| 
      format.js do
        render :error unless membership.save
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