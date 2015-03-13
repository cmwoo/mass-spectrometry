
#instead of web_steps and paths
When /^(?:|I )(?:should be|am) on (.+)$/ do |page_name|
  case page_name
    when /the Upload XML page/ then visit new_mass_datum_path
    when /the Upload Parameters page/ then visit new_mass_param_path
    when /the Review and Run page/ then visit review_path
  end
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end


Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in(arg1, :with => arg2)
end

# Reference: https://cassiomarques.wordpress.com/2009/01/23/how-to-test-file-uploads-with-cucumber/
# Reference: http://guides.rubyonrails.org/form_helpers.html

Given(/^I upload an xml file$/) do
  attach_file(:xml_file, File.join(Rails.root, 'features', 'upload-files', 'mass_xml.xml'))
end

Given(/^I upload a param file$/) do
  attach_file(:param_file, File.join(Rails.root, 'features', 'upload-files', 'mass_param.txt'))
end

Given(/^I upload a non-xml data file$/) do
  attach_file(:xml_file, File.join(Rails.root, 'features', 'upload-files', 'mass_data_bad.txt'))
end

Given(/^I upload a non-txt param file$/) do
  attach_file(:param_file, File.join(Rails.root, 'features', 'upload-files', 'mass_param_bad.xml'))
end



