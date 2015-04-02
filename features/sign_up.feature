Feature: allow people to sign up for accounts

  As a chemist
  I want to signup a user account
  So that I can have all my data, params and results associated with my account
 
Scenario: User can sign up a new account
  Given I am on the home page
  When I follow "Signup"
  Then I should be on the signup page
  And I fill in "user_email" with "chemist@gmail.com"
  And I fill in "user_password" with "aaaaaaaa"
  And I fill in "user_password_confirmation" with "aaaaaaaa"
  And I press "Sign up"
  Then I should be on the home page
  And I should see "Logged in as chemist@gmail.com"

Scenario: User cannot sign up with existing email address
  Given the following accouts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am on the home page
  When I follow "Signup"
  Then I should be on the signup page
  And I fill in "user_email" with "chemist@gmail.com"
  And I fill in "user_password" with "aaaaaaaa"
  And I fill in "user_password_confirmation" with "aaaaaaaa"
  And I press "Sign up"
  Then I should be on the signup page
  # And I should see "Email has already been taken"
