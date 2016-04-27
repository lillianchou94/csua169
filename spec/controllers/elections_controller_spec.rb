require 'rails_helper'
require "capybara/dsl"


RSpec.describe ElectionsController, type: :request do
  
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    # controller.stub!(:current_user).and_return(user)
    # view.stub(:current_user) { User.create(user_name: 'A', user_email: 'a@gmail.com', organization: "CSUA", admin_status: 1, user_prime: 2, is_active: true, votes: '{"csua_04012016_President":"3"}') # return a user }
  end
  
  describe "testing routing" do
    it "should work" do
      visit root_path
      expect(page).to have_text("CSUA")
    end
  end
  
  # describe "GET show" do
  #   it "successfully renders the show template" do
  #     get "/election_show_elections"
  #     expect(response).to be_successful
  #     expect(response).to render_template(:show_elections)
  #   end
  # end
  
  
  describe "Home requests" do
    it 'successfully renders the show template on GET /' do
      get "/"
      expect(response).to redirect_to('/login')
    end
  end
  
  # describe "failed login" do
  #   it "successfully renders the correct page when login failed" do
  #     get "auth/:provider/callback"
  #     expect(response).to render_template()
  #   end
  # end
  
  # describe "successful login" do
  #   it "renders the correct page when login is successful" do
  #     get "auth/failure"
  #     expect(response).to redirect_to('/')
  #   end
  # end
  
end

RSpec.describe ElectionsController, type: :controller do
  
  describe 'DELETE destroy' do
    before :each do
      @user = User.create!(:user_name => "A", :user_email => "a@gmail.com", :organization => "CSUA", :user_prime => 2, :admin_status => 1)
    end
    
    it "deletes the user that exist" do
      expect{
        delete :delete_individual, user_name: "A", user_email: "a@gmail.com", organization: "CSUA"
      }.to change(User,:count).by(-1)
    end
      
    it "deletes the user that doesn't exist" do
      expect{
        delete :delete_individual, user_name: "NOTAUSER", user_email: "notauser@gmail.com", organization: "CSUA"
      }.to change(User,:count).by(0)
    end
  end
  
  describe 'Create User' do
    before :each do
      @user = User.create!(:user_name => "A", :user_email => "a@gmail.com", :organization => "CSUA", :user_prime => 2, :admin_status => 1)
    end
    
    it "creates a new user" do
      get :add_individual, user_name: "NOTAUSER", user_email: "notauser@gmail.com", organization: "CSUA", admin_status: 1, user_prime: 2
      user = User.create(:user_name => 'User A', :user_email => "a@gmail.com", :organization => "CSUA", :user_prime => 2, :admin_status => 1)
      expect(user).to be_persisted
    end
    
    it "does not add the user that exist" do
      expect{
        delete :add_individual, user_name: "A", user_email: "a@gmail.com", organization: "CSUA", user_prime: 2, admin_status: 1
      }.to change(User,:count).by(0)
    end
      
    it "add a user that doesn't exist" do
      expect{
        delete :add_individual, user_name: "NEWUSER", user_email: "newuser@gmail.com", organization: "CSUA", user_prime: 2, admin_status: 1
      }.to change(User,:count).by(1)
    end
  end
  
  describe "show_settings" do
    before :each do
      @user1 = User.create!(:user_name => "A1", :user_email => "a1@gmail.com", :organization => "CSUA", :admin_status => 1, :user_prime => 2)
      id = User.where(:user_name => "A1", :user_email => "a1@gmail.com", :organization => "CSUA", :admin_status => 1, :user_prime => 2)
      @user2 = User.create!(:user_name => "A2", :user_email => "a2@gmail.com", :organization => "CSUA", :admin_status => 1, :user_prime => 2)
      @user3 = User.create!(:user_name => "A1", :user_email => "a1@gmail.com", :organization => "HKN", :admin_status => 0, :user_prime => 2)
      @all_same_user = User.where(:user_email => "a1@gmail.com")
      @my_orgs = Array.new
      for user in @all_same_user
        @my_orgs << user.organization
      end
      # @current_user = @user1
      session[:user_id] = @id
    end
    
    it "assigns @my_orgs" do
      user = @user1
      # get :show_settings, session[:user_id] => @user1.id
      # controller.session[:user_id].should_not be_nil
      # expect(assigns(:my_orgs)).to eq(["CSUA", "HKN"])
    end
    
    it "assigns @org_admin_pair" do
      user = @user1
      # get :show_settings, session[:user_id] => @user1.id
      # expect(assigns(:org_admin_pair)).to eq(["CSUA": @user1])
    end
  
    it "assigns @org_member_pair" do
      user = @user1
      # get :show_settings, session[:user_id] => @user1.id
      # expect(assigns(:org_member_pair)).to eq(["HKN": @user1])
    end
  end
  
  describe "show_elections check current_user" do
    it "should have no current_user" do
      get "show_elections"
      session[:user_id] = 11234
      expect(@current_user).to eq(nil)
    end
  end
  
  
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
  
  describe "calling dashboard" do
    it "should be successful" do
      get :dashboard
      response.should be_success
    end
  end
  
  describe "calling show_elections_add" do
    it "should be successful" do
      get :show_elections_add
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