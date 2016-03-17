Feature: Dashboard page main content
  As a admin
	I want to see my Streaming and Election Details on my main dashboard depending on if elections started
	So that I can see all the election details and start streaming
	
	Scenario: Admin Dashboard page with before nomination started
    Given I am on the dashboard page for an admin
    Then I should see "Stream URL"
    And I should see "Start Nomination"
  
  Scenario: Admin Dashboard page with before voting started
    Given I am on the dashboard page for an admin
    Then I should see "Stream URL"
    And I should see "Start Voting"
  
  Scenario: Admin Dashboard page with after election ended
    Given I am on the dashboard page for an admin
    Then I should see "Stream URL"
    And I should see "Election Result"
    
    