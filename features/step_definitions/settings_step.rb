require 'tempfile'

Given /^an import file exists with the following data:$/ do |field_table|
  report = field_table
  User.create!(:user_name => "TestAdmin", :user_email => "TestAdmin@gmail.com", :organization => "CSUA", :user_prime => 1, :admin_status => 1)
end

Then /^(?:|I )should see on the settings page "([^"]*)"$/ do |text|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until { @driver.page_source.include? "Admins" }
end

And(/^On the settings page for an admin$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until {@driver.page_source.include? "Settings"}
  @driver.find_element(:id => "settings").click

end

And (/^I click Add$/) do
  @driver.find_element(:id => "submit_button").click
end

And (/^I click Upload CSV/) do
  @driver.find_element(:id => "submit_button").click
end

When /^(?:|I )fill in the field "([^"]*)" with "([^"]*)"$/ do |field, value|
  @driver.find_element(:name, field).send_keys value
end


Then(/^I should see a list of preset members for CSUA$/) do
  @driver.find_element(:id,'admin_individual_form').displayed?
  @driver.find_element(:id,'dvImportSegments').displayed?
end

Given(/^I supply a non\-CSV file$/) do
end

Given(/^that "([^"]*)" with email "([^"]*)" is a member for "([^"]*)"$/) do |name, email, org|
  User.create!(:user_name => name, :user_email => email, :organization => org, :user_prime => 1, :admin_status => 1)
  @driver.find_element(:id => "settings").click
end

Then(/^I should see an alert that says "([^"]*)"$/) do |arg1|
  a = @driver.switch_to.alert
  a.accept
end


Then(/^I should see "([^"]*)" as an admin$/) do |arg1|
  assert page.has_content?(arg1)
end

Then(/^I should not see "([^"]*)" as a member$/) do |arg1|
  assert page.has_content?(arg1)
end
