require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "Getting Related Files" do
    before :each do
      @mass_result  = Result.create(:user_id => 1, :flag => true)
      @mass_result2  = Result.create(:user_id => 1, :flag => true)
      @mass_result3  = Result.create(:user_id => 1, :flag => false)
      @user = User.create!(:email => "Chell@Aperture.com", :password => "thecakeisalie", :password_confirmation =>"thecakeisalie")
    end
    it "should return the most current result" do
      @user.current_result.should == @mass_result3
    end
  end
end
