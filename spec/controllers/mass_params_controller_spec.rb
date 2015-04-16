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
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.stub(:id).and_return(1)

      result2 = Result.create(:user_id => 1)
      user.stub(:current_result).and_return(result2)

      post :create, :s3_key => 'key'
      response.should redirect_to review_path
    end

    it "should not accept an empty file" do
      # fake_data = mock('MassData', :title => 'test_data.xml')
      # MassData.stub(:create!).with({:file => @dataxml}).and_return(fake_data)
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      post :create, :s3_key => nil, :email => @email
      response.should redirect_to new_mass_param_path
      flash[:warning].should == "No file input."
    end

    it "should create a new result result if necessary" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.stub(:id).and_return(1)
      user.should_receive(:current_result).and_return(nil)
      Result.should_receive(:create)

      post :create, :s3_key => 'key'
      response.should redirect_to review_path
    end

    it "should not accept nonexisting ids" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      
      post :update_params, :data_id => 100
      response.should redirect_to choose_params_path
      flash[:warning].should == "Please choose an existing params file."
    end

  #  it "should not upload a non xml file" do
  #    MassData.stub(:create!).with({:file => @dataother})
  #    post :uploadData, :upload => @dataother
  #    response.should redirect_to new_mass_datum_path
  #    flash[:notice].should == "test_data.txt is not a xml file."
  #  end
  end

end
