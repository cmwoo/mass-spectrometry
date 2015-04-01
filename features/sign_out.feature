Feature: allow users to sign out
  As a chemist
  I should be able to log out
  So that I can be sure my information is only accessible by me

Scenario: User can log out
  Given the following accouts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am on the home page
  When I follow "Login"
  And I fill in "user_email" with "chemist@gmail.com"
  And I fill in "user_password" with "aaaaaaaa"
  And I press "Log in"
  Then I should be on the home page
  When I follow "Logout"
  Then I should be on the home page
  And I should see "Signup"
