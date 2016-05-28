def sign_in(user=nil)
  user ||= Fabricate(:user)
  session[:user_id] = user.id
end