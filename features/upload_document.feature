Feature: allow users to upload documents

  As a chemist
  So that I can run my mass spectrometry data
  I want to upload a mass spectrometry xml data file to the website

  As a chemist
  So that I can run my mass spectrometry data with the right parameters
  I want to upload a params file to the website

  As a chemist
  I want to store my files on the website
  So that I can run them remotely and get results

Background: 
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |

Scenario: upload a mass spectrometry xml data file
  Given I am logged in
  And I am on the Upload XML page
  And I upload an xml file
  And I press "Next"
  Then I should be on the Upload Parameters page

Scenario: upload a param file
  Given I am logged in
  And I am on the Upload Parameters page
  And I upload a param file
  And I press "Next"
  Then I should be on the Review and Run page

Scenario: upload a mass spectrometry xml data file with no file
  Given I am logged in
  And I am on the Upload XML page
  And I press "Next"
  Then I should be on the Upload XML page

Scenario: upload a param file with no param file
  Given I am logged in
  And I am on the Upload Parameters page
  And I press "Next"
  Then I should be on the Upload Parameters page

Scenario: upload a mass spectrometry xml data file without logging in
  Given I am on the home page
  And I visit the Upload XML page
  Then I should be on the login page

Scenario: upload a param file without logging in
  Given I am on the home page
  And I visit the Upload Parameters page
  Then I should be on the login page

Scenario: upload a data file when there's already an uploaded data file
  Given I am logged in
  And I am on the Upload XML page
  And I upload just an xml file
  And I press "Save and Next"
  And I visit the Upload XML page
  Then I should see "You have already uploaded mass_data.xml"

Scenario: upload a params file when there's already an uploaded params file
  Given I am logged in
  And I am on the Upload Parameters page
  And I upload just a param file
  And I press "Save and Next"
  And I visit the Upload Parameters page
  Then I should see "You have already uploaded mass_params.txt"
