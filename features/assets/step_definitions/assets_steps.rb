mobileAssetsUrl = "https://qa1.zonarsystems.net/mobile/assets"
mobileUrl = "https://qa1.zonarsystems.net/mobile"

Given /^I am viewing the assets page$/ do
	if ENV['IPHONE']
		if @browser.url != mobileAssetsUrl
			@browser.goto mobileUrl
			@browser.link(:text => "Asset Lookup").click
			@browser.ul(:class => "ui-listview").li(:class => "btn_as ui-btn ui-btn-icon-right ui-li-has-arrow ui-li ui-btn-hover-d ui-btn-up-d ui-btn-active").wait_while_present
		end
	end
	
	if ENV['CHROME']
		# TODO
	end
end

When /^I search for (.*) assets$/ do |searchTerm|
	if ENV['IPHONE']
		@browser.text_field(:class => "ui-input-text ui-body-c").set "#{searchTerm}"
	end
	
	if ENV['CHROME']
		# TODO
	end
end

Then /^I should be viewing the assets page$/ do
	if ENV['IPHONE']
		if @browser.url != mobileAssetsUrl
			puts "Expected final URL: #{mobileAssetsUrl}"
			puts "Actual final URL: #{@browser.url}"
			raise
		end
	end
	
	if ENV['CHROME']
		# TODO
	end
end

Then /^I should only see (.*) assets$/ do |assetMatch|
	if ENV['IPHONE']
		listItems = @browser.ul(:class => "ui-listview ui-listview-inset ui-corner-all ui-shadow").lis
		
		listItems.each do |li|
			if !li.attribute_value(:class).include? "ui-screen-hidden"
				if !li.text.downcase.include? "#{assetMatch.downcase}"
					puts "Expected to see in asset text: #{assetMatch}"
					puts "Actual asset text: #{li.text}"
					raise
				end
			end
		end
	end
	
	if ENV['CHROME']
		# TODO
	end
end