Feature: be able to store files that you uploaded
  As a chemist
  I want to store my files on the website
  So that I can run them remotely and get results

Background:
  Given my account has been set up
  And I am on the "Upload Data" page

Scenario: User can upload and store a data file
  Given I upload "test.xml"
  And I press "Submit"
  Then I should be on the "Upload Parameters" page
  And I should see "Data upload completed"