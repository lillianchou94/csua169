Feature: dashboard pages content
  Scenario: Admin dashboard page
    Given I am on the dashboard pre-voting page for an admin
    Then I should see "CSUA Voting System"
    
   Scenario: Admin elections page
     Given I am on the elections page for an admin
     Then I should see "Add position"
		 And I should see "CSUA"
		 When I press "Add position"
		 # result of Add position
  
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

	#Scenario: See the results of an election as a user
	#	Given I am logged in as a non-admin user
	#	When I am on the dashboard results page
	#	Then I should see "Results"
	#	And I should see "Sign out"
	# And I should see event names
	# And I should see positions