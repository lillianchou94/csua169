Feature: Nominate candidates
  As a member of CSUA
  I want to nominate a member for a position
  So that we can vote for the candidate I nominated
  
  #a@gmail.com = Adam Rockler
  
  Scenario: Nominate a candidate
    # during nomination phase
    Given I am logged in as a member
    And I am on the dashboard page for a member 
    Then I should see "test election"
    When I press "test candidate"
    Then I should see "Nominate"
    When I press "Nominate"
    And I select "President" from "Positions"
    And I fill in "Email" with "a@gmail.com"
    And I press "Submit"
    Then I should see "a@gmail.com"
    And I should see "Adam Rockler"
    And I should see "Nominations"
    And I should see "President"
    
    # can only nominate once?
    Given I am on the dashboard page for a member 
    Then I should see "test election"
    When I press "test candidate"
    And it is the nomination phase
    Then I should see "Nominate"
    When I press "Nominate"
    Then I should see "You have already nominated a member."
    Then I log out
  
  Scenario: Not nomination phase
    Given I am logged in as a member
    And I am on the dashboard page for a member 
    Then I should see "test election"
    When I press "test candidate"
    And it is not the nomination phase
    Then I should not see "Nominate"
    Then I log out
    
  Scenario: Non-special admin cannot start nomination phase
    Given I am logged in as a member
    And I am on the dashboard page for a member
    Then I should see "test election"
    When I press "test candidate"
    And it is not the nomination phase
    Then I should not see "Nominate"
    Then I log out
    
  Scenario: Special admin start nomination phase
    Given I am logged in as a special admin
    And I am on the dashboard page as a specialadmin
    Then I should see "test election"
    When I press "test candidate"
    And it is not the nomination phase
    Then I should see "Start nomination phase"
    When I press "Start nomination phase"
    And I fill in "nomination threshold" with 1
    And I press "Submit"
    Then I should see "Nominations"
    And I should see "Email"
    And I should see "Submit"
    Then I log out
    
  Scenario: Nominate invalid candidate
    Given I am logged in as a member
    And I am on the dashboard page for a member 
    Then I should see "test election"
    When I press "test candidate"
    Then I should see "Nominate"
    When I press "Nominate"
    And I select "President" from "Positions"
    And I fill in "Email" with "fakeemail@notarealaddress.com"
    And I press "Submit"
    Then I should see "fakeemail@notarealaddress.com is not a valid user"
    And I should see "President"
    And I should see "Email"
    And I should see "Submit"
    Then I log out