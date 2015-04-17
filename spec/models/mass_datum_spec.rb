require 'spec_helper'

describe MassDatum do
  describe "return the proper title" do
    it "should return the proper title" do
      mass_datum = MassDatum.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_data.xml", :user_id => 1)
      title = mass_datum.get_title
      title.should == "mass_data.xml"
    end
  end
end
