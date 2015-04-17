require 'spec_helper'

describe MassDatum do

#  before :each do
#    @dataxml = fixture_file_upload('/files/test_data.xml', 'text/xml')
#    @dataother = fixture_file_upload('/files/test_data.txt', 'text/txt')
#  end

#  describe "create data" do
#    it "should create a valid MassData with a xml file" do
#      data = MassData.create!({:file => @dataxml})
#      data.should be_valid
#      data.title.should == 'test_data.xml'
#    end

#    it "should fail if create a non xml file" do
#      data = MassData.new({:file => @dataother})
#      data.should_not be_valid
#    end 
#  end

  describe "return the proper title" do
    it "should return the proper title" do
      mass_datum = MassDatum.create(:s3id => "uploads/21998eeb-ed54-4914-9844-7a4b94008985/mass_data.xml", :user_id => 1)
      title = mass_datum.get_title
      title.should == "mass_data.xml"
    end
  end
end
