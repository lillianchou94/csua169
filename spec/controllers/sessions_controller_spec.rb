require 'rails_helper'
require "capybara/dsl"


RSpec.describe SessionsController, type: :request do
  
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    
  end
  
  describe "failed login" do
    it "successfully renders the correct page when login failed" do
      get "/auth/:provider/callback"
      expect(response).to render_template('sessions#create')
    end
  end
  
  describe "successful login" do
    it "renders the correct page when login is successful" do
      get "/auth/failure"
      expect(response).to redirect_to('/')
    end
  end
  
  describe "signout" do
    it "successfully renders the correct page when signing out" do
      get "/signout"
      expect(response).to render_template(:destroy)
    end
  end  
  
end

RSpec.describe SessionsController, type: :controller do
  
end