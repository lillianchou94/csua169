Feature: Voting Livestream
  As an admin
  I want to add an embedded stream when I start the election
  so that absentee can watch the election remotely
  
  Background:
    Given I am logged in as an admin in CSUA
    
  Scenario: election embed livestream page
    Given I am on the election embed livestream page
    Then I log out