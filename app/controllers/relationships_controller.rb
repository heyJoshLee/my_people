class RelationshipsController < ApplicationController
  before_filter :require_user, only: [:index, :destroy]

  def index
    @user = current_user
  end

  def destroy
    @relationship = Relationship.find_by(slug: params[:id])
    @slug = @relationship.slug
    if @relationship.follower != current_user || current_user.is_admin?
      flash[:danger] = "You do not have permission to do that."
      redirect_to root_path
    else
      if @relationship.destroy
        respond_to { |format| format.js }
      end
    end
  end
end