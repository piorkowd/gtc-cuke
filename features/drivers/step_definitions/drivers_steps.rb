When /^I click the drivers menu link$/ do
	@browser.link(:text => 'Drivers').click
	@runtime += @browser.performance.summary[:response_time]/1000.0
end

Then /^I should see the drivers menu$/ do
	if (!(@browser.div(:id => "tab_drivers").style =~ /display: block;/)) then
		puts "Expected id tab_drivers div style: display: block;"
		puts "Actual id tab_drivers div style: #{@browser.div(:id => "tab_drivers").style}"
		raise
	end
end