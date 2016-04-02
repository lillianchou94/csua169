require 'test_helper'

class ElectionsControllerTest < ActionController::TestCase
  setup do
    @election = elections(:one)
  end

  test "should show election" do
    get :show, id: @election
    assert_response :success
  end
  
  test "should show election" do
    get :show_elections, id: @election
    assert_response :success
  end

end
