Feature: allow people to sign in to their account
  As a chemist
  I want to sign in to my account
  So that I can view all my data, params and results and initiate new runs

Background: 
  Given my account has been set up
  And I am on the login page

Scenario: User can sign in with correct username and password
  When I fill in correct username and password
  And I follow “Sign In”
  Then I should be on the home page
  And I should be logged in

Scenario: User cannot sign in with incorrect username and password
  When I fill in incorrect username and password
  And I follow “Sign In”
  Then I should be on the login page
  And I should see “Invalid username or password”