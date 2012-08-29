@login
Feature: Login
	In order to interact with the system
	As a fleet administrator
	I want to log into the system

	@positive
	Scenario: Successfully log in with accurate information
		Given I am on the Zonar login page
		When I use correct login information
		And I click the login button
		Then I should be viewing the reports menu

	@negative
	Scenario: Fail logging in with incorrect password
		Given I am on the Zonar login page
		When I use an incorrect password
		And I click the login button
		Then I should see a login error message

	@negative
	Scenario: Fail logging in with empty customer
		Given I am on the Zonar login page
		When I use an empty customer
		And I click the login button
		Then I should stay on the login page

	@negative
	Scenario: Fail logging in with empty user name
		Given I am on the Zonar login page
		When I use an empty user name
		And I click the login button
		Then I should stay on the login page

	@negative
	Scenario: Fail logging in with empty password
		Given I am on the Zonar login page
		When I use an empty password
		And I click the login button
		Then I should stay on the login page
		
	@fail
	Scenario: Expect a success with incorrect information
		Given I am on the Zonar login page
		When I use an incorrect password
		And I click the login button
		Then I should be viewing the reports menu
		