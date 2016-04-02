Feature: Election pages content
  As a admin
	I want to see my Election Panel
	So that I can see all the elections I am a part of and I can add new elections
	
	@omniauth_test
	Scenario: login page
	  Given I am signed in with provider "google_oauth2"
    And I am on the dashboard page for googleuser
    Then I should see "CSUA Voting System"
    And I should see "Rest of dashboard goes here"
	  And I should see "Add election"

# 	Scenario: Admin elections page with delete feature
#     Given I am on the show elections page for an admin
#     Then I should see "Delete Election"
#     When I press Delete election for "Election 1"
#     Then I should be on the show elections page for an admin
#     And I should not see "Election 1"
	
  Scenario: Admin Election page
    Given I am on the Election pre-voting page for an admin
    Then I should see "CSUA Voting System"
    
  Scenario: Admin elections page
    Given I am on the show elections page for an admin
    # Then I should see "Add position"
    Then I should see "Add election"
    When I press "Add election"
    And I add the election called "election1"
    Then I should be on the show elections page for an admin
    #Then I should see "Add position"
    # When I am on the election list page
 		#Then I should see "election1"
		#Then I should see "New election name:"
		#Given I am on the add election page

    #Given I am on the add position page
  Scenario: dashboard  
    Given I am on the dashboard page for an admin
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"
    When I follow "Sign in with Google"
  
  Scenario: logging in
    Given I am on the dashboard page for an admin
    And "blah@gmail.com" is logged in
    Then I should see "Sign out"
 
  Scenario: test routes
    Given I am on the add election page
		Given I am on the delete election page
    #Given I am on the add position page
    Given I am on the delete position page
    Given I am on the authentication failure page
    Given I am on the signout page
    Given I am on the election dashboard page
    Given I am on the election embed livestream page
    #Given I am on the home page
    #Given I am on the election page
    #Given I am on the election list page