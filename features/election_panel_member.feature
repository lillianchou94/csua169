Feature: Election panel content
  As a member
  So that I only have access to nomination and voting pages that I am a member of the organization for. 
  And I should not have access to /admin page nor do I have the ability to start nomination and election.
  I want to be able to vote only.
  
  Scenario: election dashboard page should have content for member #happy path
    Given I am logged in as a member in CSUA 
    And I am on the election dashboard page
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out
  
  Scenario: election dashboard page should not have content for non-member #sad path
    Given I am logged in as a non member
    And I am on the election dashboard page
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out