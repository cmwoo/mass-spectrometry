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
  Then I should see "Graph search is successfully running. You will be able to download the results from the uploads page when your analysis is complete."

Scenario: do not run if no params file selected
  Given I am on the Upload XML page
  And I upload just an xml file
  And I press "Save and Next"
  And I am on the Review and Run page
  Then I should see "Please select a parameters file."

Scenario: do not run if no data file selected
  Given I am on the Upload Parameters page
  And I upload just a param file
  And I press "Save and Next"
  And I am on the Review and Run page
  Then I should see "Please select a data .mzXML file."
