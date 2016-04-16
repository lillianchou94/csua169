Feature: Nominate candidates
  As a member of CSUA
  I want to nominate a member for a position
  So that we can vote for the candidate I nominated
  
  #a@gmail.com = Adam Rockler
  # Background:
  #   Given I am logged in as an admin
  #   And I add the election called "test election" for the organization "CSUA"
  
  Scenario: Nominate a candidate
    # during nomination phase
    Given I am logged in as a member
    And I am on the dashboard page for a member 
    Then I should see in the browser "test election"
    Then I should see in the browser "new_election_org04162016__test_candidate"
    When I click in the browser "new_election_org04162016__test_candidate"
    Then I should see in the browser "Nomination for test_candidate"
    And I select radio button "id_email1111222@gmail.com" from "nomination_form_id"
    And I click in the browser "nomination_form_submit_id"
    Then I should see in the browser "Submitted nominations successfully"
    
    # can only nominate once?
    And I should see in the browser "test election"
    When I click in the browser "new_election_org04162016__test_candidate"
    Then I should see in the browser "Nomination for test_candidate"
    And I select radio button "id_email1111222@gmail.com" from "nomination_form_id"
    And I click in the browser "nomination_form_submit_id"
    Then I should not see in the browser "Submitted nominations successfully."
    
    #Then I should see in the browser "You have already nominated for this position"
    Then I log out
  
  Scenario: Not nomination phase
    #Given I am logged in as a member
    #And I am on the dashboard page for a member 
    #Then I should see in the browser "test election"
    #When I press "test candidate"
    #And it is not the nomination phase
    #Then I should not see "Nominate"
    #Then I log out
    
  Scenario: Non-special admin cannot start nomination phase
    #Given I am logged in as a member
    #And I am on the dashboard page for a member
    #Then I should see "test election"
    #When I press "test candidate"
    #And it is not the nomination phase
    #Then I should not see "Nominate"
    #Then I log out
    
  Scenario: Special admin start nomination phase
    #Given I am logged in as a special admin
    #And I am on the dashboard page as a specialadmin
    #Then I should see "test election"
    #When I press "test candidate"
    #And it is not the nomination phase
    #Then I should see "Start nomination phase"
    #When I press "Start nomination phase"
    #And I fill in "nomination threshold" with 1
    #And I press "Submit"
    #Then I should see "Nominations"
    #And I should see "Email"
    #And I should see "Submit"
    #Then I log out
    
  Scenario: Nominate invalid candidate
    Given I am logged in as a member
    And I am on the dashboard page for a member 
    Then I should see in the browser "test election"
    When I click in the browser "new_election_org04162016__test_candidate"
    Then I should not see in the browser "fakeemail@notarealaddress.com"
    And I should see in the browser "nomination_form_submit_id"
    Then I log out