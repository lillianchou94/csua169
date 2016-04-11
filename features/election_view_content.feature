Feature: Election pages content
  As a admin
  I want to see my Election Panel
  So that I can see all the elections I am a part of and I can add new elections
  
  @omniauth_test
  Scenario: logging in (/dashboard/home)
    Given I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"
    Then I follow "Sign in with Google"
    Then I am on the dashboard page as an admin
    And I should see "Hello,"
    #Cs is the first name of the user specified in env.rb
    And I should see "Cs"
    And I should see "Sign out"
    Then I am on the show elections page for an admin
    And I should see "Add election"
    When I press "Add election"
    # Then I should see "Organization"
    When I am on the dashboard page as an admin 
    When I follow "Sign out"
    Then I am on the signout page
    And I should see "Sign in with Google"
    And I should not see "Sign out"
    
  #@omniauth_test
  Scenario: logging in (/login)
    Given I am on the login page
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"
    When I follow "Sign in with Google"
    Then I am on the dashboard page as an admin
    And I should see "Sign out"
    
  Scenario: Admin elections page with delete feature
    Given I am on the show elections page for an admin
    Then I should see an element with id "delete_election_id"
    # When I press Delete election for "Election 1"
    Then I should be on the show elections page for an admin
    And I should not see "Election 1"
    
  # @javascript
  Scenario: Admin elections page
    Given I am on the show elections page for an admin
    When I press "Add election"
    # Then in the popup window, there should be "Organization:"
    # Then I confirm popup
    # Then "Organization:" is in a new window
    # And I add the election called "election1"
    Then I should be on the show elections page for an admin
    And I should see "Add election" 
    # When I am on the election list page
    Then I should see "election1"
    Then I should see "New election name:"
    Then I should see "Add position"
  
  Scenario: authentication failure page
    Given I am on the authentication failure page
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"
 
  Scenario: election dashboard page
    Given I am on the election dashboard page
    # Given I am on the add election page
  # Scenario: delete election page
  #   Given I am on the delete election page
  # Scenario: add position page
  #   Given I am on the add position page
  # Scenario: delete position page
  #   Given I am on the delete position page
  # Scenario: home page
  #   Given I am on the home page
  
  
  # happy paths for add organization  
  Scenario: super-admin election page
    Given I am on the show elections page for a super-admin
    Then I should see "Add organization"
    When I press "Add organization"
    # need step def
    And I add the organization called "org1"
    Then I should be on the show elections page for an super-admin
    Then I should see "Add organization"
    And I should see "org1"
    
  # sad paths for add organization
  Scenario: admin election page (no add org button)
    Given I am on the show elections page for an admin
    Then I should not see "Add organization"
    
  Scenario: regular member election page (no add org button)
    Given I am on the show elections page for a member
    Then I should not see "Add organization"
    
  # drop down org field in add election window
  Scenario: admin for "org1" and "org2" (election page)
    Given I am on the show elections page for an admin
    When I press "Add election"
    Then I should see "Organization:"
    # need step def
    And I should see a drop down menu to the right of "Organization:"
    # need step def
    And I should see "org1" in the drop down menu to the right of "Organization:"
    # need step def
    And I should see "org2" in the drop down menu to the right of "Organization:"
    When I press "org1"
    # need step def
    Then I should see "org1" in the "Organization:" field
    
  Scenario: admin for "org1" (election page)
    Given I am on the show elections page for an admin
    When I press "Add election"
    Then I should see "Organization:"
    # need step def
    And I should see a drop down menu to the right of "Organization:"
    # need step def
    And I should see "org1" in the drop down menu to the right of "Organization:"
    # need step def
    And I should not see "org2" in the drop down menu to the right of "Organization:"
    When I press "org1"
    # need step def
    Then I should see "org1" in the "Organization:" field