class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :update, :edit]

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

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @comment = Comment.new
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :private_profile)
  end

end