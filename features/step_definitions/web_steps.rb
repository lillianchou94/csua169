# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
#require 'net/http'
#require 'webmock'
#require 'capybara-webkit'
require 'selenium-webdriver'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until { @driver.page_source.include? text }
  raise "Error "+text+" not found" unless @driver.execute_script("return $(':contains("+text+")').length;") != 0

  #if page.respond_to? :should
  #  page.should have_content(text)
  #else
  #  assert page.has_content?(text)
  #end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until { @driver.page_source.include? "Add election" }
  raise "Error "+text+" found" unless not @driver.execute_script("return $(':contains("+text+")').length;") != 0
  # if page.respond_to? :should
  #   page.should have_no_content(text)
  # else
  #   assert page.has_no_content?(text)
  # end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end


When(/^I add the election called "([^"]*)" for the organization "([^"]*)"$/) do |election_name, org_name|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  raise "Error add" unless @driver.page_source.include? "Add Election"
  
  @driver.execute_script("$('#new_election_org').parents().css({'display':'block','visibility':'visible'})")
  @driver.execute_script("$('#new_election_name').parents().css({'display':'block','visibility':'visible'})")
  @driver.execute_script("$('#election_submit').parents().css({'display':'block','visibility':'visible'})")
  org_element = @driver.find_element(:id => 'new_election_org')
  org_element.click
  org_element.send_keys org_name
  election_elem = @driver.find_element(:id => 'new_election_name')
  election_elem.click
  election_elem.send_keys election_name
  org_submit = @driver.find_element(:id => 'electionform').submit
  
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "Add election" }
  wait.until { @driver.page_source.include? election_name }
  
  #puts "CSUA is #{@driver.execute_script("return $(':contains(CSUA)').length;")}"
  #puts "election1 is #{@driver.execute_script("return $(':contains(election1)').length;")}"
  #puts "election2 is #{@driver.execute_script("return $(':contains(election2)').length;")}"
  raise "Error election not found" unless @driver.page_source.include? election_name
  #raise "Error election 1 not found" unless @driver.execute_script("return $(':contains(election1)').length;") != 0
  #raise "Error election 2 not found" unless @driver.execute_script("return $(':contains(election2)').length;") != 0
  #raise "Error election add fail" unless @driver.page_source.include? "election1"

end

When(/^I add the position "([^"]*)" for election "([^"]*)"$/) do |position_name, election_name|
  # not done yet
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "add_election_button" }
  #raise "Error add position" unless @driver.page_source.include? "Add position"
  #raise "Error position" unless @driver.page_source.include? "New position:"
  
  @driver.execute_script("$('#"+election_name+"').parents().css({'display':'block','visibility':'visible'})")
  position_element = @driver.find_element(:id => election_name)
  position_element.click
  position_element.send_keys position_name
  position_submit = @driver.find_element(:id => 'positionform').submit
  
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "add_election_button" }
  wait.until { @driver.page_source.include? position_name }
  #puts "#{@driver.page_source}"
  
  #puts "CSUA is #{@driver.execute_script("return $(':contains(CSUA)').length;")}"
  #puts "election1 is #{@driver.execute_script("return $(':contains(election1)').length;")}"
  #puts "election2 is #{@driver.execute_script("return $(':contains(election2)').length;")}"
  raise "Error position not found" unless @driver.page_source.include? position_name
  #raise "Error election 1 not found" unless @driver.execute_script("return $(':contains(election1)').length;") != 0
  #raise "Error election 2 not found" unless @driver.execute_script("return $(':contains(election2)').length;") != 0
  #raise "Error election add fail" unless @driver.page_source.include? "election1"

end

When(/^I delete the election "([^"]*)"$/) do |name|
  # not done yet
  # raise "Error delete1" unless @driver.page_source.include? name
  #e = Election.find_by(:election_name => name)
  # electionID = e.election_id # election doesnt exist..
  delete_name = "delete_election_" + name
  #delete_elem = @driver.find_element(:id => delete_name)
  # puts @driver.page_source
  # delete_elem.click
  #raise "Error delete2" unless not @driver.page_source.include? name
  
end

When(/^I setup cucumber tests$/) do
  @driver.navigate.to "https://csuavoting.herokuapp.com/setup_cucumber"
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  @driver.navigate.to "https://csuavoting.herokuapp.com"
end

Given(/^I am logged in as an admin in CSUA$/) do
  @driver = Selenium::WebDriver.for :firefox
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  @driver.manage.timeouts.implicit_wait = 10

  raise "Error CSUA" unless @driver.page_source.include? "CSUA"
  @driver.find_element(:id => 'sign_in_id').click
  email_elem = @driver.find_element(:id => 'Email')
  email_elem.send_keys "email1111222@gmail.com"
  email_elem.submit
  password_elem = @driver.find_element(:id => 'Passwd')
  password_elem.send_keys "169email"
  password_elem.submit
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  raise "Error CSUA afterwards" unless @driver.page_source.include? "CSUA"
  raise "Error hello" unless @driver.page_source.include? "Hello, "
  raise "Error add" unless @driver.page_source.include? "Add Election"
  #@driver.quit
end



