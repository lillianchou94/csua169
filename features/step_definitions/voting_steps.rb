Given(/^"([^"]*)" exists$/) do |arg1|
  fail "Unimplemented"
end

Then(/^I click on "([^"]*)"$/) do |arg1|
  id = @driver.find_element(:id => "select_election_CSUA04262016_1")
  id.click
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "CSUA" }

end

Then(/^I press on "([^"]*)" for nominations$/) do |button|
  @driver.find_element(:id => button).click
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "nomination"}
end

Then(/^I press on "([^"]*)" for voting$/) do |button|
  @driver.find_element(:id => button).click
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "voting"}
end

When /^(?:|I )press on "([^"]*)"$/ do |button|
  # wait = Selenium::WebDriver::Wait.new(timeout: 40)
  # wait.until { @driver.page_source.include? button}
  # button_hashtag = "\"$('#"+button+"').parents().css({'display':'block','visibility':'visible'})\""
  # @driver.execute_script(button_hashtag)
  #@driver.execute_script("get_election_dashboard('CSUA04272016')")
  @driver.find_element(:id => button).click
  # wait = Selenium::WebDriver::Wait.new(timeout: 40)
  # wait.until { @driver.page_source.include? "Start nomination"}
end

Then(/^I click on "([^"]*)" to start a nomination$/) do |button|
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? button }

  button_hashtag = "\"$('#"+button+"').parents().css({'display':'block','visibility':'visible'})\""
  @driver.execute_script(button_hashtag)
  id = @driver.find_element(:id => button)
  id.click
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? "Start nomination" }
end

Given(/^the election "([^"]*)" exists for "([^"]*)"$/) do |election_name, org|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  wait.until { @driver.page_source.include? "New election name:" }
  raise "Error add" unless @driver.page_source.include? "Add Election"
  
  @driver.execute_script("$('#new_election_org').parents().css({'display':'block','visibility':'visible'})")
  @driver.execute_script("$('#new_election_name').parents().css({'display':'block','visibility':'visible'})")
  @driver.execute_script("$('#election_submit').parents().css({'display':'block','visibility':'visible'})")
  org_element = @driver.find_element(:id => 'new_election_org')
  org_element.click
  election_elem = @driver.find_element(:id => 'new_election_name')
  election_elem.click
  election_elem.clear
  election_elem.send_keys election_name
  org_submit = @driver.find_element(:id => 'electionform').submit
  
  wait = Selenium::WebDriver::Wait.new(timeout: 40)
  wait.until { @driver.page_source.include? election_name }
  raise "Error election not found" unless @driver.page_source.include? election_name
end

Given(/^the position "([^"]*)" exists for "([^"]*)"$/) do |position_name, election|
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # raise "Error add position" unless @driver.page_source.include? "Add Position"
  # wait.until { @driver.page_source.include? "New position:" }
  #raise "Error position" unless @driver.page_source.include? "New position:"
  
  # @driver.execute_script("$('#new_position_name').parents().css({'display':'block','visibility':'visible'})")
  # position_element = @driver.find_element(:id => 'new_position_name')
  # position_element.click
  # position_element.clear
  # position_element.send_keys position_name
  # position_submit = @driver.find_element(:id => 'positionform').submit
  
  # wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # wait.until { @driver.page_source.include? position_name }
  # raise "Error position not found" unless @driver.page_source.include? position_name
end

When(/^I select "([^"]*)"$/) do |candidate|
  @driver = Selenium::WebDriver.for :firefox
end

Given(/^I voted for "([^"]*)" for postion "([^"]*)"$/) do |candidate, position|
  @driver = Selenium::WebDriver.for :firefox
end

Given(/^the election "([^"]*)" has started$/) do |election_name|
  @driver = Selenium::WebDriver.for :firefox
end

Then(/^I should see a timeout error$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 100)
  @driver = Selenium::WebDriver.for :firefox
  
end

Then(/^I should see a popup$/) do
  @driver = Selenium::WebDriver.for :firefox
end

When(/^I enter a password$/) do
  @driver = Selenium::WebDriver.for :firefox
end

Then(/^I should have an "([^"]*)" value of votes$/) do |arg1|
  @driver = Selenium::WebDriver.for :firefox
end

Then(/^I should have a "([^"]*)" value of votes$/) do |arg1|
  @driver = Selenium::WebDriver.for :firefox
end