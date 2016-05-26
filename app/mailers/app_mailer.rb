class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@mypeople.com", subject: "Welcome to My People!"
    
  end
end