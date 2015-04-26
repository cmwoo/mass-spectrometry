Feature: Download files off of downloads page
  As a chemist
  I want to download the executables
  So that I can run the program locally

Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in

Scenario: User can download the windows executable
  Given I am on the downloads page
  When I follow "Graph_search.exe"
  Then I should receive the file "Graph_search.exe"

Scenario: User can download an example params file
  Given I am on the downloads page
  When I follow "ExampleParams.params"
  Then I should receive the file "ExampleParams.params"