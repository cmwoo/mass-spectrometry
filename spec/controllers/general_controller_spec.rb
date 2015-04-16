require 'spec_helper'

describe GeneralController do

  describe "test finish" do
    it "should call ssh function" do
      r = double("Result")
      Result.stub(:delay).and_return(r)
      r.should_receive(:start_ssh)
      post :finish
    end
  end

end
