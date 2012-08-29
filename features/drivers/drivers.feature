@drivers
Feature: Drivers
	In order to manage driver information
	As a fleet administrator
	I want to access driver options

	@positive
	Scenario: View drivers menu
		Given I am logged into Zonar
		When I click the drivers menu link
		Then I should see the drivers menu