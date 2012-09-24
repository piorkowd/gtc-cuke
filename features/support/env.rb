# Test environment setup
require "bundler"
if ENV['CHROME']
	Bundler.require(:default, :chrome)
elsif ENV['IPHONE']
	Bundler.require(:default, :iphone)
else
	Bundler.require(:default)
end



# Disable buffered output
$stdout.sync = true

# Chrome setup
if ENV['CHROME']
	browser = Watir::Browser.new :chrome
	scenarioRunTimes = []
end

# iPhone simulator setup
if ENV['IPHONE']
    # Start iPhone simulator
	puts "Launching iOS Simulator"
    simulator = SimLauncher::Client.new("/Users/Shared/Jenkins/iWebDriver.app", "5.0", "iphone")
    simulator.relaunch
	puts "Launched iOS Simulator"
	
    # See if iWebDriver is loaded (contact the host)
    # Retry a few times just in case
    connected = false
    (0..2).each do
        begin
			puts "Trying to connect to iWebDriver"
            Net::HTTP.new("localhost", 3001).start
            connected = true
            break
        rescue
			puts "Connect failed, wait and try again"
            # sleep for two seconds
            sleep(2)
        end
    end

    unless connected
        puts "Could not launch iPhone webdriver"
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
	# Capture screenshot if scenario fails
	if (scenario.failed?) then
		Dir::mkdir('screenshots') if not File.directory?('screenshots')
		screenshot = "./screenshots/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
		browser.screenshot.save(screenshot)
		embed screenshot, 'image/png'
	end
	
	# Capture runtime if using Chrome
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
	# Save runtimes if using Chrome
	if ENV['CHROME']
		File.open('scenario_run_times.yml', 'w') { |file| file.puts scenarioRunTimes.to_yaml }
	end

	browser.close
end