Feature: Admin Settings Page and Member Management 
  As an admin,
  I want to have access to the settings page for the organization I am an admin for,
  So that I can add / drop other admins, upload CSV file to update members of my organization and add / delete individual members.
	
	Scenario: Has access to settings page
    Given I am logged in as an admin
    Then I should see "Settings"
  
  Scenario: Default Settings Page: Admin A for CSUA (happy path)
    Given I am logged in as an admin
    And On the settings page for an admin
    Then I should see "CSUA"
    And I should not see "HKN"
    Then I should see "Upload a CSV File for Admins"
    And I should see "Add/Delete an Admin"
    And I should see "Members"
    And I should see "Admins"
    Then I log out
    
  Scenario: Default Settings Page: user that is not an admin for CSUA (sad path)
    Given I am logged in as an admin
    And On the settings page for an admin
    Then I should see "CSUA"
    And I should not see "HKN"
    Then I log out
  
  Scenario: Admin uploading CSV file to add members: successful (happy path)
    Given I am logged in as an admin
    And On the settings page for an admin
    Given an import file exists with the following data:
      | Name        | Email               |
      | TestAdmin   | TestAdmin@gmail.com |
    And I click Upload CSV
    Then I should see "CSUA"
    Then I should see an alert that says "Upload successful"
    And I go to the settings page for an admin
    And I should see a list of preset members for CSUA
    Then I log out
  
  Scenario: Admin uploading CSV file to add members: failed (sad path)
    Given I am logged in as an admin
    And On the settings page for an admin
    And I click Upload CSV
    And I supply a non-CSV file
    Then I should see an alert that says "Upload failed, the file must be a .csv file"
    Then I should be on the settings page for "CSUA"
    Then I log out

  Scenario: Adding member that does not exist already (happy path)
    Given I am logged in as an admin
    And On the settings page for an admin
    And I fill in the field "user_name" with "User A"
    And I fill in the field "user_email" with "a@gmail.com"
    And I click Add
    And On the settings page for an admin
    Then I should see "CSUA"
    And I should see "User A"
    And I should see "a@gmail.com"
    Then I log out

  Scenario: Adding member that does exist already (sad path)
    Given I am logged in as an admin
    And On the settings page for an admin
    Given that "User A" with email "a@gmail.com" is a member for "CSUA"
    And I fill in the field "user_name" with "User A"
    And I fill in the field "user_email" with "a@gmail.com"
    And I click Add
    Then I should see an alert that says "Member already exist"
    Then I log out

  Scenario: Adding another admin that doesn't exist already (happy path)
    Given I am logged in as an admin
    And On the settings page for an admin
    And I fill in the field "user_name" with "Admin B"
    And I fill in the field "user_email" with "b@gmail.com"
    And I click Add
    And Pn the settings page for an admin
    Then I should see "CSUA"
    And I should see "Admin B"
    And I should see "b@gmail.com"
    Then I log out

  Scenario: Adding another admin that is already an admin (sad path)
    Given I am logged in as an admin
    And On the settings page for an admin
    And I fill in the field "user_name" with "Admin B"
    And I fill in the field "user_email" with "b@gmail.com"
    And I click Add
    Then I should see an alert that says "User Added"
    And I fill in the field "user_name" with "Admin B"
    And I fill in the field "user_email" with "b@gmail.com"
    And I click Add
    Then I should see an alert that says "Admin already exist"
    And On the settings page for an admin
    And I should see "Admin B"
    And I should see "b@gmail.com"
    Then I log out
    
  Scenario: Adding another admin that was a member
    Given I am logged in as an admin
    And On the settings page for an admin
    And I fill in the field "user_name" with "Person A"
    And I fill in the field "user_email" with "a@gmail.com"
    And I click Add
    Then I should see an alert that says "User Added"
    And I fill in the field "user_name" with "Person A"
    And I fill in the field "user_email" with "a@gmail.com"
    And I click Add
    Then I should see an alert that says "Member already exist"
    And I should see "Person A"
    And I should see "a@gmail.com"
    Then I log out
