@assets
Feature: Assets
	In order to manage assets
	As a fleet administrator
	I want to access asset information

	@positive @mobile
	Scenario: View asset menu
		Given I am logged into Zonar
		When I click the Asset Lookup link
		Then I should be viewing the assets page
	
#	@positive @chrome
#	Scenario: View asset menu
#		Given I am logged into Zonar
#		When I click the "Admin" link
#		And When I click the 

	@positive
	Scenario: Find an asset
		Given I am logged into Zonar
		And I am viewing the assets page
		When I search for Ford assets
		Then I should only see Ford assets
		
	@fail
	Scenario: Expect an impossible result 
		Given I am logged into Zonar
		And I am viewing the assets page
		When I search for GMC assets
		Then I should only see Dodge assets