
And /^(?:|I )select radio button "([^"]*)" from "([^"]*)"$/ do |field, form|
  # @driver.find_element(:id => field).click
end

Then /^(?:|I )should not see in the browser "([^"]*)"$/ do |text|
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # wait.until { @driver.page_source.exclude? text }
end

Then /^(?:|I )should see in the browser "([^"]*)"$/ do |text|
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # wait.until { @driver.page_source.include? text }
end

And(/^it is the nomination phase$/) do
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

And(/^it is not the nomination phase$/) do
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end