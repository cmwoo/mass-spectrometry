require 'spec_helper'

describe MassParam do

#  before :each do
#    @paramsxml = fixture_file_upload('/files/test_params.txt', 'text/xml')
#    @paramsother = fixture_file_upload('/files/test_params.bad.txt', 'text/txt')
#  end

#  describe "create data" do
#    it "should create a valid MassData with a xml file" do
#      data = MassParams.create!({:file => @paramsxml})
#      data.should be_valid
#      data.title.should == 'test_params.xml'
#    end

#    it "should fail if create a non xml file" do
#      data = MassParams.new({:file => @paramsother})
#      data.should_not be_valid
#    end 
#  end

  describe "return the proper title" do
    it "should return the proper title" do
      mass_param = MassParam.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_param.txt", :user_id => 1)
      title = mass_param.get_title
      title.should == "mass_param.txt"
    end
  end

end
