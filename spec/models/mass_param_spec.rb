require 'spec_helper'

describe MassParam do
  describe "return the proper title" do
    it "should return the proper title" do
      mass_param = MassParam.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_param.txt", :user_id => 1)
      title = mass_param.get_title
      title.should == "mass_param.txt"
    end
  end

end
