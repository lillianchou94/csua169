require 'app/controllers/elections_controller.rb'
require 'spec/spec_helper.rb'

describe 'Ruby intro part 1' do
  describe "show_elections" do
    it "calls the controller method that renders the show_elections view" do
      expect(ElectionsController).to receive(:show_elections)
      get "/elections/show_elections"
    end
  end
end