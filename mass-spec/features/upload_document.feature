Feature: allow users to upload documents

  As a chemist
  So that I can run my mass spectrometry data
  I want to upload a mass spectrometry xml data file to the website

  As a chemist
  So that I can run my mass spectrometry data with the right parameters
  I want to upload a params file to the website

Scenario: upload a good mass spectrometry xml data file
  Given I am on the Upload XML page
  And I upload a proper xml file
  And I fill in "Email" with "example@example.com"
  And I press "Submit"
  Then I should be on the Upload Parameters page

Scenario: upload a bad mass spectrometry xml data file
  Given I am on the Upload XML page
  And I upload an incorrect xml file
  And I fill in "Email" with "example@example.com"
  And I press "Submit"
  Then I should be on the Upload Parameters page

Scenario: upload a good param file
  Given I am on the Upload Parameters page
  And I upload a proper param file
  And I press "Submit"
  Then I should be on the Review and Run page

Scenario: upload a bad param file
  Given I am on the Upload Parameters page
  And I upload an incorrect param file
  And I press "Submit"
  Then I should be on the Review and Run page
  