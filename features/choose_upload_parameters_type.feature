Feature: allow users to choose between uploading, filling out a form, and choosing existing params file

  As a chemist
  So that I can choose parameters in a convenient way
  I want to be able to choose the best way to chose parameters


Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in
  And I am on the Upload Parameters page
  And the following results - params - data files exist for the user
    |       results             | params      | data                   |
    | results1.zxml             | params1.txt |       data1.zxml       |
    | results2.zxml             | params2.txt |       data2.zxml       |
    | results3.zxml             | params3.txt |       data3.zxml       |


Scenario: choose to fill out a parameters form
  Given I follow "Create a new parameters file"
  Then I should be on the "Parameters Form" page

Scenario: choose an old parameters file
  Given I press "Choose Existing Files"
  And I see a list of existing parameters files
  And I select an option
  And I press "Save and Next"
  Then I should be on the "Review And Run" page

Scenario: a params file has already been uploaded
  Given I upload just a param file
  And I press "Choose Existing Files"
  Then I should see "You have already uploaded mass_params.txt."
  And I select an option
  And I press "Save and Next"
  Then I should be on the "Review and Run" page

