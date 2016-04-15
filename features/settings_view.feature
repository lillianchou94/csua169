Feature: Admin Settings Page and Member Management 
  As an admin,
  I want to have access to the settings page for the organization I am an admin for,
  So that I can add / drop other admins, upload CSV file to update members of my organization and add / delete individual members.
	
	Scenario: Has access to settings page (should work for all users)
    Given I am logged in as an admin
    Then I should see "Settings"
  
  Scenario: Default Settings Page: Admin A for CSUA (happy path)
    Given I am logged in as an admin
    And I follow "Settings"
    Then I should see "CSUA"
    And I should not see "HKN"
    Then I click on "CSUA"
    Then I should see "Upload CSV"
    And I should see "Add member"
    And I should see "Delete member"
    And I should see "Add admin"
    And I should see "Delete admin"
    And I should see "Members"
    And I should see "Admins"
    
  Scenario: Default Settings Page: user that is not an admin for any org (sad path)
    Given I am signed in as "Member A"
    And I follow "Settings"
    Then I should not see "CSUA"
    And I should not see "HKN"
    And I should see "You're not an admin for any organization."
  
  Scenario: Admin uploading CSV file to add members: successful (happy path)
    Given I am an admin on the settings page for "CSUA"
    And I click "Upload CSV"
    And I supply the preset CSV file
    Then I should be on the settings page for "CSUA"
    And I should see "Upload successful"
    And I should see a list of preset members for CSUA
    
  Scenario: Admin uploading CSV file to add members: failed (sad path)
    Given I am an admin on the settings page for "CSUA"
    And I click "Upload CSV"
    And I supply a non-CSV file
    Then I should be on the settings page for "CSUA"
    And I should see "Upload failed, the file must be a .csv file"

  Scenario: Adding member that does not exist already (happy path)
    Given I am an admin on the settings page for "CSUA"
    Given that there are no members in the organization
    And I fill in "Name" with "User A"
    And I fill in "Email" with "a@gmail.com"
    And I click "Add member"
    Then I should be on the settings page for "CSUA"
    And I should see "User A"

  Scenario: Adding member that does exist already (sad path)
    Given I am an admin on the settings page for "CSUA"
    Given that "User A" with email "a@gmail.com" is a member for "CSUA"
    And I fill in "User Name" with "User A"
    And I fill in "User Email" with "a@gmail.com"
    And I click "Add member"
    Then I should see an alert that says "Member already exist"

  Scenario: Adding another admin that doesn't exist already (happy path)
    Given I am an admin on the settings page for "CSUA"
    And I fill in "Admin Name" with "Admin B"
    And I fill in "Admin Email" with "b@gmail.com"
    And I click "Add admin"
    Then I should be on the settings page for "CSUA"
    And I should see "Admin A"

  Scenario: Adding another admin that is already an admin (sad path)
    Given I am an admin on the settings page for "CSUA"
    And I fill in "Admin Name" with "Admin B"
    And I fill in "Admin Email" with "b@gmail.com"
    And I click "Add admin"
    Then I should be on the settings page for "CSUA"
    And I should see "Admin A"
    
  Scenario: Adding another admin that was a member
    Given I am an admin on the settings page for "CSUA"
    Given "Person A" with email "a@gmail.com" is a member
    And I fill in "Admin Name" with "Person A"
    And I fill in "Admin Email" with "a@gmail.com"
    And I click "Add admin"
    Then I should be on the settings page for "CSUA"
    And I should see "Person A" as an admin
    And I should not see "Person A" as a member
