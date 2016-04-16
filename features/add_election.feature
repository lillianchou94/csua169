Feature: Add elections
  As a admin
  I want to be able to add elections
  So that I can start elections
  
  Background:
    Given I am logged in as an admin
    And I should see "Hello,"
    
  Scenario: Add election
    Given I am on the show elections page for an admin
    And I should see "Add election"
    When I press "Add election"
    And I add the election called "election1" for the organization "CSUA"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    Then I should see "election1"
    Then I should see "New election name:"
    Then I should see "Add position"
    Then I log out