@logout
Feature: Logout
	In order to prevent misuse
	As a fleet administrator
	I want to log out of the system

	@positive
	Scenario: Successfully log out
		Given I am logged into Zonar
		When I click the logout link
		Then I should be on the home page