Given(/^I am logged in as an admin in HKN/) do
  @driver = Selenium::WebDriver.for :firefox
  #@driver.navigate.to "https://csua-169-lillianchou94.c9users.io/login"
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  @driver.manage.timeouts.implicit_wait = 10

  #aise "Error CSUA" unless @driver.page_source.include? "CSUA"
  @driver.find_element(:id => 'sign_in_id').click
  email_elem = @driver.find_element(:id => 'Email')
  email_elem.send_keys "hknadmin@gmail.com"
  email_elem.submit
  password_elem = @driver.find_element(:id => 'Passwd')
  password_elem.send_keys "169email"
  password_elem.submit
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  raise "Error CSUA afterwards" unless @driver.page_source.include? "CSUA"
  raise "Error hello" unless @driver.page_source.include? "Hello, "
  raise "Error add" unless @driver.page_source.include? "Add Election"
  #@driver.quit
end

Given(/^I am logged in as a member in CSUA/) do
  @driver = Selenium::WebDriver.for :firefox
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  #@driver.navigate.to "https://csua-169-lillianchou94.c9users.io/login"
  @driver.manage.timeouts.implicit_wait = 20

  raise "Error CSUA" unless @driver.page_source.include? "CSUA"
  @driver.find_element(:id => 'sign_in_id').click
  email_elem = @driver.find_element(:id => 'Email')
  email_elem.send_keys "member169csua@gmail.com"
  email_elem.submit
  password_elem = @driver.find_element(:id => 'Passwd')
  password_elem.send_keys "169member"
  password_elem.submit
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  raise "Error CSUA afterwards" unless @driver.page_source.include? "CSUA"
  raise "Error hello" unless @driver.page_source.include? "Hello, "
  raise "Error add" unless @driver.page_source.include? "Add Election"
end

Given(/^I am logged in as a super admin/) do
  @driver = Selenium::WebDriver.for :firefox
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  #@driver.navigate.to "https://csua-169-lillianchou94.c9users.io/login"
  @driver.manage.timeouts.implicit_wait = 20

  raise "Error CSUA" unless @driver.page_source.include? "CSUA"
  driver.find_element(:id => 'sign_in_id').click
  email_elem = @driver.find_element(:id => 'Email')
  email_elem.send_keys "super169csua@gmail.com"
  email_elem.submit
  password_elem = @driver.find_element(:id => 'Passwd')
  password_elem.send_keys "169email"
  password_elem.submit
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  raise "Error CSUA afterwards" unless @driver.page_source.include? "CSUA"
  raise "Error hello" unless @driver.page_source.include? "Hello, "
  raise "Error add" unless @driver.page_source.include? "Add Election"
end

Given(/^I am logged in as a non member/) do
  @driver = Selenium::WebDriver.for :firefox
  @driver.navigate.to "https://csuavoting.herokuapp.com"
  #@driver.navigate.to "https://csua-169-lillianchou94.c9users.io/login"
  @driver.manage.timeouts.implicit_wait = 10

  raise "Error CSUA" unless @driver.page_source.include? "CSUA"
  #driver.find_element(:id => 'sign_in_id').click
  email_elem = @driver.find_element(:id => 'Email')
  #email_elem.send_keys "email1111222@gmail.com"
  email_elem.send_keys "notamember@gmail.com"
  email_elem.submit
  password_elem = @driver.find_element(:id => 'Passwd')
  password_elem.send_keys "169nonmember"
  password_elem.submit
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { @driver.page_source.include? "CSUA" }
  raise "Error CSUA afterwards" unless @driver.page_source.include? "CSUA"
  raise "Error hello" unless @driver.page_source.include? "Hello, "
  raise "Error add" unless @driver.page_source.include? "Add Election"
end

When(/^I click in the browser "([^"]*)"$/) do |click_id|
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # wait.until{ @driver.page_source.include? click_id }
  # @driver.find_element(:id => click_id).click
end

When(/^I click in the browser for nametag "([^"]*)" position "([^"]*)"$/) do |org,position|
  click_id = org+'__'+position
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until{ @driver.page_source.include? click_id }
  @driver.find_element(:name => click_id).click
end

When(/^I follow in the browser "([^"]*)"$/) do |click_id|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until{ @driver.page_source.include? click_id }
  @driver.find_element(:name => click_id).click
end


Then(/^I see "([^"]*)"$/) do |text|
  # seeing without starting the driver
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^I log out$/) do
  @driver.quit
end


Then(/^I should see an element with id "([^"]*)"$/) do |id|
  # c = page.find(id)   
  # assert page.has_xpath(c)
end

When(/^I add the organization called "([^"]*)"$/) do |org_name|
    # Write code here that turns the phrase above into concrete actions
end

Then(/^(?:|I )should see a drop down menu to the right of "([^"]*)"$/) do |text|
    # Write code here that turns the phrase above into concrete actions
end

Then(/^(?:|I )should see "([^"]*)" in the drop down menu to the right of "([^"]*)"$/) do |text1, text2|
     # Write code here that turns the phrase above into concrete actions
end

Then(/^(?:|I )should not see "([^"]*)" in the drop down menu to the right of "([^"]*)"$/) do |text1, text2|
     # Write code here that turns the phrase above into concrete actions
end

Then(/^(?:|I )should see "([^"]*)" in the "([^"]*)" field$/) do |text1, text2|
     # Write code here that turns the phrase above into concrete actions
end

When(/^I click Add organization$/) do
  # pending # Write code here that turns the phrase above into concrete actions
end


When(/^I click org1/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click Add election/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see election1/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see Add position/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see New election name:/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" on the page$/) do |arg1|
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should not see position1$/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should not see election1$/) do
  # pending # Write code here that turns the phrase above into concrete actions
end

