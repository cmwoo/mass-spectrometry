require 'spec_helper'

describe ResultsController do

  describe "GET 'index'" do
    it "returns http success" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_params_id => 1, :mass_data_id => 1)
      user.stub(:current_result).and_return(result)

      get 'index'
      response.should be_success
      result.has_been_run?.should == true
    end
  end

  describe 'not displaying results' do
    it 'if there is not current result' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      user.stub(:current_result).and_return(nil)
      get 'index'
      flash[:warning].should == "Please upload files to run."
    end
    it 'if the data file has not been uploaded' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_params_id => 1)
      user.stub(:current_result).and_return(result)
      get 'index'
      flash[:warning].should == "Please upload files to run."
    end
    it 'if the params file has not been uploaded' do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1, :mass_data_id => 1)
      user.stub(:current_result).and_return(result)
      get 'index'
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
