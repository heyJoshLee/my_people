class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      flash[:success] = "Your account was created. Please log in."
      redirect_to log_in_path
    else
      flash.now[:danger] = "Something went wrong and your account was not created."
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end