require 'spec_helper'

describe ResultsController do

  describe "POST 'finish'" do
    it "returns http success" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_params_id => 1, :mass_data_id => 1)
      user.stub(:current_result).and_return(result)
      result.stub(:start_ssh)

      post 'finish'
      response.should redirect_to finish_index_path
      result.has_been_run?.should == true
    end
  end

  describe 'not displaying results' do
    it 'if there is not current result' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_params_id => nil, :mass_data_id => nil)
      user.stub(:current_result).and_return(result)
      result.stub(:start_ssh)

      post 'finish'
      flash[:warning].should == "Please upload files to run."
    end
    it 'if the data file has not been uploaded' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_params_id => 1)
      user.stub(:current_result).and_return(result)
      result.stub(:start_ssh)

      post 'finish'
      flash[:warning].should == "Please upload files to run."
    end
    it 'if the params file has not been uploaded' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_data_id => 1)
      user.stub(:current_result).and_return(result)
      result.stub(:start_ssh)
      
      post 'finish'
      flash[:warning].should == "Please upload files to run."
    end
  end

  describe 'test review page' do
    it 'should tell you if no files have been uploaded' do
      user = double('user', :current_result => nil)
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      get 'review'
      flash[:warning].should == "No files have been uploaded."
    end

    it 'should tell you if no data has been uploaded' do
      res = double('result')
      user = double('user', :current_result => res)
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      res.stub(:mass_params_id).and_return(1)
      res.stub(:mass_data_id).and_return(nil)

      get 'review'
      flash[:warning].should == "One of the files has not been uploaded."
    end

  end


end
