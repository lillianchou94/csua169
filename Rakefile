# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

Require file.expand_path('../config/application', __FILE__)
	Rails.application.load_tasks
     if not Rails.env.production? 
     	require 'rspec/core/rake_task'
     	require 'cucumber/rake/task'
     	require 'coveralls/rake/task'
    
     	Coveralls::RakeTask.new
     	Cucumber::Rake::Task.new(:features)
RSpec::Core::RakeTask.new(:spec)
    
task :default => [:spec, :features, 'coveralls:push']
end
