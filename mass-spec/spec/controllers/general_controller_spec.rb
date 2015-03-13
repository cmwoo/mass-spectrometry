require 'spec_helper'

describe GeneralController do
  before :each do
    @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
    @paramstxt = fixture_file_upload('/files/test_params.txt', 'text/xml')
    #@dataother = fixture_file_upload('/files/test_data.txt', 'text/txt')
    #@paramsother = fixture_file_upload('/files/test_params.bad.txt', 'text/txt')
  end

	describe 'upload a mass data' do
    it "can upload a mass data xml file" do
      # fake_data = mock('MassData', :title => 'test_data.xml')
      # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      post :upload, :xml_file => @dataxml
      response.should redirect_to new_mass_param_path
      # flash[:notice].should == "test_data.xml was successfully uploaded."
    end

    it "should not upload a non xml file" do
  #    MassData.stub(:create!).with({:file => @dataother})
      post :uploadData, :upload => @dataother
      response.should redirect_to new_mass_datum_path
  #    flash[:notice].should == "test_data.txt is not a xml file."
    end
  end

	describe 'upload a param data' do
    it "can upload a valid mass param file" do
      # fake_data = mock('MassParams', :title => 'test_params.txt')
      # MassParams.stub(:create!).with({:file => @paramsxml}).and_return(fake_data)
      post :upload, :param_file => @paramstxt
      response.should redirect_to review_path
      # flash[:notice].should == "test_data.xml and test_params.xml was successfully uploaded."
    end

    it "should not upload a non xml file" do
#      MassParams.stub(:create!).with({:file => @paramsother})
      post :uploadParams, :upload => @paramsother
      response.should redirect_to new_mass_param_path
#      flash[:notice].should == "test_params.bad.txt is not a valid data file."
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end


end
