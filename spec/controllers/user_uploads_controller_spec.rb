require 'spec_helper'

describe UserUploadsController do

  describe "GET 'uploads'" do
    it "returns http success" do
      get 'uploads'
      response.should be_success
    end
  end

end
