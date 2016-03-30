Feature: dashboard pages content
  As a admin
	I want to see my dashboard
	So that I can see all the elections I am a part of and I can add new elections
	
  Scenario: Admin dashboard page
    Given I am on the dashboard pre-voting page for an admin
    Then I should see "CSUA Voting System"
    
  Scenario: Admin elections page
    Given I am on the elections page for an admin
    # Then I should see "Add position"
    Then I should see "Add election"
    When I press "Add election"
    And I add the election called "primary"
    Then I should be on the elections page for an admin
    # When I am on the election list page
 		# Then I should see "primary"
		#Then I should see "New election name:"

    # Given I am on the add position page
    #Then I should see "Organization:"
		 	
	#And I should see "Apply to postions"
	#And I should see "Add Event"
	#And I should see "Sign out"
	#And I should see "Begin voting"
	
	#Scenario: User dashboard page
		#Given I am logged in as a non-admin user
		#When I am on the dashboard pre-voting page for a user
		#Then I should see "CSUA Voting System"
		#And I should see "Current Time"
		#And I should see "Apply to positions"
		#And I should see "click to apply"
		#When I am on the elections page
		#Then I should not see "Add position"