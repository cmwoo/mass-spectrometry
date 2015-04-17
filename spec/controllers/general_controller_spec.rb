require 'spec_helper'

describe GeneralController do

	describe 'download an executable file' do

		before :each do 
			@@file_downloads = ["test_executable.exe"]
			@@downloads_path = File.join(Rails.root, "spec", "fixtures", "files")
		end

		it "show warning when passed invalid file" do
			get :download_file, :file => 'missingfile.txt'
   			expect(response).to redirect_to(downloads_path)
    		expect(flash[:warning]).to be_present
		end

		it "can download an existing file" do
			get :download_file, :file => 'test_executable.exe'
			expect(response.status).to eq(200)
		end


	end
#   before :each do
#     @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
#     @paramsxml = fixture_file_upload('/files/test_params.txt', 'text/xml')
#     #@dataother = fixture_file_upload('/files/test_data.txt', 'text/txt')
#     #@paramsother = fixture_file_upload('/files/test_params.bad.txt', 'text/txt')
#   end

# 	describe 'upload a mass data' do
#     it "can upload a mass data xml file" do
#       # fake_data = mock('MassData', :title => 'test_data.xml')
#       # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
#       post :upload, :xml_file => @dataxml
#       response.should redirect_to new_mass_param_path
#       # flash[:notice].should == "test_data.xml was successfully uploaded."
#     end

#   #  it "should not upload a non xml file" do
#   #    MassData.stub(:create!).with({:file => @dataother})
#   #    post :uploadData, :upload => @dataother
#   #    response.should redirect_to new_mass_datum_path
#   #    flash[:notice].should == "test_data.txt is not a xml file."
#   #  end
#   end

# 	describe 'upload a param data' do
#     it "can upload a valid mass param file" do
#       # fake_data = mock('MassParams', :title => 'test_params.xml')
#       # MassParams.stub(:create!).with({:file => @paramsxml}).and_return(fake_data)
#       post :upload, :param_file => @paramsxml
#       response.should redirect_to review_path
#       # flash[:notice].should == "test_data.xml and test_params.xml was successfully uploaded."
#     end

# #    it "should not upload a non xml file" do
# #      MassParams.stub(:create!).with({:file => @paramsother})
# #      post :uploadParams, :upload => @paramsother
# #      response.should redirect_to new_mass_param_path
# #      flash[:notice].should == "test_params.bad.txt is not a valid data file."
# #    end
#   end

#   describe "GET 'index'" do
#     it "returns http success" do
#       get 'index'
#       response.should be_success
#     end
#   end

  describe "test finish" do
    it "should call ssh function" do
      r = double("Result")
      Result.stub(:delay).and_return(r)
      r.should_receive(:start_ssh)
      post :finish
    end
  end

end
