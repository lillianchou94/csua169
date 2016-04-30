Feature: Voting phase for member
  As an member
  I want to vote in an election
  So that I have an input in who gets elected
  
  Background:
    Given I am logged in as a member in CSUA
    And the election "Election1" exists for "CSUA"
    And the position "position1" exists for "Election1"
    
  Scenario: See results
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    Then I should see position1
    And I should see in the browser candidate1 won
    Then I log out
  
  Scenario: Request from Server Timeout (sad path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I click vote
    Then I should see a timeout error
    Then I log out
    
  Scenario: Voter inputs into modal, cache has no password
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I click vote
    Then I should see a popup
    When I enter a password
    And I click Enter
    Then I should see You have voted for candidate1
    Then I log out
    
  Scenario: Voter votes and cache contains password (happy path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I click vote
    Then I should not see a modal dialog
    Then I should see You have voted for candidate1
    Then I log out
  
  Scenario: Correct encryption and decryption after voting
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I click vote
    Then I should not see a modal dialog
    Then I should have an "encrypted" value of votes
    And I should have a "decrypted" value of votes
    When I click Enter
    Then I should see You have voted for candidate1
    Then I log out
  
  Scenario: Attempt decryption after voting, cache is cleared (sad path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I click vote
    Then I should not see a modal dialog
    When I attempt to encrypt the votes
    Then I should not have a encrypted value
    And I should see an error
    Then I log out
    