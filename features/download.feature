Feature: be able to download executable
  As a chemist
  I want to download the executable
  So that I can run the program locally

Background:
  Given my account has been set up

Scenario: User can download the windows executable
  Given I am on the downloads page
  When I follow "windows executable"
  Then I should receive the file "mass-spec.exe"

Scenario: User can download the unix executable
  Given I am on the downloads page
  When I follow "unix executable"
  Then I should receive the file "mass-spec"

Scenario: User can download an example params file
  Given I am on the downloads page
  When I follow "example params file"
  Then I should receive the file "sample-params.txt"