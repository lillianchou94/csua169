Feature: delete elections
  As a admin
  I want to be able to delete elections
  So that I can end elections
  
  Background:
    Given I am logged in as an admin in CSUA
    And I should see "Hello,"
    
  Scenario: Admin elections page with delete feature
    Given I am logged in as an admin in CSUA
    And I add the election called "election1" for the organization "CSUA"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    Then I should see election1
    And I should not see position1
    # When I add the postion "position2" for election "election2"
    # Then I should see "position2"
    When I delete the election "election2"
    Then I should not see election1
    # Then I should not see "election2"
    Then I log out