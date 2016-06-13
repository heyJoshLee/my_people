class ForgotPasswordsController < ApplicationController
  def create
    @user = User.find_by(:email, parmas[:email])
    method = params[:method]
    if method == "phone"
      #send code by phone
    elsif method == "email"
      #sent code by email
    end
  end

  def send_password_reset_by_phone 
    
  end

  def send_password_reset_by_email=
    
  end


end