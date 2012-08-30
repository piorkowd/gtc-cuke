# Test environment setup
require 'watir-webdriver'
require 'watir-webdriver-performance'
require 'yaml'

if ENV['HEADLESS']
	FileUtils.rm 'report.html' if File.exists? 'report.html'
	FileUtils.rm_rf 'screenshots' if File.exists? 'screenshots'
	FileUtils.rm 'chromedriver.txt' if File.exists? 'chromedriver.txt'
	FileUtils.rm 'scenario_run_times.yml' if File.exists? 'scenario_run_times.yml'

	require 'headless'
	headless = Headless.new
	headless.start
	
	at_exit do
		headless.destroy
	end
end

browser = Watir::Browser.new :chrome
scenarioRunTimes = []

# Run before every scenario
Before do
	@browser = browser
	@runtime = 0
end

# Run after every scenario
After do |scenario|
	if (scenario.failed?) then
		Dir::mkdir('screenshots') if not File.directory?('screenshots')
		screenshot = "./screenshots/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
		browser.screenshot.save(screenshot)
		embed screenshot, 'image/png'
	end
	
	scenarioRunTime = {
		:scenario => scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, ''),
		:run_time => @runtime
	}
	scenarioRunTimes << scenarioRunTime
end

# Test environment teardown
at_exit do
	File.open('scenario_run_times.yml', 'w') { |file| file.puts scenarioRunTimes.to_yaml }
	browser.close
end