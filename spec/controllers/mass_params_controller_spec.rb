require 'spec_helper'

describe MassParamsController do

before :each do
    @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
    @email = "example@example.com"
    @paramsxml = fixture_file_upload('/files/test_params.txt', 'text/xml')
    #@dataother = fixture_file_upload('/files/test_data.txt', 'text/txt')
    #@paramsother = fixture_file_upload('/files/test_params.bad.txt', 'text/txt')
  end

	describe 'upload a mass data' do
    it "can upload a param file" do
      # fake_data = mock('MassData', :title => 'test_data.xml')
      # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      post :upload, :param_file => @paramsxml
      response.should redirect_to review_path
    end

    it "should not accept an empty file" do
      # fake_data = mock('MassData', :title => 'test_data.xml')
      # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      post :upload, :xml_file => nil, :email => @email
      response.should redirect_to new_mass_param_path
      flash[:warning].should == "No file input."
    end



  #  it "should not upload a non xml file" do
  #    MassData.stub(:create!).with({:file => @dataother})
  #    post :uploadData, :upload => @dataother
  #    response.should redirect_to new_mass_datum_path
  #    flash[:notice].should == "test_data.txt is not a xml file."
  #  end
  end

end
