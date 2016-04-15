Feature: Add and delete elections
  As a admin
  I want to be able to add elections and delete elections
  So that I can start elections and end elections
  
  Background:
    Given I am logged in as an admin
    And I should see "Hello,"
    
  # Scenario: Add election
  #   Given I am on the show elections page for an admin
  #   And I should see "Add election"
  #   When I press "Add election"
  #   And I add the election called "election1"
  #   Then I should be on the show elections page for an admin
  #   And I should see "Add election" 
  #   Then I should see "election1"
  #   Then I should see "New election name:"
  #   Then I should see "Add position"
  #   Then I log out
    
  Scenario: Admin elections page with delete feature
    Given I am on the show elections page for an admin
    And I should see "Add election"
    When I press "Add election"
    And I add the election called "election2" for the organization "CSUA"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    Then I should see "election2"
    And I should not see "position2"
    # When I add the postion "position2" for election "election2"
    # Then I should see "position2"
    When I delete the election "election2"
    Then I should not see "blah"
    Then I should not see "election2"
    Then I log out