Feature: allow people to sign in to their account
  As a chemist
  I want to sign in to my account
  So that I can view all my data, params and results and initiate new runs

Background: 
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  Given I am on the home page
  When I follow "Login"
  Then I should be on the login page

Scenario: User can sign in with correct username and password
  When I fill in "user_email" with "chemist@gmail.com"
  And I fill in "user_password" with "aaaaaaaa"
  And I press "Log in"
  Then I should be on the home page
  And I should see "Logged in as chemist@gmail.com"

Scenario: User cannot sign in with incorrect username and password
  When I fill in "user_email" with "chemist@gmail.com"
  And I fill in "user_password" with "bbbbbbbb"
  And I press "Log in"
  Then I should be on the login page
  # And I should see "Invalid username or password"
