chromeLoginUrl = "https://qa1.zonarsystems.net/user/login"
mobileLoginUrl = "https://qa1.zonarsystems.net/mobile"
validCustomer = "dev0002"
validUsername = "paras"
validPassword = "password"

Given /^I am logged into Zonar$/ do
	if ENV['CHROME']
		@browser.goto chromeLoginUrl
		add_runtime
	elsif ENV['IPHONE']
		@browser.goto mobileLoginUrl
	end
	
	if @browser.button(:name => 'gologin').exists?
		@browser.text_field(:name => 'customer').set validCustomer
		@browser.text_field(:name => 'username').set validUsername
		@browser.text_field(:name => 'password').set validPassword
		@browser.button(:name => 'gologin').click
	end
end

When /^I click the "(.*)" menu link$/ do |linkText|
	@browser.div(:id => "menuBody").link(:text => linkText).click
	add_runtime
end

When /^I click the "(.*)" mobile link$/ do |linkText|
	# Mobile only
	@browser.ul(:class => "ui-listview").link(:text => linkText).click
	@browser.ul(:class => "ui-listview").li(:class => "btn_as ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-btn-hover-d ui-btn-up-d ui-btn-active").wait_while_present
end

def add_runtime
	if ENV['CHROME']
		@runtime += @browser.performance.summary[:response_time]/1000.0
	end
end