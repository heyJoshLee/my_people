class ForgotPasswordsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    @method = params[:method]

    if @user
      @user.generate_password_reset_token
      @user.save
      binding.pry
      if @method == "phone"

      elsif @method == "email"
        #sent code by email
      end

      render :sent
    else
      flash[:danger] = "User not found!"
      redirect_to new_forgot_password_path

    end
  end

  def send_password_reset_by_phone 
    
  end

  def send_password_reset_by_email=
    
  end


end