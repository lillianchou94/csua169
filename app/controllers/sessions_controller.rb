#courtesy of https://richonrails.com/articles/google-authentication-in-ruby-on-rails

class SessionsController < ApplicationController
  def create
    user = User.exists?(user_email: env["omniauth.auth"].info.email)
    if user == false
      puts "FAILED LOGIN"
      redirect_to root_path
    else
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
    end
  end
  
  def test_super_admin
    # user = User.where(user_email: "super169csua@gmail.com")
    session[:user_id] = 17
    redirect_to root_path
  end
  
  def test_nonsuper_admin
    # user = User.where(user_email: "email1111222@gmail.com")
    session[:user_id] = 1
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end