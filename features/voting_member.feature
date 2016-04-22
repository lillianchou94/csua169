Feature: Voting phase for member
  As an member
  I want to vote in an election
  So that I have an input in who gets elected
  
  Background:
    Given I am logged in as a member in CSUA
    And the election "Election1" exists for "CSUA"
    And the position "position1" exists for "Election1"
    And the position "position2" exists for "Election1"
    And the election "Election2" exists for "HKN"
  
  Scenario: CSUA member vote (sad path)
    Given the election "Election2" has started
    When I press "Election2"
    Then I should see "You cannot vote in this election because you are not a part of this organization"
    Then I log out
    
  Scenario: See results
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    Then I should see "position1"
    And I should see "candidate1 won"
    Then I log out
  
  Scenario: Request from Server Timeout (sad path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I press "vote"
    Then I should see a timeout error
    
  Scenario: Voter inputs into modal, cache has no password
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I press "vote"
    Then I should see a popup
    When I enter a password
    And I press "Enter"
    Then I should see "You have voted for candidate1"
    
  Scenario: Voter votes and cache contains password (happy path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I press "vote"
    Then I should not see a modal dialog
    Then I should see "You have voted for candidate1"
  
  Scenario: Correct encryption and decryption after voting
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I press "vote"
    Then I should not see a modal dialog
    Then I should have an "encrypted" value of votes
    And I should have a "decrypted" value of votes
    When I press "enter"
    Then I should see "You have voted for candidate1"
  
  Scenario: Attempt decryption after voting, cache is cleared (sad path)
    Given I voted for "candidate1" for postion "position1"
    And I am on the results page
    And I press "vote"
    Then I should not see a modal dialog
    When I attempt to encrypt the votes
    Then I should not have a encrypted value
    And I should see an error

  Scenario: Voters dashboard page during voting
    Given I am on the show elections page for a "voter" 
    # Then I should see "Role" 
    And I should see a drop down menu to the right of "Role" 
    When I press the drop down menu 
    Then I should see a list of candidates
    # When I press "Candidate 1" 
    Then I should see "Candidate 1" in the "Role" field 
    