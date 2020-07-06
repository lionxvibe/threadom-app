require 'resque/scheduler/tasks'
require 'resque/tasks'
task 'resque:setup' => :environment
namespace :resque do
  task :setup do
    require 'resque'
    require 'resque-scheduler'
    ENV['QUEUE'] ||= '*'
  end
end