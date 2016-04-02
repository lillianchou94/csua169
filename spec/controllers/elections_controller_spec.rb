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
  
  describe "login" do
    
  end
  
end

RSpec.describe ElectionsController, type: :controller do
  
  describe "show_elections" do
    it "receive call to show elections" do
      expect(controller).to receive(:show_elections)
      get "show_elections"
    end
  end
  
  describe "embed_livestream" do
    it "receive call to show livestream" do
      expect(controller).to receive(:embed_livestream)
      get "embed_livestream"
    end
  end
  
end
end