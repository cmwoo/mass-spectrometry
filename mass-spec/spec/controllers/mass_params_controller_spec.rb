require 'spec_helper'

describe MassParamsController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

	before :each do
    @paramsxml = fixture_file_upload('files/test_params.xml', 'text/xml')
    @dataother = fixture_file_upload('files/test_params.bad.txt', 'text/txt')
  end

	describe 'upload a param data' do
    it "can upload a valid mass param file" do
      fake_data = mock('MassParams', :title => 'test_params.xml')
      MassParams.stub(:create!).with({:file => @paramsxml}).and_return(fake_data)
      post :uploadParams, :upload => @paramsxml
      response.should redirect_to review
      flash[:notice].should == "test_data.xml and test_params.xml was successfully uploaded."
    end

    it "should not upload a non xml file"
      MassParams.stub(:create!).with({:file => @paramsother})
      post :uploadParams, :upload => @paramsother
      response.should redirect_to new_mass_param
      flash[:notice].should == "test_params.bad.txt is not a valid data file."
    end
  end

end
