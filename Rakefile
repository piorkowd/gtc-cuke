require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |task|
	task.profile = 'jenkins'
end

task :default => :cucumber