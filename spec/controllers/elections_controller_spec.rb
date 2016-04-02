require 'rails_helper'
require "capybara/dsl"


RSpec.describe ElectionsController, type: :request do
  
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    OmniAuth.config.test_mode = true
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
      expect(response).to redirect_to('/dashboard/home')
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
end

RSpec.feature "Election Creation", :type => :feature do
  scenario "Admin creates a new election" do
    visit "/election_show_elections"
    click_button "Add election"
  # within "hiddenFrameID" do
  #   fill_in('Organization:', :with => 'Election Test')
  #   click_button "Create"
  # end
    # fill_in "", :with => "Election Test"
    # click_button "Create"

    # expect(page).to have_text("Election Test")
  end
end