require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:chrome) do |task|
	task.profile = 'chrome_jenkins'
end

Cucumber::Rake::Task.new(:iphone) do |task|
	task.profile = 'iphone_jenkins'
end

task :chromeCI => :chrome
task :iphoneCI => :iphone