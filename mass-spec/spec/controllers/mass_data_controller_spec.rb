require 'spec_helper'

describe MassDataController do
  before :each do
    @dataxml = fixture_file_upload('files/test_data.xml', 'text/xml')
    @dataother = fixture_file_upload('files/test_data.txt', 'text/txt')
  end

	describe 'upload a mass data' do
    it "can upload a mass data xml file" do
      fake_data = mock('MassData', :title => 'test_data.xml')
      MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      post :uploadData, :upload => @dataxml
      response.should redirect_to new_mass_param
      flash[:notice].should == "test_data.xml was successfully uploaded."
    end

    it "should not upload a non xml file"
      MassData.stub(:create!).with({:file => @dataother})
      post :uploadData, :upload => @dataother
      response.should redirect_to new_mass_datum
      flash[:notice].should == "test_data.txt is not a xml file."
    end
  end

end
