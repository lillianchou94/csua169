Given /the following elections exist/ do |elections_table|
  movies_table.hashes.each do |movie|
    Election.create!(movie)
  end
end

When(/^I press Delete election for "([^"]*)"$/) do |arg1|
   fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end
 
When(/^I add the organization called "([^"]*)" \# need step def$/) do |arg1|
  fail "Unimplemented"
end

Then(/^I should see a drop down menu to the right of "([^"]*)" \# need step def$/) do |arg1|
  fail "Unimplemented"
end

Then(/^I should see "([^"]*)" in the drop down menu to the right of "([^"]*)" \# need step def$/) do |arg1, arg2|
  fail "Unimplemented"
end

Then(/^I should see "([^"]*)" in the "([^"]*)" field \# need step def$/) do |arg1, arg2|
  fail "Unimplemented"
end

Then(/^I should not see "([^"]*)" in the drop down menu to the right of "([^"]*)" \# need step def$/) do |arg1, arg2|
  fail "Unimplemented"
end

Then(/^I should see "([^"]*)" \# need step def$/) do |arg1|
  fail "Unimplemented"
end

When(/^I press the drop down menu \# need step def$/) do
  fail "Unimplemented"
end

Then(/^I should see a list of candidates$/) do
  fail "Unimplemented"
end

When(/^I press "([^"]*)" \# need step def$/) do |arg1|
  fail "Unimplemented"
end

Given(/^I have just voted for a candidate \# need step def$/) do
  fail "Unimplemented"
end

Then(/^I should see a modal dialog \# need step def \-> Selenium$/) do
  fail "Unimplemented"
end

When(/^I enter the secret key \# need step def$/) do
  fail "Unimplemented"
end

Then(/^I should see a confirmation page \# need step def$/) do
  fail "Unimplemented"
end

Then(/^I should not see a modal dialog$/) do
  fail "Unimplemented"
end

Given(/^I have just voted for a candidate and cache contains secret key$/) do
  fail "Unimplemented"
end

Then(/^I should have an encrypted value of my votes\# need step def$/) do
  fail "Unimplemented"
end

Then(/^I should have a decryped value of my votes \# need step def$/) do
  fail "Unimplemented"
end

Given(/^I have just voted for a candidate and cache does not contain a secret$/) do
  fail "Unimplemented"
end

When(/^I attempt to encrypt the votes$/) do
  fail "Unimplemented"
end

Then(/^I should not have a encrypted value$/) do
  fail "Unimplemented"
end

Then(/^I should see an error \# need step definition$/) do
  fail "Unimplemented"
end

When(/^I fill in "([^"]*)" with (\d+)$/) do |arg1, arg2|
  fail "Unimplemented"
end