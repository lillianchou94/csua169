source 'https://rubygems.org'

ruby '2.3.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', :group => [:development, :test]
group :production do
  gem 'thin'
  gem 'pg'
end

gem "fakeweb", "~> 1.3"

gem 'coveralls', require: false

gem "codeclimate-test-reporter", group: :test, require: nil

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

#OAuth authentication
gem 'omniauth'
gem 'omniauth-google-oauth2'

gem 'rspec-core'

gem 'cucumber' 

gem 'database_cleaner', '~> 1.5', '>= 1.5.1'

gem 'protected_attributes'

gem 'responders'

gem 'rspec'

gem 'jquery-ui-rails'

gem 'bootstrap-sass'

gem 'capybara'

gem 'selenium-webdriver'
#gem "capybara-webkit" 

gem 'headless'

# bundle exec rake doc:rails generates the API under doc/api.

gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  
  gem 'cucumber-rails', :require => false
  gem 'simplecov', :require => false
  
  gem 'rspec-rails', '~> 3.0'
  gem 'test-unit-rails'
  gem "selenium-client", ">=1.2.18"
  gem 'watir-webdriver'
  gem 'chromedriver-helper'
  gem 'webmock'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'factory_girl_rails'
end