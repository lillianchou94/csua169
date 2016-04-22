Feature: Election pages content
  As a admin
  I want to see my Election Panel
  So that I can see all the elections I am a part of and I can add new elections
  
  Background:
    Given I am logged in as an admin 
 
  Scenario: election dashboard page
    Given I am on the election dashboard page
    Then I should see "Rest of dashboard goes here"
    Then I log out
  
  # happy paths for add organization  
  Scenario: super-admin election page
    Given I am on the show elections page for a super-admin
    Then I should see "Add organization"
    When I click Add organization
    And I add the organization called "org1"
    Then I should be on the show elections page for a super-admin
    Then I should see "Add organization"
    And I should see "org1" on the page
    Then I log out
    
  # sad paths for add organization
  Scenario: admin election page (no add org button)
    Given I am on the show elections page for an admin
    Then I should see "Add organization"
    Then I log out
    
  Scenario: regular member election page (no add org button)
    Given I am on the show elections page for a member
    Then I should see "Add organization"
    Then I log out
    
  # drop down org field in add election window
  Scenario: admin for "org1" and "org2" (election page)
    Given I am on the show elections page for an admin
    When I press "Add election"
    Then I should see "Organization:"
    And I should see a drop down menu to the right of "Organization:"
    And I should see "org1" in the drop down menu to the right of "Organization:"
    And I should see "org2" in the drop down menu to the right of "Organization:"
    When I click org1
    Then I should see "org1" in the "Organization:" field
    Then I log out
    
  Scenario: admin for "org1" (election page)
    Given I am on the show elections page for an admin
    When I press "Add election"
    Then I should see "Organization:"
    And I should see a drop down menu to the right of "Organization:"
    And I should see "org1" in the drop down menu to the right of "Organization:"
    And I should not see "org2" in the drop down menu to the right of "Organization:"
    When I click org1
    Then I should see "org1" in the "Organization:" field
    Then I log out