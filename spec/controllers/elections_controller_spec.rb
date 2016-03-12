require 'rails_helper'

RSpec.describe ElectionsController, type: :request do
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