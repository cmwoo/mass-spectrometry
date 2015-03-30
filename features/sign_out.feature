Feature: allow users to sign out
  As a chemist
  I should be able to log out
  So that I can be sure my information is only accessible by me

Scenario: User can log out
  Given my account has been set up
  And I am logged in
  When I follow “Sign Out”
  Then I should be on the home page
  And I should be logged out