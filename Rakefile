require 'bundler/setup'

#require 'fileutils'

Dir.glob('lib/tasks/*.rake').each { |r| import r }

task :default => [:list]

desc 'Lists all the tasks'
task :list do
  puts "Tasks: \n- #{(Rake::Task.tasks).join("\n- ")}"
end

begin
  require "kitchen/rake_tasks"
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV["CI"]
end
