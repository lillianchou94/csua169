#courtesy of https://richonrails.com/articles/google-authentication-in-ruby-on-rails

class SessionsController < ApplicationController
  def create
    user = User.exists?(user_email: env["omniauth.auth"].info.email)
    if user == false
      render login_error.html.erb
    
    else
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end