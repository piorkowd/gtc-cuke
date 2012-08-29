loginUrl = "https://qa1.zonarsystems.net/user/login"
validCustomer = "dev0002"
validUsername = "paras"
validPassword = "password"

Given /^I am logged into Zonar$/ do
	@browser.goto loginUrl
	@runtime += @browser.performance.summary[:response_time]/1000.0

	if (!@browser.link(:text => 'Logout').exists?) then
		@browser.text_field(:name => 'customer').set validCustomer
		@browser.text_field(:name => 'username').set validUsername
		@browser.text_field(:name => 'password').set validPassword
		@browser.button(:name => 'gologin').click
	end
	
	
end