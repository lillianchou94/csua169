Feature: secure login
  As an admin and user
  I want to be able to log in via Google OAuthentication
  So that I can vote securely and I can only vote once
  
  Scenario: logging in (/dashboard/home)
    Given I am on the dashboard
    Then I see "CSUA Voting System"
    And I see "Sign in with Google"
    Then I am logged in as an admin in CSUA
    And I should see "Hello,"
    And I should see "Sign out"
    Given I am on the show elections page for an admin
    Then I should see "Add election"
    When I click Add election
    Then I am on the signout page
    And I log out
  
  # Scenario: authentication failure page
  #   Given I am on the authentication failure page
  #   Then I see "CSUA Voting System"