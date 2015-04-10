require 'spec_helper'

describe UserUploadsController do

  describe "GET 'uploads'" do
    it "returns http success" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.stub(:results)
      get 'uploads'
      response.should be_success
    end
  end

  describe "view uploads" do
    it "should call current_user.results" do
      user = double('user')
      resultslist = [double('results1'), double('results2')]
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
      user.should_receive(:results).and_return(resultslist)
      get 'uploads'
    end
  end

end
