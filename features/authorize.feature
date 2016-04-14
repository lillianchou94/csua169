Feature: secure login
  As an admin and user
  I want to be able to log in via Google OAuthentication
  So that I can vote securely and I can only vote once
  
  Scenario: logging in (/dashboard/home)
    Given I am on the dashboard page as an admin
    Then I should see "CSUA Voting System"
    And I should see "Sign in with Google"
    Then I am logged in as an admin
    And I see "Hello,"
    And I see "Sign out"
    # Given I am on the show elections page for an admin
    # Then I should see "Add election"
    # When I press "Add election"
    # Then I am on the signout page
    And I log out
  
  # Scenario: authentication failure page
  #   Given I am on the authentication failure page
  #   Then I should see "CSUA Voting System"