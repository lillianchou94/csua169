Feature: Voting phase for admin
  As an admin
  I want to be able to start and end an election
  So that elections can occur
  
  Background:
    Given I am logged in as an admin
    And the election "Election1" exists for "CSUA"
    And the position "position1" exists for "Election1"
    And the position "position2" exists for "Election1"
    And the election "Election2" exists for "HKN"
  
  Scenario: Start/end election
    When I am on the elections page
    Then I should see "Election1"
    And I should see "Start Election"
    When I press "Start Election"
    Then I should see "End Election"
    And I should not see "Start Election"
    When I press "End Election"
    Then I should see "Results"
    Then I log out
    
  Scenario: Election has already ended
    Given the election "Election 1" has ended
    Then I should not see "Start Election" for "Election 1"
  
  Scenario: CSUA admin vote (happy path)
    Given the election "Election1" has started
    When I press "Election1"
    And I press "position1"
    And I select "candidate1"
    And I press "Confirm Vote"
    Then I should see "You have voted for candidate1"
    Then I log out
    
  Scenario: CSUA admin vote (sad path)
    Given the election "Election2" has started
    When I press "Election2"
    Then I should see "You cannot vote in this election because you are not a part of this organization"
    Then I log out
