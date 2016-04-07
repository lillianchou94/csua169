Given /the following elections exist/ do |elections_table|
  movies_table.hashes.each do |movie|
    Election.create!(movie)
  end
end

When(/^I press Delete election for "([^"]*)"$/) do |arg1|
   fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end
 