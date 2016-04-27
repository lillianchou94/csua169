Feature: Election panel content
  As a admin
  So that I can manage members and elections in my organization
  I should also be able to add and delete election and be able add and delete members and admins.
  
  Background:
    Given I am logged in as an admin 
 
  Scenario: election dashboard page
    Given I am on the election dashboard page
    Then I should see "Rest of dashboard goes here"
    Then I log out
    
  Scenario: admin election page
    Given I am on the show elections page for a member
    And I should see "Add election"
    And I should see "Add position"
    And I should see "Settings"
    Then I log out

  # drop down org field in add election window
  Scenario: admin for "org1" and "org2" (election page)
    Given I am on the show elections page for an admin
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