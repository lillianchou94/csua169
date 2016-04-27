Feature: Election pages content
  As a super-admin
  I want to see my Election Panel and have access to /admin page
  So that I can see all users for all of the organizations and be able to add organizations via import CSV
  
  Background:
    Given I am logged in as a super-admin 
 
  Scenario: election dashboard page
    Given I am on the election dashboard page
    Then I should see "Rest of dashboard goes here"
    Then I log out
    
  Scenario: super-admin election page
    Given I am on the show elections page for a member
    Then I should see "Add organization"
    And I should see "Add election"
    And I should see "Add position"
    And I should see "Settings"
    Then I log out
  
  # happy paths for add organization  
  Scenario: super-admin election page (add org)
    Given I am on the show elections page for a super-admin
    Then I should see "Add organization"
    When I click Add organization
    And I add the organization called "org1"
    Then I should be on the show elections page for a super-admin
    Then I should see "Add organization"
    And I should see "org1" on the page
    Then I log out
    
  # drop down org field in add election window
  Scenario: super-admin for "org1" and "org2" (election page)
    Given I am on the show elections page for a super-admin
    When I press "Add election"
    Then I should see "Organization:"
    And I should see a drop down menu to the right of "Organization:"
    And I should see "org1" in the drop down menu to the right of "Organization:"
    And I should see "org2" in the drop down menu to the right of "Organization:"
    When I click "org1"
    Then I should see "org1" in the "Organization:" field
    Then I log out
    
  Scenario: admin for "org1" (election page)
    Given I am on the show elections page for an admin
    When I press "Add election"
    Then I should see "Organization:"
    And I should see a drop down menu to the right of "Organization:"
    And I should see "org1" in the drop down menu to the right of "Organization:"
    And I should not see "org2" in the drop down menu to the right of "Organization:"
    When I click "org1"
    Then I should see "org1" in the "Organization:" field
    Then I log out