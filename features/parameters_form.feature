Feature: allow parameters to be input and generated through a form

  As a chemist
  So that I can choose parameters on the website instead of uploading a file
  I want to be able to fill out a form that will generate the proper parameters file


Background:
  Given the following accounts exist:
    |       email       | password | password_confirmation |
    | chemist@gmail.com | aaaaaaaa |       aaaaaaaa        |
  And I am logged in

Scenario: input parameters through a form
  Given that I am on the Upload Parameters page
  And I follow "Parameters Form"
  And fill out the form
  And I press "Submit"
  Then I should be on the Review and Run page