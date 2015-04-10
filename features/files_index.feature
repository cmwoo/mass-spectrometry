Feature: allow users to see index of all their uploaded files

  As a chemist
  So that I can see all my past results and inputs
  I want to view a table of my data files, parameter files, and results files

Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in
  And the following results - params - data files exist
    |       results                 | params        | data                   |
    | results1.zxml             | params1.txt |       data1.zxml       |
    | results2.zxml             | params2.txt |       data2.zxml       |
    | results3.zxml             | params3.txt |       data3.zxml       |


Scenario: list the user’s existing files
  Given that I am on the user’s information page
  Then I should see a list of all my data, params, and results