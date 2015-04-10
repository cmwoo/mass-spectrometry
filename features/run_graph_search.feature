Feature: allow users to run the graph search program on their data

  As a chemist
  So that I can receive an analysis of my data
  I want to run the graph search program on my data

Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in

Scenario: upload and run graph search program on data
  Given I upload an xml and param file
  And I am on the Review and Run page
  And I should see the files I uploaded
  And I press "Run"
  Then I should be on the Finish page
  And I should see "Graph search is successfully running. You will receive an email when your analysis is complete."

Scenario: do not run if no params file selected
  Given I am on the Upload XML page
  And I upload an xml file
  And I press "Next"
  And I am on the Review and Run page
  Then I should see "No params file selected"

Scenario: do not run if no data file selected
  Given I am on the Upload Parameters page
  And I upload a param file
  And I press "Next"
  And I am on the Review and Run page
  Then I should see "No data file selected"