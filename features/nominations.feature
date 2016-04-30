Feature: Nominate candidates
  As a member of CSUA
  I want to nominate a member for a position
  So that we can vote for the candidate I nominated
  
  Scenario: Nominate a candidate
    # during nomination phase
    Given I am logged in as an admin in CSUA
    And I am on the dashboard page as an admin 
    When I setup cucumber tests
    Then I should see in the browser "cucumber test election"
    Then I should see in the browser "CSUA00000000__president"
    When I click in the browser "CSUA00000000__president"
    Then I should not see in the browser "Click on an election to see election status"
    And I click in the browser "start_nomination_id"
    Then I should not see in the browser "start_nomination_id"
    When I click in the browser "CSUA00000000__president"
    Then I should not see in the browser "Click on an election to see election status"
    Then I log out
  
  Scenario: Not nomination phase
    Given I am logged in as a member in CSUA
    And I am on the dashboard page for a member 
    Then I should see in the browser "cucumber test election"
    When I click in the browser "CSUA00000000__president"
    And it is not the nomination phase
    Then I should not see in the browser "Begin nomination"
    Then I log out
    
  Scenario: Non-special admin cannot start nomination phase
    Given I am logged in as a member in CSUA
    And I am on the dashboard page for a member
    When I setup cucumber tests
    Then I should see in the browser "cucumber test election"
    Then I should see in the browser "CSUA00000000__president"
    When I click in the browser "CSUA00000000__president"
    Then I should not see in the browser "Start nomination"
    Then I log out
    
  Scenario: Special admin start nomination phase
    Given I am logged in as an admin in CSUA
    And I am on the dashboard page as an admin 
    When I setup cucumber tests
    Then I should see in the browser "cucumber test election"
    Then I should see in the browser "CSUA00000000__president"
    When I click in the browser "CSUA00000000__president"
    And it is not the nomination phase
    Then I should not see in the browser "Click on an election to see election status"
    Then I log out
  
  Scenario: Member in another org should not be seen in nomination
    Given I am logged in as a member in CSUA
    And I am on the dashboard page for a member
    When I setup cucumber tests
    Then I should see in the browser "CSUA00000000__president"
    When I click in the browser "CSUA00000000__president"
    And it is the nomination phase
    Then I should not see in the browser "Click on an election to see election status"
    And I should not see in the browser "TestUser NotInOrg"
    Then I log out
    
  Scenario: Cannot nominate invalid candidate
    Given I am logged in as an admin in CSUA
    And I am on the dashboard page as an admin 
    When I setup cucumber tests
    Then I should see in the browser "cucumber test election"
    Then I should see in the browser "CSUA00000000__president"
    When I click in the browser "CSUA00000000__president"
    Then I should not see in the browser "fakeemail@notarealaddress.com"
    Then I log out