
And /^(?:|I )select radio button "([^"]*)" from "([^"]*)"$/ do |field, form|
  # @driver.find_element(:id => field).click
end

Then /^(?:|I )should not see in the browser "([^"]*)"$/ do |text|
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # wait.until { @driver.page_source.exclude? text }
end

Then /^(?:|I )should see in the browser "([^"]*)"$/ do |text|
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? text }
end

And(/^it is the nomination phase$/) do
  # fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

And(/^it is not the nomination phase$/) do
  # fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

And /^(?:|I )start next phase with election ID "([^"]*)"$/ do |election_id|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until { @driver.page_source.include? "Add election" }
  @driver.execute_script("return goto_next_phase('"+election_id+"')")
end

And /^(?:|I )am on the special page "([^"]*)"$/ do |uri|
  @driver.navigate.to "https://csuavoting.herokuapp.com"+uri
end