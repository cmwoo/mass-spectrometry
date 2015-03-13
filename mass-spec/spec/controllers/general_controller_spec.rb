require 'spec_helper'

describe GeneralController do
  before :each do
    @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
    @paramstxt = fixture_file_upload('/files/test_params.txt', 'text/txt')
    @dataother = fixture_file_upload('/files/test_data_bad.txt', 'text/txt')
    @paramsother = fixture_file_upload('/files/test_params_bad.xml', 'text/xml')
  end

	describe 'Uploading a mass data' do
    it "can upload a mass data xml file" do
      # fake_data = mock('MassData', :title => 'test_data.xml')
      # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      post :upload, :xml_file => @dataxml
      response.should redirect_to new_mass_param_path
      # flash[:notice].should == "test_data.xml was successfully uploaded."
    end

    it "should not upload a non xml file" do
  #    MassData.stub(:create!).with({:file => @dataother})
      post :upload, :xml_file => @dataother
      response.should redirect_to new_mass_datum_path
  #    flash[:notice].should == "test_data_bad.txt is not a xml file."
    end
  end

	describe 'Uploading a param data' do
    it "can upload a mass param txt file" do
      # fake_data = mock('MassParams', :title => 'test_params.txt')
      # MassParams.stub(:create!).with({:file => @paramsxml}).and_return(fake_data)
      post :upload, :param_file => @paramstxt
      response.should redirect_to review_path
      # flash[:notice].should == "test_data.xml and test_params.txt was successfully uploaded."
    end

    it "should not upload a non txt file" do
#      MassParams.stub(:create!).with({:file => @paramsother})
      post :upload, :param_file => @paramsother
      response.should redirect_to new_mass_param_path
#      flash[:notice].should == "test_params_bad.xml is not a txt params file."
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end


end
