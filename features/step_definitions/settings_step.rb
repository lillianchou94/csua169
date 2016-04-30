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

When /^(?:|I )fill in the field "([^"]*)" with "([^"]*)"$/ do |field, value|
  @driver.find_element(:name, field).send_keys value
  
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
