
#instead of web_steps and paths
When /^(?:|I )(?:should be|am) on (.+)$/ do |page_name|
  case page_name
    when /the Upload XML page/ then visit '/mass_data'
    when /the Upload Parameters page/ then visit '/mass_params'
    when /the Review and Run page/ then visit '/review'
  end
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button(button)
end


Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in(arg1, :with => arg2)
end

# Reference: https://cassiomarques.wordpress.com/2009/01/23/how-to-test-file-uploads-with-cucumber/
# Reference: http://guides.rubyonrails.org/form_helpers.html

Given(/^I upload a proper xml file$/) do
  attatch_file(:xml_file, File.join(RAILS_ROOT, 'features', 'upload-files', 'good_xml.xml'))
end

Given(/^I upload an incorrect xml file$/) do
  attatch_file(:xml_file, File.join(RAILS_ROOT, 'features', 'upload-files', 'bad_xml.xml'))
end

Given(/^I upload a proper param file$/) do
  attatch_file(:param_file, File.join(RAILS_ROOT, 'features', 'upload-files', 'good_param.txt'))
end

Given(/^I upload an incorrect param file$/) do
  attatch_file(:param_file, File.join(RAILS_ROOT, 'features', 'upload-files', 'bad_param.txt'))
end

