require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'dotenv/tasks'

RSpec::Core::RakeTask.new('spec')

# If you want to make this the default task
task :default => :spec

task :console => :dotenv do
  exec "irb -r directory.rb -I ./lib/nlocal/"
end
