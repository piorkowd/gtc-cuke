mobileAssetsUrl = "https://qa1.zonarsystems.net/mobile/assets"

When /^I click the "(.*)" link$/ do |linkName|
	@browser.link(:text => "#{linkName}").click
	
	if ENV['CHROME']
		add_runtime
	end
end

Then /^I should be viewing the assets page$/ do
	if (@browser.url != mobileAssetsUrl) then
		puts "Expected final URL: #{mobileAssetsUrl}"
		puts "Actual final URL: #{@browser.url}"
		raise
	end
end