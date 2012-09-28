@dashboard
Feature: Dashboard
	In order to easily view fleet information
	As a fleet administrator
	I want to view the dashboard

	@positive @mobile
	Scenario: View dashboard menu
		Given I am logged into Zonar
		When I click the "Dashboard" mobile link
		Then I should be viewing the dashboard page
	
	@positive @chrome
	Scenario: View dashboard menu
		Given I am logged into Zonar
		When I click the "Dashboard" menu link
		Then I should be viewing the dashboard page