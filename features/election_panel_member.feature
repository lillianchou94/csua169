Feature: Election pages content
  As a member
  I want to see my Election Panel
  So that I can see all the elections I am a part of
  
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