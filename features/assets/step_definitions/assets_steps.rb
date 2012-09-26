mobileAssetsUrl = "https://qa1.zonarsystems.net/mobile/assets"

When /^I click the "(.*)" link$/ do |linkName|
	@browser.link(:text => "#{linkName}").click
	@browser.ul(:class => "ui-listview").li(:class => "btn_as ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-btn-hover-d ui-btn-up-d ui-btn-active").wait_while_present
	
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