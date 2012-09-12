# Test environment setup
require 'watir-webdriver'
require 'yaml'

#if ENV['HEADLESS']
#	require 'headless'
#	headless = Headless.new
#	headless.start
	
#	at_exit do
#		headless.destroy
#	end
#end

if ENV['CHROME']
	require 'watir-webdriver-performance'

	browser = Watir::Browser.new :chrome
	scenarioRunTimes = []
end

if ENV['IPHONE']
    require 'sim_launcher'
    
    # Start iPhone simulator
    simulator = SimLauncher::DirectClient.new("/Users/Shared/Jenkins/iWebDriver.app", "5.0", "iphone")
    simulator.relaunch
   
	# see if iWebDriver is loaded(contact the host)
	# retry a few times just incase
	connected = false
	(0..2).each do
		begin
			Net::HTTP.new("localhost", 3001).start
			connected = true
			break
		rescue
			# sleep for two seconds
			sleep(2)
		end
	end

  unless connected
    raise 'Could not launch iPhone webdriver'
  end
    # Connect to iPhone simulator
	driver = Selenium::WebDriver.for :remote, :url => "http://localhost:3001/wd/hub", :desired_capabilities => :iphone
	browser = Watir::Browser.new driver
end

# Cleanup old reports
FileUtils.rm 'report.html' if File.exists? 'report.html'
FileUtils.rm_rf 'screenshots' if File.exists? 'screenshots'
FileUtils.rm 'chromedriver.txt' if File.exists? 'chromedriver.txt'
FileUtils.rm 'scenario_run_times.yml' if File.exists? 'scenario_run_times.yml'

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
	
	if ENV['CHROME']
		scenarioRunTime = {
			:scenario => scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, ''),
			:run_time => @runtime
		}
		scenarioRunTimes << scenarioRunTime
	end
end

# Test environment teardown
at_exit do
	if ENV['CHROME']
		File.open('scenario_run_times.yml', 'w') { |file| file.puts scenarioRunTimes.to_yaml }
	end
	browser.close
end