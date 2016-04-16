require 'tempfile'

Then(/^I click on "([^"]*)"$/) do |arg1|
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

Given(/^I click "([^"]*)"$/) do |arg1|
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end


Given /^an import file exists with the following data:$/ do |field_table|
  report = Ruport::Data::Table.new(:column_names => field_table.hashes.first.keys)
  field_table.hashes.each { |hash| report << hash }
  @current_import_file = Tempfile.new("import.csv")
  @current_import_file << report.to_csv
  @current_import_file.close
end

And(/^On the settings page for an admin$/) do
  #session[:user_id] = 1
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until {@driver.page_source.include? "Settings"}
  @driver.find_element(:id => "settings").click
  #click_button("Settings")
  # delete_elem = @driver.find_element(:id => "settings")
  # puts @driver.page_source
  # delete_elem.click
  # raise "Error delete2" unless not @driver.page_source.include? election_name
end

Then(/^I should see a list of preset members for CSUA$/) do
  assert page.has_content?("TestAdmin")
  assert page.has_content?("TestAdmin@gmail.com")
end

Given(/^I supply a non\-CSV file$/) do
end

Given(/^that there are no members in the organization$/) do
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

Given(/^that "([^"]*)" with email "([^"]*)" is a member for "([^"]*)"$/) do |arg1, arg2, arg3|
  assert page.has_content?(arg1)
  assert page.has_content?(arg2)
  assert page.has_content?(arg3)
end

Then(/^I should see an alert that says "([^"]*)"$/) do |arg1|
  page.driver.browser.switch_to.alert.accept
end

Given(/^"([^"]*)" with email "([^"]*)" is a member$/) do |arg1, arg2|
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" as an admin$/) do |arg1|
  fail "Unimplemented" # Write code here that turns the phrase above into concrete actions
end

Then(/^I should not see "([^"]*)" as a member$/) do |arg1|
  fail "Unimplemented"
end
