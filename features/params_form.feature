Feature: Download files off of downloads page
  As a chemist
  I want to download the executables
  So that I can run the program locally

Scenario: User can download the windows executable
  Given I am on the downloads page
  When I follow "graph_search.exe"
  Then I should receive the file "graph_search.exe"

Scenario: User can download an example params file
  Given I am on the downloads page
  When I follow "sample_params.params"
  Then I should receive the file "sample_params.params"