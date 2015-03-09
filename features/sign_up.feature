Feature: Sign up
  In order to join rathole community
  As an anonymous user
  I want to be able to walk through sign up

Scenario: Sign up using email and password
  Given I am anonymous user
  And I am on the sign up page
  When I fill "Email" with "test@example.com"
  And I fill "Login" with "test"
  And I fill "Password" with "secret123"
  And I fill "Password again" with "secret123"
  And I click on button "Sign up"
  Then I should see ".alert-info" with text "Well done and welcome!"
