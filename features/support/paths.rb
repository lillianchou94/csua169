# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /^the home\s?page$/
      '/home'
    when /^the login page$/
      '/login'
    when /^the dashboard page as an admin$/
      '/dashboard/home'
    when /^the settings page for an admin$/
      '/election_settings'
    when /^the show elections page for a super-admin$/
      '/login'
    when /^the show elections page for a member$/
      '/'
    when /^the show elections page for a "voter"$/
      '/'
    when /^the show elections page for an admin$/
      '/'
    when /^the dashboard page as a specialadmin$/
      '/dashboard/home'
    when /^the dashboard page for a member/
      '/dashboard/home'
    when /^the dashboard page for googleuser$/
      '/dashboard/home'
    when /^the add election page$/
      '/election_add_election'
    when /^the delete election page$/
      '/election_delete_election'
    when /^the add position page$/
      '/election_add_position'
    when /^the delete position page$/
      '/election_delete_position'
    when /^the election list page$/
      '/election_list/'
    when /^the authentication failure page$/
      '/auth/failure'
    when /^the signout page$/
      '/signout'
    when /^the election dashboard page$/
      '/election_dashboard'
    when /^the election embed livestream page$/
      '/election_embed_livestream'
    when /^the election page$/
      '/elections'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
