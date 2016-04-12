Feature: Add and delete elections
  As a admin
  I want to be able to add elections and delete elections
  So that I can start elections and end elections
  
  Background:
    Given I am logged in as an admin
    
  # @javascript
  Scenario: Add election
    Given I am on the show elections page for an admin
    When I press "Add election"
    # Then in the popup window, there should be "Organization:"
    # Then I confirm popup
    # Then "Organization:" is in a new window
    And I add the election called "election1"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    # When I am on the election list page
    Then I should see "election1"
    Then I should see "New election name:"
    Then I should see "Add position"
    
  Scenario: Admin elections page with delete feature
    Given I am on the show elections page for an admin
    Then I should see an element with id "delete_election_id"
    # When I press Delete election for "Election 1"
    Then I should be on the show elections page for an admin
    And I should not see "Election 1"