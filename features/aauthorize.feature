Feature: secure login
  As an admin and user
  I want to be able to log in via Google OAuthentication
  So that I can vote securely and I can only vote once
  
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
    Given I am on the show elections page for an admin
    Then I should see "Add election"
    When I press "Add election"
    Then I am on the dashboard page as an admin
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
  
  Scenario: authentication failure page
    Given I am on the authentication failure page
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"