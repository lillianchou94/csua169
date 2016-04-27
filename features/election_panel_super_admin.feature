Feature: Election panel content
  As a super-admin
  I want to see my Election Panel and have access to /admin page
  So that I can see all users for all of the organizations and be able to add organizations via import CSV
  
  Scenario: election dashboard page
    Given I am logged in as a super admin 
    And I am on the election dashboard page
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out
    
  Scenario: super-admin have access to "/admin" #happy path
    Given I am logged in as a super admin 
    And I am on the set up for super admin page
    And I go to the super admin page
    Then I should be on the super admin page
    Then I should not see "Click on an election to see election status."
    Then I should not see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out
    
    Scenario: regular admin don't have access to "/admin" #sad path
    Given I am logged in as an admin in CSUA
    And I am on the set up for non super admin page
    And I go to the super admin page
    Then I should be on the election dashboard page #instead of super admin page
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    Then I log out
    
    Scenario: member doesn't have access to "/admin" #sad path
    Given I am logged in as a member in CSUA
    And I am on the set up for non super admin page
    And I go to the super admin page
    Then I should be on the election dashboard page #instead of super admin page
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    Then I log out
    
