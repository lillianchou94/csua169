Feature: Dashboard page main content
  As a admin
	I want to see Election Details on my main dashboard depending on if elections started
	So that I can see all the election details
	
	Scenario: Admin Dashboard page with before nomination started
	  Given I am logged in as an admin
    And I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    And I should see "Start Nomination"
    Then I log out
  
  Scenario: Admin Dashboard page with before voting started
    Given I am logged in as an admin
    And I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    And I should see "Start Voting"
    Then I log out
  
  Scenario: Admin Dashboard page with after election ended
    Given I am logged in as an admin
    And I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    And I should see "Election Result"
    Then I log out
    
  Scenario: Voter Dashboard during an election
    Given I am on the dashboard page for a voter
    Then I should not see "Create Organization"
    And I should not see "CSUA Voting System"