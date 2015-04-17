
#instead of web_steps and paths
When /^(?:|I )(?:should be|am) on (.+)$/ do |page_name|
  case page_name
    when /the Upload XML page/ then visit new_mass_datum_path
    when /the Upload Parameters page/ then visit new_mass_param_path
    when /the Review and Run page/ then visit review_path
    when /the downloads page/ then visit downloads_path
		when /^the signup page$/ then visit new_user_registration_path
    when /^the login page$/ then visit user_session_path
    when /^the home page$/ then visit root_path
    when /^the edit profile page$/ then visit edit_user_registration_path
    when /^the user information page$/ then visit uploads_path
  end
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button(arg1)
end


Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in(arg1, :with => arg2)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

# Reference: https://cassiomarques.wordpress.com/2009/01/23/how-to-test-file-uploads-with-cucumber/
# Reference: http://guides.rubyonrails.org/form_helpers.html

Given(/^I upload an xml file$/) do
  attach_file(:xml_file, File.join(Rails.root, 'features', 'upload-files', 'mass_xml.mzXML'))
end

Given(/^I upload a param file$/) do
  attach_file(:param_file, File.join(Rails.root, 'features', 'upload-files', 'mass_param.txt'))
end


And /^I upload a file with an incorrect file type$/ do
  if current_path == "/mass_data/new"
    file_input_id = :xml_file
  elsif current_path == "/mass_params/new"
    file_input_id = :param_file
  else
    throw :TypeError, "current path not recognized as a file upload page"
  end
  attach_file(file_input_id, File.join(Rails.root, 'features', 'upload-files', 'bad_file.bad'))
end

Given /^the following accounts exist:$/ do |table|
  table.hashes.each do |attributes|
    User.create!(attributes)
  end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Given(/^the following results \- params \- data files exist for the user$/) do |table|
  table.hashes.each do |attributes|
    mass_datum = MassDatum.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/"+attributes[:data], :user_id => 1)
    mass_param = MassParam.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008fff/"+attributes[:params], :user_id => 1)
    result = Result.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94cb285/"+attributes[:results], :mass_params_id => mass_param.id, :mass_data_id => mass_datum.id, :user_id => 1, :flag => true)
  end
end


Given /^I am logged in/ do
  step 'I am on the home page'
  step 'I follow "Login"'
  step 'I fill in "user_email" with "chemist@gmail.com"'
  step 'I fill in "user_password" with "aaaaaaaa"'
  step 'I press "Log in"'
end

When /^I visit the (.*?) page$/ do |page_name|
  case page_name
    when /the Upload XML page/ then visit new_mass_datum_path
    when /the Upload Parameters page/ then visit new_mass_param_path
  end
end

Then(/^I should see a list of all my data, params, and results$/) do
  step 'I should see "Data"'
  step 'I should see "Params"'
  step 'I should see "Results"'
  step 'I should see "Submission Date"'
  table_count = page.all("table tr").count
  db_count = User.find(1).results.count + 1
  assert(table_count == db_count, table_count.to_s + " does not equal " + db_count.to_s)
end

Given(/^I see a list of existing parameters files/) do
  table_count = page.all("input[type='radio']").count
  db_count = MassParam.where(:user_id => 1).count
  assert(table_count == db_count, table_count.to_s + " does not equal " + db_count.to_s)
end

Given(/^I see a list of existing data xml files/) do
  table_count = page.all("input[type='radio']").count
  db_count = MassDatum.where(:user_id => 1).count
  assert(table_count == db_count, table_count.to_s + " does not equal " + db_count.to_s)
end

Given (/^I select an option/) do
  choose('data_id_1')
end

Given(/^I upload an xml and param file$/) do
  mass_datum = MassDatum.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_data.xml", :user_id => 1)
  mass_param = MassParam.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008fff/mass_params.txt", :user_id => 1)
  result = Result.create(:s3id => nil, :mass_params_id => mass_param.id, :mass_data_id => mass_datum.id, :user_id => 1, :flag => false)
end

Given(/^I upload just an xml file$/) do
  mass_datum = MassDatum.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_data.xml", :user_id => 1)
  result = Result.create(:s3id => nil, :mass_data_id => mass_datum.id, :user_id => 1, :flag => false)
end

Given(/^I upload just a param file$/) do
  mass_param = MassParam.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008fff/mass_params.txt", :user_id => 1)
  result = Result.create(:s3id => nil, :mass_params_id => mass_param.id, :user_id => 1, :flag => false)
end


Given(/^I should see the files I uploaded$/) do
  step 'I should see "mass_data.xml"'
  step 'I should see "mass_params.txt"'
end


Then /^I should receive the file "(.*)"$/ do |filename|
  result = page.response_headers['Content-Type'].should == "application/octet-stream"
  if result
    result = page.response_headers['Content-Disposition'].should =~ /attachment; filename="#{filename}"/
  end
  result
end

Given /^I am not on the home page/ do
  visit citations_path
end

Given /^I click on the icon/ do
  click_link("Icon")
end
