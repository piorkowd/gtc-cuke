require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:chrome) do |task|
	task.profile = 'chrome_jenkins'
end

Cucumber::Rake::Task.new(:chrome_fail) do |task|
	task.profile = 'chrome_jenkins_fail'
end

Cucumber::Rake::Task.new(:iphone) do |task|
	task.profile = 'iphone_jenkins'
end

Cucumber::Rake::Task.new(:iphone_fail) do |task|
	task.profile = 'iphone_jenkins_fail'
end

task :chromeCI => :chrome
task :chromeCI_FAIL => :chrome_fail
task :iphoneCI => :iphone
task :iphoneCI_FAIL => :iphone_fail