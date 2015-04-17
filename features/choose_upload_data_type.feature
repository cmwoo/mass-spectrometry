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
  And the following results - params - data files exist for the user
    |       results             | params      | data                   |
    | results1.zxml             | params1.txt |       data1.zxml       |
    | results2.zxml             | params2.txt |       data2.zxml       |
    | results3.zxml             | params3.txt |       data3.zxml       |

Scenario: choose an old data xml file
  Given I press "Choose Existing Files"
  And I see a list of existing data xml files
  And I select an option
  And I press "Save and Next"
  Then I should be on the "Upload Parameters" page

Scenario: a data file has already been uploaded
  Given I upload just an xml file
  And I press "Choose Existing Files"
  Then I should see "You have already uploaded mass_data.xml."
  And I select an option
  And I press "Save and Next"
  Then I should be on the "Upload Parameters" page
