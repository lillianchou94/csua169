Feature: Voting for admin
  As an admin
  I want to be able to start an election
  So that elections can occur
  
  # these tests pass when I run them locally but not on c9
  Background:
    Given I am logged in as an admin in CSUA
    And the election "Election1" exists for "CSUA"
    And the position "position1" exists for "Election1"
  
  Scenario: Start election
    When I am on the election dashboard page
    And I should see in the browser "Click on an election to see election status."
    When I am on the show elections page for an admin
    Then I should see in the browser "Election1"
    Then I should see position1
    Then I click on "select_election_CSUA04272016" for nominations
    When I am on the election dashboard page
    And I should see in the browser Start nomination
    Then I press on start_nomination_id for nominations
    Then I am on the show elections page for an admin
    And I should see in the browser "position1"
    And I should see in the browser "Click on an election to see election status."
    And I should not see in the browser "Start nomination"
    Then I log out
