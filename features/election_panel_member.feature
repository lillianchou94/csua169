Feature: Election pages content
  As a member
  So that I only have access to nomination and voting pages that I am a member of the organization for. 
  And I should not have access to /admin page nor do I have the ability to start nomination and election.
  I want to be able to vote only.
  
  Background:
    Given I am logged in as a member 
 
  Scenario: election dashboard page
    Given I am on the election dashboard page
    Then I should see "Rest of dashboard goes here"
    Then I log out
  
  Scenario: member election page
    Given I am on the show elections page for a member
    Then I should not see "Add organization"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out