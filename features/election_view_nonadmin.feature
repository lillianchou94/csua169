Feature: Election pages content for non-admin
  As a voter 
	I want to see my Election Panel
	So that I can see all the elections I am a part of and I can vote in each of these elections
	

  # Voters page for modal dialog
  # Scenario: Voters dashboard page during voting
  #   # need step def
  #   Given I am on the show elections page for a "voter" 
  #   # need step def
  #   Then I should see "Role" 
  #   # need step def
  #   And I should see a drop down menu to the right of "Role" 
  #   # need step def
  #   When I press the drop down menu 
  #   # need step def
  #   Then I should see a list of candidates
  #   When I press "Candidate 1" 
  #   # need step def
  #   Then I should see "Candidate 1" in the "Role" field 
  
  # # Modal Dialog to press password
  # Scenario: First time voting on the computer and cache is cleared
  #   # need step def
  #   Given I have just voted for a candidate
  #   # need step def -> Selenium 
  #   Then I should see a modal dialog
  #   # need step def 
  #   When I enter the secret key
  #   # need step def 
  #   Then I should see a confirmation page

  # # Cache stored password
  # Scenario: Password stored in cache and no longer needs to be entered
  #   # need step def
  #   Given I have just voted for a candidate
  #   Then I should not see a modal dialog
  #   # need step def
  #   And I should see "Candidate 1" in the "Role" field
  
  # # Test encryption
  # Scenario: Correct encryption and decryption after voting
  #   Given I have just voted for a candidate and cache contains secret key 
  #   # need step def
  #   Then I should have an encrypted value of my votes
  #   # need step def
  #   And I should have a decryped value of my votes
  #   # need step def
  #   And I should see "Candidate 1" in the "Role" field
  
  # Scenario: Attempt encrpytion without secret key (sad path)
  #   Given I have just voted for a candidate and cache does not contain a secret
  #   When I attempt to encrypt the votes
  #   Then I should not have a encrypted value
  #   # need step definition
  #   And I should see an error