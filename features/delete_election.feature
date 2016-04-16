Feature: delete elections
  As a admin
  I want to be able to delete elections
  So that I can end elections
  
  Background:
    Given I am logged in as an admin
    And I should see "Hello,"
    
  Scenario: Admin elections page with delete feature
    Given I am on the show elections page for an admin
    And I add the election called "election2" for the organization "CSUA"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    Then I should see "election2"
    And I should not see "position2"
    # When I add the postion "position2" for election "election2"
    # Then I should see "position2"
    When I delete the election "election2"
    Then I should not see "blah"
    Then I should see "election2"
    Then I log out