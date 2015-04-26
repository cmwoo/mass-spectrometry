Feature: allow users to see index of all their uploaded files

  As a chemist
  So that I can get a copy of my past results and inputs
  I want to download my data files, parameter files, and results files

Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in
  And the following results - params - data files exist for the user
    |       results             | params      | data                   |
    | results1.zxml             | params1.txt |       data1.zxml       |
    | results2.zxml             | params2.txt |       data2.zxml       |

Scenario: download the user’s existing files
  Given I am on the user information page
  Then "results1.zxml" links to the corresponding results file stored in s3 server
  And "data1.zxml" links to the corresponding data file stored in s3 server
