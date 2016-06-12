class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :update, :edit]
  before_filter :redirect_if_user_cant_edit_profile, only: [:update, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # AppMailer.send_welcome_email(@user).deliver
      flash[:success] = "Your account was created. Please log in."
      redirect_to sign_in_path
    else
      flash.now[:danger] = "Something went wrong and your account was not created."
      render :new
    end
  end

  def my_profile
    redirect_to user_path(current_user)
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was saved"
      redirect_to user_path(@user)
    else
      flash[:danger] = "There was an error and your changes were not saved"
      render :edit
    end
  end

  def show
    @comment = Comment.new
  end

  private

  def redirect_if_user_cant_edit_profile
    unless current_user == @user
      flash[:danger] = "You don't have permission to do that"
      redirect_to home_path 
    end
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :private_profile, :profile_img)
  end

end