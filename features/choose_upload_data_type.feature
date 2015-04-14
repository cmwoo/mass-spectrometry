Feature: allow users can choose between uploading and choosing existing data xml file

  As a chemist
  So that I do not have to waste time uploading the same data file
  I want to be able to choose data xml files that I have already uploaded


Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in
  And I am on the Upload XML page

Scenario: choose to upload data xml file
  Then I should see "xml_file"

Scenario: choose an old data xml file
  Given I follow "Choose Existing Data"
  Then I should see a list of existing data xml files