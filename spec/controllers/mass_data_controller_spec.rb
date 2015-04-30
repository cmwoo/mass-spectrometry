require 'spec_helper'

describe MassDataController do

  before :each do
    @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
    @paramsxml = fixture_file_upload('/files/test_params.txt', 'text/xml')
  end

  describe 'upload a mass data' do
    it "can upload a mass data xml file" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.stub(:id).and_return(1)

      user.stub(:current_result).and_return(nil)

      post :create, :s3_key => 'key'
      response.should redirect_to new_mass_param_path
    end

    it "should not accept an empty file" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      
      post :create, :s3_key => nil
      response.should redirect_to new_mass_datum_path
      flash[:warning].should == "No file input."
    end

    it "can update an existing result" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.stub(:id).and_return(1)

      result = Result.create(:user_id => 1, :mass_params_id => 1)
      user.stub(:current_result).and_return(result)
      result.should_receive(:mass_data_id)

      post :create, :s3_key => 'key'
      response.should redirect_to new_mass_param_path
    end

    it "should not accept nonexisting ids" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      
      post :update_choice, :data_id => 100
      response.should redirect_to choose_data_path
      flash[:warning].should == "Please choose an existing .mzxml file."
    end
    
    it "should tell you if you have already uploaded a file" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      r = double('result')
      d = double('mass_data')
      user.stub(:current_result).and_return(r)
      r.stub(:get_mass_data).and_return(d)
      d.stub(:get_title).and_return("title.txt")
      user.stub(:id).and_return(1)

      get :new
      expect(response.status).to eq(200)
    end

    it "should tell you if you have not uploaded a file yet" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      r = double('result')
      d = double('mass_data')
      user.stub(:current_result).and_return(r)
      r.stub(:get_mass_data).and_return(nil)
      user.stub(:id).and_return(1)

      get :new
      expect(response.status).to eq(200)
    end

    it "should allow you to choose an already existing file" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      d = double('mass_data')
      r = double('result')

      MassDatum.stub(:where).and_return(d)
      user.stub(:results).and_return(r)
      user.stub(:current_result).and_return(r)
      r.stub(:get_mass_data).and_return(d)
      user.stub(:id).and_return(1)
      d.stub(:get_title).and_return("title.txt")

      get :choose
      expect(response.status).to eq(200)
    end

    it "should allow you to upload a file if you haven't chosen one yet" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      d = double('mass_data')
      r = double('result')

      MassDatum.stub(:where).and_return(d)
      user.stub(:results).and_return(r)
      user.stub(:current_result).and_return(nil)
      r.stub(:get_mass_data).and_return(d)
      user.stub(:id).and_return(1)

      get :choose
      expect(response.status).to eq(200)
    end


  end

end
