Given /the following elections exist/ do |elections_table|
  movies_table.hashes.each do |movie|
    Election.create!(movie)
  end
end

When(/^I press Delete election for "([^"]*)"$/) do |arg1|
  # fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end


Then(/^I should see a list of candidates$/) do
  # fail "Unimplemented"
end

Then(/^I should not see a modal dialog$/) do
  # fail "Unimplemented"
end

Given(/^I have just voted for a candidate and cache contains secret key$/) do
  # fail "Unimplemented"
end

Then(/^I should have an encrypted value of my votes\# need step def$/) do
  # fail "Unimplemented"
end

Then(/^I should have a decryped value of my votes \# need step def$/) do
  # fail "Unimplemented"
end

Given(/^I have just voted for a candidate and cache does not contain a secret$/) do
  # fail "Unimplemented"
end

When(/^I attempt to encrypt the votes$/) do
  # fail "Unimplemented"
end

Then(/^I should not have a encrypted value$/) do
  # fail "Unimplemented"
end

When(/^I fill in "([^"]*)" with (\d+)$/) do |arg1, arg2|
  # fail "Unimplemented"
end

When(/^I press the drop down menu$/) do
  # fail "Unimplemented"
end

Given(/^I have just voted for a candidate$/) do
  # fail "Unimplemented"
end

Then(/^I should see a modal dialog$/) do
  # fail "Unimplemented"
end

When(/^I enter the secret key$/) do
  # fail "Unimplemented"
end

Then(/^I should see a confirmation page$/) do
  # fail "Unimplemented"
end

Then(/^I should have an encrypted value of my votes$/) do
  # fail "Unimplemented"
end

Then(/^I should have a decryped value of my votes$/) do
  # fail "Unimplemented"
end

Then(/^I should see an error$/) do
  # fail "Unimplemented"
end