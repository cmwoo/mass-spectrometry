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

Scenario: choose to upload input parameters
  Then I should see "param_file"

Scenario: choose to fill out a parameters form
  Given I follow "Parameters Form"
  Then I should see the parameters form

Scenario: choose an old parameters file
  Given I follow "Choose Existing Parameters"
  Then I should see a list of existing parameters files