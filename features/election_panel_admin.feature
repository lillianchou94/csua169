Feature: Election panel content
  As a admin
  So that I can manage members and elections in my organization
  I should also be able to add and delete election and be able add and delete members and admins.
  
    Scenario: election panel page should have add, delete election and add position for admin #happy path
    Given I am logged in as an admin in CSUA 
    And I am on the election dashboard page
    Then I should see in the browser "Click on an election to see election status."
    Then I should see in the browser "CSUA Voting System"
    And I should see in the browser "Add election"
    And I should see in the browser "Add position"
    And I should see in the browser "Settings"
    Then I log out

  Scenario: election panel page should NOT have add, delete election and add position for super-admin #sad path
    Given I am logged in as a super admin
    And I am on the election dashboard page
    Then I should see in the browser "Click on an election to see election status."
    Then I should see in the browser "CSUA Voting System"
    And I should not see in the browser "Add election"
    And I should not see in the browser "Add position"
    And I should not see in the browser "Settings"
    Then I log out

  Scenario: election panel page should NOT have add, delete election and add position for member #sad path
    Given I am logged in as a member in CSUA
    And I am on the election dashboard page
    Then I should see in the browser "Click on an election to see election status."
    Then I should see in the browser "CSUA Voting System"
    And I should not see Add election
    And I should not see in the browser "Add position"
    And I should not see in the browser "Settings"
    Then I log out
  
  Scenario: election panel page should NOT have add, delete election and add position for non-member #sad path
    Given I am logged in as a non member 
    # Given I am on the show elections page for a member
    And I am on the election dashboard page
    Then I should see "CSUA Voting System"
    And I should not see in the browser "Add election"
    And I should not see in the browser "Add position"
    And I should not see in the browser "Settings"
    Then I log out
    
  Scenario: admin for CSUA (election page)
    Given I am logged in as an admin in CSUA
    And I am on the show elections page for an admin
    When I click Add election
    Then I should see in the browser "Organization:"
    Then I log out