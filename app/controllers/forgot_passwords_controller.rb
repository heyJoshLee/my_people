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

end