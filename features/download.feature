Feature: be able to download executable
  As a chemist
  I want to download the executable
  So that I can run the program locally

Scenario: User can download the windows executable
  Given I am on the downloads page
  Then I should see "GraphSearch.exe"

Scenario: User can download an example params file
  Given I am on the downloads page
  Then I should see "SampleParams.params"

