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
  Given I am on the Upload Parameters page
  And I follow "Create a new parameters file"
  And I fill in "file_filename" with "test_form"
	And I fill out the parameters form
  And I press "Save File"
 	Then I should receive the file "test_form.params"
	And the downloaded file content should be:
    """
 		charge_min: file_charge_min
    charge_max: file_charge_max
    mz_tolerance: file_mz_tolerance
    mz_tolerance_2: file_mz_tolerance_2
    scan_tolerance: file_scan_tolerance
    pattern_size: file_pattern_size
    min_score: file_min_score
    retention_time_window: file_retention_time_window
    include_mass_mod: file_include_mass_mod
    sigma: file_sigma
    per_sigma: file_per_sigma
    log_file: file_log_file.log
    search_pattern: file_search_pattern
    alt_pattern: file_alt_pattern
    alt_pattern: alt_pattern_more
    full_output: false
    inclusion_list: false
    mz_charge: false
    mz_charge_scan: false

    """
