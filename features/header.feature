Feature: allow users to click on the website icon to return to home page

  As a chemist
  So that I can follow existing convention to return to the home page
  I want to be able to click on the IsoStamp icon to return to the home page

Scenario: click on the icon and return to home page
  Given I am not on the home page
  And I click on the icon
  Then I should be on the home page
