Feature: Election panel content
  As a admin
  So that I can manage members and elections in my organization
  I should also be able to add and delete election and be able add and delete members and admins.
  
    Scenario: election panel page should have add, delete election and add position for admin #happy path
    Given I am logged in as a member in CSUA 
    Given I am on the election dashboard page
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    And I should see "Add election"
    And I should see "Add position"
    And I should see "Settings"
    Then I log out

  Scenario: election panel page should NOT have add, delete election and add position for super-admin #sad path
    Given I am on the show elections page for a member
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out

  Scenario: election panel page should NOT have add, delete election and add position for member #sad path
    Given I am on the show elections page for a member
    Then I should see "Click on an election to see election status."
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
    Then I log out
  
  Scenario: election panel page should NOT have add, delete election and add position for non-member #sad path
    Given I am on the show elections page for a member
    Then I should see "You are not a registered member. Please make sure your organization leader has added your name and email to the system before trying to log in."
    Then I should see "CSUA Voting System"
    And I should not see "Add election"
    And I should not see "Add position"
    And I should not see "Settings"
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