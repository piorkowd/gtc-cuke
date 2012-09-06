validCustomer = "dev0002"
validUsername = "paras"
validPassword = "password"
invalidPassword = "incorrectPassword"
emptyString = ""
loginErrorMessage = "Your login failed. Please check your username and password and try again."
loginUrl = "https://qa1.zonarsystems.net/user/login/"
reportMenuUrl = "https://qa1.zonarsystems.net/dashboard/reports"

Given /^I am on the Zonar login page$/ do
	@browser.goto loginUrl
	add_runtime
	
	if (@browser.link(:text => 'Logout').exists?) then
		@browser.link(:text => 'Logout').click
	end
end

When /^I use correct login information$/ do
	@browser.text_field(:name => 'customer').set validCustomer
	@browser.text_field(:name => 'username').set validUsername
	@browser.text_field(:name => 'password').set validPassword
end

When /^I use an incorrect password$/ do
	@browser.text_field(:name => 'customer').set validCustomer
	@browser.text_field(:name => 'username').set validUsername
	@browser.text_field(:name => 'password').set invalidPassword
end

When /^I use an empty customer$/ do
	@browser.text_field(:name => 'customer').set emptyString
	@browser.text_field(:name => 'username').set validUsername
	@browser.text_field(:name => 'password').set validPassword
end

When /^I use an empty user name$/ do
	@browser.text_field(:name => 'customer').set validCustomer
	@browser.text_field(:name => 'username').set emptyString
	@browser.text_field(:name => 'password').set validPassword
end

When /^I use an empty password$/ do
	@browser.text_field(:name => 'customer').set validCustomer
	@browser.text_field(:name => 'username').set validUsername
	@browser.text_field(:name => 'password').set emptyString
end

When /^I click the login button$/ do
	@browser.button(:name => 'gologin').click
	add_runtime
end

Then /^I should be viewing the reports menu$/ do
	if (@browser.url != reportMenuUrl) then
		puts "Expected final URL: #{reportMenuUrl}"
		puts "Actual final URL: #{@browser.url}"
		raise
	end
end

Then /^I should see a login error message$/ do
	if (!@browser.text.include? loginErrorMessage) then
		puts "Expected browser text to include: #{loginErrorMessage}"
		raise
	end
end

Then /^I should stay on the login page$/ do
	if (@browser.url != loginUrl) then
		puts "Expected final URL: #{loginUrl}"
		puts "Actual final URL: #{@browser.url}"
		raise
	end
end