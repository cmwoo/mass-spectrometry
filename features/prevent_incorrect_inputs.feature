Feature: allow people to only upload the correct file formats so their program runs correctly

  As a chemist
  So that I can ensure my program runs correctly
  I want to be reminded to only upload the correct format of files to the website

Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in

Scenario: upload an incorrect data file
  Given I am on the Upload XML page
  And I upload a param file
  And I press "Next"
  Then I should see "File format must be .zxml"

Scenario: upload an incorrect param file
  Given I am on the Upload Parameters page
  And I upload an xml file
  And I press "Next"
  Then I should see "File format must be .param or .txt"