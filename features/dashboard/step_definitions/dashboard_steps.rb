mobileDashboardUrl = "https://qa1.zonarsystems.net/mobile/dash"
chromeDashboardUrl = "https://qa1.zonarsystems.net/dashboard/"

Then /^I should be viewing the dashboard page$/ do
	if ENV['IPHONE']
		if @browser.url != mobileDashboardUrl
			puts "Expected final URL: #{mobileDashboardUrl}"
			puts "Actual final URL: #{@browser.url}"
			raise
		end
	end
	
	if ENV['CHROME']
		if @browser.url != chromeDashboardUrl
			puts "Expected final URL: #{chromeDashboardUrl}"
			puts "Actual final URL: #{@browser.url}"
			raise
		end
	end
end