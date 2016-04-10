Feature: Dashboard page main content
  As a admin
	I want to see my Streaming and Election Details on my main dashboard depending on if elections started
	So that I can see all the election details and start streaming
	
	Scenario: Admin Dashboard page with before nomination started
    And I am on the dashboard page as an admin
    # And I follow "Sign in with Google"
    # And Google authorizes me
    Then I should see "CSUA Voting System"
    # And I should see "Start Nomination"
  
  Scenario: Admin Dashboard page with before voting started
    Given I am signed in
    And I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    # And I should see "Start Voting"
  
  Scenario: Admin Dashboard page with after election ended
    Given I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    # And I should see "Election Result"
    
  Scenario: Voter Dashboard during an election
    Given I am on the dashboard page for a voter
    Then I should not see "Create Organization"
    And I should not see "CSUA Voting System"

    