Given /^I am signed in$/ do  
  visit login_path
  visit oauth_callback_test2_path
end  

When /^Google authorizes me$/ do
  visit oauth_callback_test2_path
end