Feature: allow people to sign up for accounts

  As a chemist
  I want to signup a user account
  So that I can have all my data, params and results associated with my account
 
Scenario: User can sign up a new account
  Given I am on the login page
  When I follow “Create a new account”
  Then I should be on the signup page
  When I fill in “username” with “chemist”
  And I fill in “password” with “aaaaaa”
  And I fill in “email” with “chemist@gmail.com”
  And I follow “Sign Up”
  Then I should be on the home page
  And I should be logged in

Scenario: User cannot sign up with existing username
  Given I am on the login page
  When I follow “Create a new account”
  Then I should be on the signup page
  When I fill in “username” with “chemist”
  And I fill in “password” with “aaaaaa”
  And I fill in “email” with “example@gmail.com”
  And I follow “Sign Up”
  Then I should be on the login page
  And I should see “This username has been taken”

Scenario: User cannot sign up with existing email address
  Given I am on the login page
  When I follow “Create a new account”
  Then I should be on the signup page
  When I fill in “username” with “mass-spec”
  And I fill in “password” with “aaaaaa”
  And I fill in “email “ with “chemist@gmail.com” 
  And I follow “Sign Up”
  Then I should be on the login page
  And I should see “An account already exists with this email address”