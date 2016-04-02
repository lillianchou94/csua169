require 'rails_helper'
require "capybara/dsl"


RSpec.describe ElectionsController, type: :request do
  
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    
  end
  
  describe "testing routing" do
    it "should work" do
      visit root_path
      expect(page).to have_text("CSUA")
    end
  end
  
  describe "GET show" do
    it "successfully renders the show template" do
      get "/election_show_elections"
      expect(response).to be_successful
      expect(response).to render_template(:show_elections)
    end
  end
  
  describe "Home requests" do
    it 'successfully renders the show template on GET /' do
      get "/"
      expect(response).to redirect_to('/login')
    end
  end
  
  describe "failed login" do
    it "successfully renders the correct page when login failed" do
      get "auth/:provider/callback"
      expect(response).to render_template()
    end
  end
  
  describe "successful login" do
    it "renders the correct page when login is successful" do
      get "auth/failure"
      expect(response).to redirect_to('/')
    end
  end
  
end

RSpec.describe ElectionsController, type: :controller do
  
  describe "show_elections" do
    it "receive call to show elections" do
      expect(controller).to receive(:show_elections)
      get "show_elections"
    end
  end
  
  describe "login page" do
    it "receive call to render login" do
      expect(controller).to receive(:login)
      get "login"
    end
  end
  describe "calling show_elections_delete" do
    it "should be successful" do
      get :show_elections_delete
      response.should be_success
    end
  end
  
  describe "calling show_elections_add" do
    it "should be successful" do
      get :show_elections_add
      response.should be_success
    end
  end
  
  describe "calling show_positions_add" do
    it "should be successful" do
      get :show_positions_add
      response.should be_success
    end
  end
    
  describe "calling show_positions_delete" do
    it "should be successful" do
      get :show_positions_delete
      response.should be_success
    end
  end
      
  describe "calling show_elections" do
    it "should be successful" do
      get :show_elections
      response.should be_success
    end
  end
      
  describe "calling embed_livestream" do
    it "should be successful" do
      get :embed_livestream
      response.should be_success
    end
  end
  
  
end