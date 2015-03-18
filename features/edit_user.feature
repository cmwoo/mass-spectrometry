Feature: allow users to edit their account settings
  As a chemist
  I can edit my account settings
  So that I can have results sent to the correct email

Scenario: User can edit account information
  Given my account has been set up
  And I am logged in
  And I am on the edit information page
  And I fill in “First Name” with “Daenerys”
  And I click “Submit”
  Then I should be on the user information page
  And my first name should be “Daenerys”