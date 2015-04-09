require 'spec_helper'

describe ResultsController do

  describe "GET 'index'" do
    it "returns http success" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }

      result = Result.create(:user_id => 1)
      user.stub(:current_result).and_return(result)

      get 'index'
      response.should be_success
    end
  end

end
