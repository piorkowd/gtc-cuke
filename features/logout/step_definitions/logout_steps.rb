homeUrl = "https://qa1.zonarsystems.net/"

When /^I click the logout link$/ do
	@browser.link(:text => 'Logout').click
	add_runtime
end

Then /^I should be on the home page$/ do
	if (@browser.url != homeUrl) then
		puts "Expected final URL: #{homeUrl}"
		puts "Actual final URL: #{@browser.url}"
		raise
	end
end