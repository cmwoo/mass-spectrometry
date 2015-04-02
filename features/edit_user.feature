Feature: allow users to edit their account settings
  As a chemist
  I can edit my account settings
  So that I can have results sent to the correct email

  Background: 
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  Given I am on the login page
  Then I fill in "user_email" with "chemist@gmail.com"
  Then I fill in "user_password" with "aaaaaaaa"
  Then I press "Log in"

Scenario: User can edit account information
  Given I am on the edit profile page
  And I fill in "user_email" with "changed@gmail.com"
  And I fill in "user_current_password" with "aaaaaaaa"
  And I press "Update"
  Then I should be on the home page
  And I should see "changed@gmail.com"

Scenario: User cannot edit information without correct password
  Given I am on the edit profile page
  And I fill in "user_email" with "changed@gmail.com"
  And I fill in "user_current_password" with "incorrect"
  And I press "Update"
  Then I should see "Current password is invalid"